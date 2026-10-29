import 'package:flutter/services.dart';

/// Abstract interface for haptic feedback.
abstract class HapticsService {
  bool get isEnabled;
  void setEnabled(bool enabled);

  void selectionClick();
  void lightImpact();
  void mediumImpact();
  void heavyImpact();
  void success();
  void error();
}

/// Device haptics implementation using Flutter services.
class DeviceHapticsService implements HapticsService {
  bool _enabled = true;

  @override
  bool get isEnabled => _enabled;

  @override
  void setEnabled(bool enabled) {
    _enabled = enabled;
  }

  @override
  void selectionClick() {
    if (!_enabled) return;
    HapticFeedback.selectionClick();
  }

  @override
  void lightImpact() {
    if (!_enabled) return;
    HapticFeedback.lightImpact();
  }

  @override
  void mediumImpact() {
    if (!_enabled) return;
    HapticFeedback.mediumImpact();
  }

  @override
  void heavyImpact() {
    if (!_enabled) return;
    HapticFeedback.heavyImpact();
  }

  @override
  void success() {
    if (!_enabled) return;
    HapticFeedback.mediumImpact();
  }

  @override
  void error() {
    if (!_enabled) return;
    HapticFeedback.heavyImpact();
  }
}

/// Fake haptics service for testing.
class FakeHapticsService implements HapticsService {
  @override
  bool isEnabled = true;

  final List<String> feedbackEvents = <String>[];

  @override
  void setEnabled(bool enabled) => isEnabled = enabled;

  @override
  void selectionClick() => feedbackEvents.add('selection');

  @override
  void lightImpact() => feedbackEvents.add('light');

  @override
  void mediumImpact() => feedbackEvents.add('medium');

  @override
  void heavyImpact() => feedbackEvents.add('heavy');

  @override
  void success() => feedbackEvents.add('success');

  @override
  void error() => feedbackEvents.add('error');
}
