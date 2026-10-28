import 'package:twist_out/domain/model/elements.dart';

/// Geometry and blocking evaluator for Twist Out.
class BlockingEvaluator {
  /// Default screw radius in normalized board coordinates.
  static const double defaultScrewRadius = 0.04;

  final double screwRadius;

  const BlockingEvaluator({this.screwRadius = defaultScrewRadius});

  /// Checks if [screw] is blocked by any present plate at a higher layer.
  bool isBlocked(
    Screw screw,
    Map<String, Plate> plates,
  ) {
    final screwPlate = plates[screw.plateId];
    final int screwLayer = screwPlate?.layer ?? 0;

    for (final plate in plates.values) {
      if (!plate.present) continue;
      if (plate.id == screw.plateId) continue;
      if (plate.layer <= screwLayer) continue;

      // Check if plate's world polygon covers the screw world position with margin.
      if (plate.worldPolygon.containsPoint(screw.pos, margin: screwRadius)) {
        return true;
      }
    }
    return false;
  }

  /// Precomputes candidate blocker plate IDs for every screw on the board.
  Map<String, List<String>> precomputeCandidateBlockers(
    Map<String, Screw> screws,
    Map<String, Plate> plates,
  ) {
    final result = <String, List<String>>{};

    for (final screw in screws.values) {
      final screwPlate = plates[screw.plateId];
      final int screwLayer = screwPlate?.layer ?? 0;
      final candidates = <String>[];

      for (final plate in plates.values) {
        if (plate.id == screw.plateId) continue;
        if (plate.layer <= screwLayer) continue;

        if (plate.worldPolygon.containsPoint(screw.pos, margin: screwRadius)) {
          candidates.add(plate.id);
        }
      }
      result[screw.id] = candidates;
    }

    return result;
  }

  /// Recalculates `isBlocked` for all screws on the board.
  Map<String, Screw> recalculateAll(
    Map<String, Screw> screws,
    Map<String, Plate> plates,
  ) {
    final updated = <String, Screw>{};
    for (final entry in screws.entries) {
      final blocked = isBlocked(entry.value, plates);
      updated[entry.key] = entry.value.copyWith(isBlocked: blocked);
    }
    return updated;
  }

  /// Updates blocking state for only screws that list [fallenPlateId] as a candidate.
  Map<String, Screw> updateAfterPlateFall(
    Map<String, Screw> screws,
    Map<String, Plate> plates,
    Map<String, List<String>> candidateBlockers,
    String fallenPlateId,
  ) {
    final updated = Map<String, Screw>.of(screws);

    for (final entry in screws.entries) {
      final candidates = candidateBlockers[entry.key];
      if (candidates == null || !candidates.contains(fallenPlateId)) {
        continue;
      }

      // Check if any remaining candidate is still present.
      bool stillBlocked = false;
      for (final pid in candidates) {
        if (plates[pid]?.present == true) {
          stillBlocked = true;
          break;
        }
      }

      updated[entry.key] = entry.value.copyWith(isBlocked: stillBlocked);
    }

    return updated;
  }
}
