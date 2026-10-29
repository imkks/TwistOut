import 'package:flutter/services.dart';

/// Abstract interface for game audio.
abstract class AudioService {
  bool get isSfxEnabled;
  bool get isMusicEnabled;

  void setSfxEnabled(bool enabled);
  void setMusicEnabled(bool enabled);

  void playTap();
  void playUnscrew();
  void playBoxFilled();
  void playPlateFall();
  void playBooster();
  void playWin();
  void playLose();
}

/// Lightweight audio implementation with system feedback fallback.
class SystemAudioService implements AudioService {
  bool _sfxEnabled = true;
  bool _musicEnabled = true;

  @override
  bool get isSfxEnabled => _sfxEnabled;

  @override
  bool get isMusicEnabled => _musicEnabled;

  @override
  void setSfxEnabled(bool enabled) {
    _sfxEnabled = enabled;
  }

  @override
  void setMusicEnabled(bool enabled) {
    _musicEnabled = enabled;
  }

  @override
  void playTap() {
    if (!_sfxEnabled) return;
    SystemSound.play(SystemSoundType.click);
  }

  @override
  void playUnscrew() {
    if (!_sfxEnabled) return;
    SystemSound.play(SystemSoundType.click);
  }

  @override
  void playBoxFilled() {
    if (!_sfxEnabled) return;
    SystemSound.play(SystemSoundType.click);
  }

  @override
  void playPlateFall() {
    if (!_sfxEnabled) return;
    SystemSound.play(SystemSoundType.click);
  }

  @override
  void playBooster() {
    if (!_sfxEnabled) return;
    SystemSound.play(SystemSoundType.click);
  }

  @override
  void playWin() {
    if (!_sfxEnabled) return;
    SystemSound.play(SystemSoundType.click);
  }

  @override
  void playLose() {
    if (!_sfxEnabled) return;
    SystemSound.play(SystemSoundType.click);
  }
}

/// Fake audio service for testing.
class FakeAudioService implements AudioService {
  @override
  bool isSfxEnabled = true;

  @override
  bool isMusicEnabled = true;

  final List<String> playedSounds = <String>[];

  @override
  void setSfxEnabled(bool enabled) => isSfxEnabled = enabled;

  @override
  void setMusicEnabled(bool enabled) => isMusicEnabled = enabled;

  @override
  void playTap() => playedSounds.add('tap');

  @override
  void playUnscrew() => playedSounds.add('unscrew');

  @override
  void playBoxFilled() => playedSounds.add('boxFilled');

  @override
  void playPlateFall() => playedSounds.add('plateFall');

  @override
  void playBooster() => playedSounds.add('booster');

  @override
  void playWin() => playedSounds.add('win');

  @override
  void playLose() => playedSounds.add('lose');
}
