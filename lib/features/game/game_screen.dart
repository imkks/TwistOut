import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../domain/levels/level_data.dart';
import '../../domain/model/elements.dart';
import '../../game/board_widget.dart';
import 'widgets/booster_bar.dart';
import 'widgets/box_bar.dart';
import 'widgets/game_hud.dart';
import 'widgets/game_modals.dart';
import 'widgets/tray_bar.dart';

/// The active game puzzle screen (UI_UX.md Section 3 & 5.2).
class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({
    super.key,
    required this.levelNumber,
    required this.onBackToHome,
    required this.onGoToLevel,
  });

  final int levelNumber;
  final VoidCallback onBackToHome;
  final void Function(int nextLevel) onGoToLevel;

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  bool _dialogShown = false;

  @override
  Widget build(BuildContext context) {
    final levelDef = LevelCatalog.getLevel(widget.levelNumber);
    final gameState = ref.watch(gameControllerProvider(widget.levelNumber));
    final controller = ref.read(gameControllerProvider(widget.levelNumber).notifier);
    final player = ref.watch(playerProvider);

    // Listen for game end conditions
    ref.listen(gameControllerProvider(widget.levelNumber), (previous, next) {
      if (!_dialogShown) {
        if (next.status == GameStatus.won) {
          _dialogShown = true;
          _showWinDialog(context);
        } else if (next.status == GameStatus.lost) {
          _dialogShown = true;
          _showFailDialog(context, controller);
        }
      }
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [GameColors.world1BgStart, GameColors.world1BgEnd],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top HUD
              GameHud(
                levelNumber: widget.levelNumber,
                levelTitle: levelDef.title,
                coins: player.coins,
                isHard: levelDef.isHard,
                isChill: levelDef.isChill,
                onPauseTap: () => _showPauseDialog(context, controller),
              ),

              // Active Boxes & Queue
              BoxBar(
                activeBoxes: gameState.activeBoxes,
                boxQueue: gameState.boxQueue,
              ),

              // Interactive Game Board Area
              Expanded(
                child: BoardWidget(
                  gameState: gameState,
                  showColorblindSymbols: player.colourblindMode,
                  onScrewTapped: controller.tapScrew,
                ),
              ),

              // Tray Slots
              TrayBar(tray: gameState.tray),

              // Boosters
              BoosterBar(
                extraSlots: player.extraSlotBoosters,
                magnets: player.magnetBoosters,
                smashes: player.smashBoosters,
                onUseBooster: controller.useBooster,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showWinDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => WinDialog(
        stars: 3,
        coinsEarned: 20,
        onNextLevel: () {
          Navigator.of(ctx).pop();
          _dialogShown = false;
          widget.onGoToLevel(widget.levelNumber + 1);
        },
        onHome: () {
          Navigator.of(ctx).pop();
          _dialogShown = false;
          widget.onBackToHome();
        },
      ),
    );
  }

  void _showFailDialog(BuildContext context, GameController controller) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => FailDialog(
        onRevive: () {
          Navigator.of(ctx).pop();
          _dialogShown = false;
          controller.revive();
        },
        onRestart: () {
          Navigator.of(ctx).pop();
          _dialogShown = false;
          controller.restart();
        },
        onHome: () {
          Navigator.of(ctx).pop();
          _dialogShown = false;
          widget.onBackToHome();
        },
      ),
    );
  }

  void _showPauseDialog(BuildContext context, GameController controller) {
    showDialog<void>(
      context: context,
      builder: (ctx) => PauseDialog(
        onResume: () => Navigator.of(ctx).pop(),
        onRestart: () {
          Navigator.of(ctx).pop();
          controller.restart();
        },
        onHome: () {
          Navigator.of(ctx).pop();
          widget.onBackToHome();
        },
      ),
    );
  }
}
