import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/levels/level_data.dart';
import '../domain/model/elements.dart';
import '../domain/model/game_state.dart';
import '../domain/rules/commands.dart';
import '../domain/rules/events.dart';
import '../domain/rules/reducer.dart';
import '../services/audio_service.dart';
import '../services/haptics_service.dart';
import '../services/storage_service.dart';

// Services Providers
final audioServiceProvider = Provider<AudioService>((ref) {
  return SystemAudioService();
});

final hapticsServiceProvider = Provider<HapticsService>((ref) {
  return DeviceHapticsService();
});

final storageServiceProvider = Provider<StorageService>((ref) {
  return InMemoryStorageService();
});

// Player Save Data Notifier
class PlayerNotifier extends Notifier<PlayerSaveData> {
  @override
  PlayerSaveData build() {
    return const PlayerSaveData();
  }

  void completeLevel(int levelId, int stars, int coinsAwarded) {
    final updatedStars = Map<int, int>.from(state.levelStars);
    if (!updatedStars.containsKey(levelId) || updatedStars[levelId]! < stars) {
      updatedStars[levelId] = stars;
    }
    final nextLevel = levelId + 1;
    final nextUnlocked = nextLevel > state.highestUnlockedLevel
        ? nextLevel
        : state.highestUnlockedLevel;

    state = state.copyWith(
      highestUnlockedLevel: nextUnlocked,
      coins: state.coins + coinsAwarded,
      levelStars: updatedStars,
    );
  }

  void consumeBooster(BoosterType type) {
    switch (type) {
      case BoosterType.extraSlot:
        if (state.extraSlotBoosters > 0) {
          state = state.copyWith(extraSlotBoosters: state.extraSlotBoosters - 1);
        }
      case BoosterType.magnet:
        if (state.magnetBoosters > 0) {
          state = state.copyWith(magnetBoosters: state.magnetBoosters - 1);
        }
      case BoosterType.smash:
        if (state.smashBoosters > 0) {
          state = state.copyWith(smashBoosters: state.smashBoosters - 1);
        }
    }
  }

  void addBooster(BoosterType type, int count) {
    switch (type) {
      case BoosterType.extraSlot:
        state = state.copyWith(
            extraSlotBoosters: state.extraSlotBoosters + count);
      case BoosterType.magnet:
        state = state.copyWith(magnetBoosters: state.magnetBoosters + count);
      case BoosterType.smash:
        state = state.copyWith(smashBoosters: state.smashBoosters + count);
    }
  }

  void toggleSfx() {
    state = state.copyWith(sfxEnabled: !state.sfxEnabled);
    ref.read(audioServiceProvider).setSfxEnabled(state.sfxEnabled);
  }

  void toggleMusic() {
    state = state.copyWith(musicEnabled: !state.musicEnabled);
    ref.read(audioServiceProvider).setMusicEnabled(state.musicEnabled);
  }

  void toggleHaptics() {
    state = state.copyWith(hapticsEnabled: !state.hapticsEnabled);
    ref.read(hapticsServiceProvider).setEnabled(state.hapticsEnabled);
  }

  void toggleColourblind() {
    state = state.copyWith(colourblindMode: !state.colourblindMode);
  }
}

final playerProvider =
    NotifierProvider<PlayerNotifier, PlayerSaveData>(PlayerNotifier.new);

// Active Game Controller
class GameController extends Notifier<GameState> {
  int _currentLevel = 1;
  int get currentLevel => _currentLevel;

  @override
  GameState build() {
    return LevelCatalog.getLevel(1).buildInitialState();
  }

  void loadLevel(int levelNumber) {
    _currentLevel = levelNumber;
    state = LevelCatalog.getLevel(levelNumber).buildInitialState();
  }

  void tapScrew(String screwId) {
    final audio = ref.read(audioServiceProvider);
    final haptics = ref.read(hapticsServiceProvider);

    final result = step(state, TapScrew(screwId));
    state = result.state;

    // React to events
    for (final event in result.events) {
      switch (event) {
        case ScrewLifted():
          audio.playUnscrew();
          haptics.lightImpact();
        case ScrewMovedToBox():
          audio.playTap();
          haptics.selectionClick();
        case ScrewMovedToTray():
          audio.playTap();
          haptics.selectionClick();
        case BoxCleared():
          audio.playBoxFilled();
          haptics.mediumImpact();
        case PlateFell():
          audio.playPlateFall();
          haptics.mediumImpact();
        case Won():
          audio.playWin();
          haptics.success();
          final stars =
              state.trayPeak <= 3 ? 3 : (state.trayPeak <= 4 ? 2 : 1);
          ref
              .read(playerProvider.notifier)
              .completeLevel(_currentLevel, stars, 20);
        case Lost():
          audio.playLose();
          haptics.error();
        case ScrewRejected():
          haptics.error();
        default:
          break;
      }
    }
  }

  void useBooster(BoosterType type, [String? targetId]) {
    final player = ref.read(playerProvider);
    final hasInventory = switch (type) {
      BoosterType.extraSlot => player.extraSlotBoosters > 0,
      BoosterType.magnet => player.magnetBoosters > 0,
      BoosterType.smash => player.smashBoosters > 0,
    };

    if (!hasInventory) return;

    ref.read(playerProvider.notifier).consumeBooster(type);
    ref.read(audioServiceProvider).playBooster();
    ref.read(hapticsServiceProvider).heavyImpact();

    final result = step(state, UseBooster(type, targetId));
    state = result.state;
  }

  void revive() {
    ref.read(audioServiceProvider).playBooster();
    ref.read(hapticsServiceProvider).success();
    final result = step(state, const GrantTraySlots(3));
    state = result.state;
  }

  void restart() {
    loadLevel(_currentLevel);
  }
}

final gameControllerProvider =
    NotifierProvider<GameController, GameState>(GameController.new);
