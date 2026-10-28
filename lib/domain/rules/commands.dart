import 'package:twist_out/domain/model/elements.dart';

/// Sealed base class for player and system commands.
sealed class Command {
  const Command();
}

/// Command to tap a screw by its unique identifier.
final class TapScrew extends Command {
  final String screwId;

  const TapScrew(this.screwId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is TapScrew && other.screwId == screwId);

  @override
  int get hashCode => screwId.hashCode;

  @override
  String toString() => 'TapScrew($screwId)';
}

/// Command to activate a booster.
final class UseBooster extends Command {
  final BoosterType type;
  final String? targetId;

  const UseBooster(this.type, [this.targetId]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UseBooster &&
          other.type == type &&
          other.targetId == targetId);

  @override
  int get hashCode => Object.hash(type, targetId);

  @override
  String toString() => 'UseBooster($type, targetId: $targetId)';
}

/// Command to grant additional tray slots (for revive or Extra Slot booster).
final class GrantTraySlots extends Command {
  final int slots;

  const GrantTraySlots(this.slots);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GrantTraySlots && other.slots == slots);

  @override
  int get hashCode => slots.hashCode;

  @override
  String toString() => 'GrantTraySlots($slots)';
}
