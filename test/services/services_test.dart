import 'package:flutter_test/flutter_test.dart';
import 'package:twist_out/services/audio_service.dart';
import 'package:twist_out/services/haptics_service.dart';
import 'package:twist_out/services/storage_service.dart';

void main() {
  group('Fake Services Tests', () {
    test('FakeAudioService records sound events', () {
      final audio = FakeAudioService();
      expect(audio.isSfxEnabled, isTrue);
      expect(audio.isMusicEnabled, isTrue);

      audio.playTap();
      audio.playUnscrew();
      audio.playBoxFilled();
      audio.playPlateFall();
      audio.playWin();

      expect(audio.playedSounds, containsAll(['tap', 'unscrew', 'boxFilled', 'plateFall', 'win']));

      audio.setSfxEnabled(false);
      expect(audio.isSfxEnabled, isFalse);
    });

    test('FakeHapticsService records haptic feedback', () {
      final haptics = FakeHapticsService();
      expect(haptics.isEnabled, isTrue);

      haptics.lightImpact();
      haptics.mediumImpact();
      haptics.heavyImpact();
      haptics.success();
      haptics.error();

      expect(haptics.feedbackEvents, ['light', 'medium', 'heavy', 'success', 'error']);

      haptics.setEnabled(false);
      expect(haptics.isEnabled, isFalse);
    });

    test('InMemoryStorageService saves and loads player state', () async {
      final storage = InMemoryStorageService();
      final initial = await storage.loadSaveData();
      expect(initial.currentLevel, 1);
      expect(initial.coins, 150);

      final updated = initial.copyWith(
        currentLevel: 3,
        coins: 200,
        levelStars: {1: 3, 2: 2},
      );
      await storage.saveSaveData(updated);

      final loaded = await storage.loadSaveData();
      expect(loaded.currentLevel, 3);
      expect(loaded.coins, 200);
      expect(loaded.levelStars[1], 3);
      expect(loaded.levelStars[2], 2);

      // JSON round trip
      final json = loaded.toJson();
      final fromJson = PlayerSaveData.fromJson(json);
      expect(fromJson.coins, loaded.coins);
      expect(fromJson.currentLevel, loaded.currentLevel);
      expect(fromJson.levelStars, loaded.levelStars);
    });
  });
}
