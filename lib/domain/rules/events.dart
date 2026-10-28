import 'package:twist_out/domain/model/elements.dart';

/// Reason why a tap was rejected.
enum RejectionReason {
  screwNotFound,
  screwBlocked,
  trayFull,
  gameNotPlaying,
}

/// Sealed base class for events emitted by the rules reducer.
sealed class GameEvent {
  const GameEvent();
}

/// A screw was lifted from the board.
final class ScrewLifted extends GameEvent {
  final Screw screw;

  const ScrewLifted(this.screw);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is ScrewLifted && other.screw == screw);

  @override
  int get hashCode => screw.hashCode;

  @override
  String toString() => 'ScrewLifted(${screw.id})';
}

/// A screw flew directly into an active box.
final class ScrewMovedToBox extends GameEvent {
  final Screw screw;
  final int boxIndex;

  const ScrewMovedToBox(this.screw, this.boxIndex);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScrewMovedToBox &&
          other.screw == screw &&
          other.boxIndex == boxIndex);

  @override
  int get hashCode => Object.hash(screw, boxIndex);

  @override
  String toString() => 'ScrewMovedToBox(${screw.id} -> box $boxIndex)';
}

/// A screw was placed into a tray slot.
final class ScrewMovedToTray extends GameEvent {
  final Screw screw;
  final int trayIndex;

  const ScrewMovedToTray(this.screw, this.trayIndex);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScrewMovedToTray &&
          other.screw == screw &&
          other.trayIndex == trayIndex);

  @override
  int get hashCode => Object.hash(screw, trayIndex);

  @override
  String toString() => 'ScrewMovedToTray(${screw.id} -> tray $trayIndex)';
}

/// A screw moved automatically from the tray into an active box.
final class TrayToBoxMove extends GameEvent {
  final Screw screw;
  final int trayIndex;
  final int boxIndex;

  const TrayToBoxMove(this.screw, this.trayIndex, this.boxIndex);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrayToBoxMove &&
          other.screw == screw &&
          other.trayIndex == trayIndex &&
          other.boxIndex == boxIndex);

  @override
  int get hashCode => Object.hash(screw, trayIndex, boxIndex);

  @override
  String toString() =>
      'TrayToBoxMove(${screw.id} from tray $trayIndex -> box $boxIndex)';
}

/// An active box reached 3 screws and was cleared.
final class BoxCleared extends GameEvent {
  final int color;
  final int boxIndex;

  const BoxCleared(this.color, this.boxIndex);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BoxCleared &&
          other.color == color &&
          other.boxIndex == boxIndex);

  @override
  int get hashCode => Object.hash(color, boxIndex);

  @override
  String toString() => 'BoxCleared(color: $color, boxIndex: $boxIndex)';
}

/// A new box from the queue took an open active slot.
final class BoxActivated extends GameEvent {
  final int color;
  final int boxIndex;

  const BoxActivated(this.color, this.boxIndex);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BoxActivated &&
          other.color == color &&
          other.boxIndex == boxIndex);

  @override
  int get hashCode => Object.hash(color, boxIndex);

  @override
  String toString() => 'BoxActivated(color: $color, boxIndex: $boxIndex)';
}

/// A plate's last screw was removed and the plate fell away.
final class PlateFell extends GameEvent {
  final String plateId;

  const PlateFell(this.plateId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlateFell && other.plateId == plateId);

  @override
  int get hashCode => plateId.hashCode;

  @override
  String toString() => 'PlateFell($plateId)';
}

/// A tap was rejected.
final class ScrewRejected extends GameEvent {
  final String screwId;
  final RejectionReason reason;

  const ScrewRejected(this.screwId, this.reason);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScrewRejected &&
          other.screwId == screwId &&
          other.reason == reason);

  @override
  int get hashCode => Object.hash(screwId, reason);

  @override
  String toString() => 'ScrewRejected($screwId, reason: $reason)';
}

/// A booster was applied.
final class BoosterApplied extends GameEvent {
  final BoosterType type;

  const BoosterApplied(this.type);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BoosterApplied && other.type == type);

  @override
  int get hashCode => type.hashCode;

  @override
  String toString() => 'BoosterApplied($type)';
}

/// Tray slots were granted.
final class TraySlotsGranted extends GameEvent {
  final int addedSlots;
  final int totalSlots;

  const TraySlotsGranted(this.addedSlots, this.totalSlots);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TraySlotsGranted &&
          other.addedSlots == addedSlots &&
          other.totalSlots == totalSlots);

  @override
  int get hashCode => Object.hash(addedSlots, totalSlots);

  @override
  String toString() =>
      'TraySlotsGranted(added: $addedSlots, total: $totalSlots)';
}

/// Level successfully completed (all boxes cleared).
final class Won extends GameEvent {
  const Won();

  @override
  bool operator ==(Object other) => identical(this, other) || other is Won;

  @override
  int get hashCode => 1;

  @override
  String toString() => 'Won()';
}

/// Level failed (tray full and no valid taps).
final class Lost extends GameEvent {
  const Lost();

  @override
  bool operator ==(Object other) => identical(this, other) || other is Lost;

  @override
  int get hashCode => 2;

  @override
  String toString() => 'Lost()';
}
