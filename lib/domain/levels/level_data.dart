import '../model/elements.dart';
import '../model/game_state.dart';
import '../model/geometry.dart';
import '../rules/blocking.dart';

/// Definition and loader for curated levels.
class LevelDef {
  const LevelDef({
    required this.id,
    required this.title,
    required this.trayLimit,
    required this.plates,
    required this.screws,
    required this.boxQueue,
    this.isHard = false,
    this.isChill = false,
  });

  final int id;
  final String title;
  final int trayLimit;
  final Map<String, Plate> plates;
  final Map<String, Screw> screws;
  final List<int> boxQueue;
  final bool isHard;
  final bool isChill;

  /// Builds a fully initialized [GameState] with precomputed blockers.
  GameState buildInitialState() {
    const evaluator = BlockingEvaluator();
    final evaluatedScrews = evaluator.recalculateAll(screws, plates);

    return GameState.initial(
      plates: plates,
      screwsOnBoard: evaluatedScrews,
      initialBoxQueue: boxQueue,
      trayLimit: trayLimit,
    );
  }
}

/// Catalog of curated playable levels.
class LevelCatalog {
  LevelCatalog._();

  static final List<LevelDef> levels = [
    _level1(),
    _level2(),
    _level3(),
    _level4(),
    _level5(),
    _level6(),
    _level7(),
    _level8(),
    _level9(),
    _level10(),
  ];

  static LevelDef getLevel(int levelNumber) {
    if (levelNumber < 1) return levels.first;
    if (levelNumber > levels.length) return levels.last;
    return levels[levelNumber - 1];
  }

  // --- Level 1: Welcome (Red & Orange) ---
  static LevelDef _level1() {
    const plates = {
      'p_base': Plate(
        id: 'p_base',
        layer: 0,
        shape: Polygon(vertices: [
          Vector2D(x: 0.15, y: 0.2),
          Vector2D(x: 0.85, y: 0.2),
          Vector2D(x: 0.85, y: 0.8),
          Vector2D(x: 0.15, y: 0.8),
        ]),
        pos: Vector2D(x: 0, y: 0),
        rot: 0,
        scale: 1,
      ),
      'p_top': Plate(
        id: 'p_top',
        layer: 1,
        shape: Polygon(vertices: [
          Vector2D(x: 0.3, y: 0.35),
          Vector2D(x: 0.7, y: 0.35),
          Vector2D(x: 0.7, y: 0.65),
          Vector2D(x: 0.3, y: 0.65),
        ]),
        pos: Vector2D(x: 0, y: 0),
        rot: 0,
        scale: 1,
      ),
    };

    const screws = {
      // Bottom plate screws (s_b0 is covered by top plate)
      's1': Screw(id: 's1', plateId: 'p_base', anchorIndex: 0, color: 0, pos: Vector2D(x: 0.5, y: 0.5)),
      's2': Screw(id: 's2', plateId: 'p_base', anchorIndex: 1, color: 1, pos: Vector2D(x: 0.22, y: 0.26)),
      's3': Screw(id: 's3', plateId: 'p_base', anchorIndex: 2, color: 1, pos: Vector2D(x: 0.78, y: 0.74)),
      // Top plate screws
      's4': Screw(id: 's4', plateId: 'p_top', anchorIndex: 0, color: 0, pos: Vector2D(x: 0.38, y: 0.42)),
      's5': Screw(id: 's5', plateId: 'p_top', anchorIndex: 1, color: 0, pos: Vector2D(x: 0.62, y: 0.42)),
      's6': Screw(id: 's6', plateId: 'p_top', anchorIndex: 2, color: 1, pos: Vector2D(x: 0.5, y: 0.58)),
    };

    return const LevelDef(
      id: 1,
      title: 'First Twist',
      trayLimit: 5,
      plates: plates,
      screws: screws,
      boxQueue: [0, 1],
    );
  }

  // --- Level 2: Double Drop (Red & Green) ---
  static LevelDef _level2() {
    const plates = {
      'p_left': Plate(
        id: 'p_left',
        layer: 0,
        shape: Polygon(vertices: [
          Vector2D(x: 0.1, y: 0.2),
          Vector2D(x: 0.48, y: 0.2),
          Vector2D(x: 0.48, y: 0.8),
          Vector2D(x: 0.1, y: 0.8),
        ]),
        pos: Vector2D(x: 0, y: 0),
        rot: 0,
        scale: 1,
      ),
      'p_right': Plate(
        id: 'p_right',
        layer: 0,
        shape: Polygon(vertices: [
          Vector2D(x: 0.52, y: 0.2),
          Vector2D(x: 0.9, y: 0.2),
          Vector2D(x: 0.9, y: 0.8),
          Vector2D(x: 0.52, y: 0.8),
        ]),
        pos: Vector2D(x: 0, y: 0),
        rot: 0,
        scale: 1,
      ),
      'p_bridge': Plate(
        id: 'p_bridge',
        layer: 1,
        shape: Polygon(vertices: [
          Vector2D(x: 0.3, y: 0.4),
          Vector2D(x: 0.7, y: 0.4),
          Vector2D(x: 0.7, y: 0.6),
          Vector2D(x: 0.3, y: 0.6),
        ]),
        pos: Vector2D(x: 0, y: 0),
        rot: 0,
        scale: 1,
      ),
    };

    const screws = {
      's1': Screw(id: 's1', plateId: 'p_left', anchorIndex: 0, color: 0, pos: Vector2D(x: 0.2, y: 0.28)),
      's2': Screw(id: 's2', plateId: 'p_left', anchorIndex: 1, color: 3, pos: Vector2D(x: 0.2, y: 0.72)),
      's3': Screw(id: 's3', plateId: 'p_right', anchorIndex: 0, color: 0, pos: Vector2D(x: 0.8, y: 0.28)),
      's4': Screw(id: 's4', plateId: 'p_right', anchorIndex: 1, color: 3, pos: Vector2D(x: 0.8, y: 0.72)),
      's5': Screw(id: 's5', plateId: 'p_bridge', anchorIndex: 0, color: 0, pos: Vector2D(x: 0.38, y: 0.5)),
      's6': Screw(id: 's6', plateId: 'p_bridge', anchorIndex: 1, color: 3, pos: Vector2D(x: 0.62, y: 0.5)),
    };

    return const LevelDef(
      id: 2,
      title: 'Bridge The Gap',
      trayLimit: 5,
      plates: plates,
      screws: screws,
      boxQueue: [0, 3],
    );
  }

  // --- Level 3: Trio Sort (Yellow, Green, Blue) ---
  static LevelDef _level3() {
    const plates = {
      'p_back': Plate(
        id: 'p_back',
        layer: 0,
        shape: Polygon(vertices: [
          Vector2D(x: 0.15, y: 0.15),
          Vector2D(x: 0.85, y: 0.15),
          Vector2D(x: 0.85, y: 0.85),
          Vector2D(x: 0.15, y: 0.85),
        ]),
        pos: Vector2D(x: 0, y: 0),
        rot: 0,
        scale: 1,
      ),
      'p_mid': Plate(
        id: 'p_mid',
        layer: 1,
        shape: Polygon(vertices: [
          Vector2D(x: 0.25, y: 0.3),
          Vector2D(x: 0.75, y: 0.3),
          Vector2D(x: 0.75, y: 0.7),
          Vector2D(x: 0.25, y: 0.7),
        ]),
        pos: Vector2D(x: 0, y: 0),
        rot: 0,
        scale: 1,
      ),
    };

    const screws = {
      // 3 Yellow (2), 3 Green (3), 3 Blue (5)
      's1': Screw(id: 's1', plateId: 'p_back', anchorIndex: 0, color: 2, pos: Vector2D(x: 0.2, y: 0.2)),
      's2': Screw(id: 's2', plateId: 'p_back', anchorIndex: 1, color: 2, pos: Vector2D(x: 0.8, y: 0.2)),
      's3': Screw(id: 's3', plateId: 'p_back', anchorIndex: 2, color: 5, pos: Vector2D(x: 0.2, y: 0.8)),
      's4': Screw(id: 's4', plateId: 'p_back', anchorIndex: 3, color: 5, pos: Vector2D(x: 0.8, y: 0.8)),
      's5': Screw(id: 's5', plateId: 'p_back', anchorIndex: 4, color: 3, pos: Vector2D(x: 0.5, y: 0.2)),
      // Screws on mid plate
      's6': Screw(id: 's6', plateId: 'p_mid', anchorIndex: 0, color: 2, pos: Vector2D(x: 0.35, y: 0.4)),
      's7': Screw(id: 's7', plateId: 'p_mid', anchorIndex: 1, color: 3, pos: Vector2D(x: 0.65, y: 0.4)),
      's8': Screw(id: 's8', plateId: 'p_mid', anchorIndex: 2, color: 3, pos: Vector2D(x: 0.35, y: 0.6)),
      's9': Screw(id: 's9', plateId: 'p_mid', anchorIndex: 3, color: 5, pos: Vector2D(x: 0.65, y: 0.6)),
    };

    return const LevelDef(
      id: 3,
      title: 'Trio Balance',
      trayLimit: 5,
      plates: plates,
      screws: screws,
      boxQueue: [2, 3, 5],
    );
  }

  // --- Level 4: Crossing Planks (Red, Orange, Teal) ---
  static LevelDef _level4() {
    const plates = {
      'p_h1': Plate(
        id: 'p_h1',
        layer: 0,
        shape: Polygon(vertices: [
          Vector2D(x: 0.15, y: 0.25),
          Vector2D(x: 0.85, y: 0.25),
          Vector2D(x: 0.85, y: 0.45),
          Vector2D(x: 0.15, y: 0.45),
        ]),
        pos: Vector2D(x: 0, y: 0),
        rot: 0,
        scale: 1,
      ),
      'p_h2': Plate(
        id: 'p_h2',
        layer: 0,
        shape: Polygon(vertices: [
          Vector2D(x: 0.15, y: 0.55),
          Vector2D(x: 0.85, y: 0.55),
          Vector2D(x: 0.85, y: 0.75),
          Vector2D(x: 0.15, y: 0.75),
        ]),
        pos: Vector2D(x: 0, y: 0),
        rot: 0,
        scale: 1,
      ),
      'p_v': Plate(
        id: 'p_v',
        layer: 1,
        shape: Polygon(vertices: [
          Vector2D(x: 0.4, y: 0.18),
          Vector2D(x: 0.6, y: 0.18),
          Vector2D(x: 0.6, y: 0.82),
          Vector2D(x: 0.4, y: 0.82),
        ]),
        pos: Vector2D(x: 0, y: 0),
        rot: 0,
        scale: 1,
      ),
    };

    const screws = {
      // 3 Red (0), 3 Orange (1), 3 Teal (4)
      's1': Screw(id: 's1', plateId: 'p_h1', anchorIndex: 0, color: 0, pos: Vector2D(x: 0.25, y: 0.35)),
      's2': Screw(id: 's2', plateId: 'p_h1', anchorIndex: 1, color: 1, pos: Vector2D(x: 0.75, y: 0.35)),
      's3': Screw(id: 's3', plateId: 'p_h1', anchorIndex: 2, color: 4, pos: Vector2D(x: 0.5, y: 0.35)), // blocked by p_v!
      's4': Screw(id: 's4', plateId: 'p_h2', anchorIndex: 0, color: 0, pos: Vector2D(x: 0.25, y: 0.65)),
      's5': Screw(id: 's5', plateId: 'p_h2', anchorIndex: 1, color: 1, pos: Vector2D(x: 0.75, y: 0.65)),
      's6': Screw(id: 's6', plateId: 'p_h2', anchorIndex: 2, color: 4, pos: Vector2D(x: 0.5, y: 0.65)), // blocked by p_v!
      's7': Screw(id: 's7', plateId: 'p_v', anchorIndex: 0, color: 0, pos: Vector2D(x: 0.5, y: 0.22)),
      's8': Screw(id: 's8', plateId: 'p_v', anchorIndex: 1, color: 1, pos: Vector2D(x: 0.5, y: 0.78)),
      's9': Screw(id: 's9', plateId: 'p_v', anchorIndex: 2, color: 4, pos: Vector2D(x: 0.5, y: 0.5)),
    };

    return const LevelDef(
      id: 4,
      title: 'Plank Cross',
      trayLimit: 5,
      plates: plates,
      screws: screws,
      boxQueue: [0, 1, 4],
    );
  }

  // --- Level 5: Chill Garden (4 Colors, relaxing) ---
  static LevelDef _level5() {
    const plates = {
      'p_corner1': Plate(
        id: 'p_corner1',
        layer: 0,
        shape: Polygon(vertices: [
          Vector2D(x: 0.15, y: 0.15),
          Vector2D(x: 0.45, y: 0.15),
          Vector2D(x: 0.45, y: 0.45),
          Vector2D(x: 0.15, y: 0.45),
        ]),
        pos: Vector2D(x: 0, y: 0),
        rot: 0,
        scale: 1,
      ),
      'p_corner2': Plate(
        id: 'p_corner2',
        layer: 0,
        shape: Polygon(vertices: [
          Vector2D(x: 0.55, y: 0.15),
          Vector2D(x: 0.85, y: 0.15),
          Vector2D(x: 0.85, y: 0.45),
          Vector2D(x: 0.55, y: 0.45),
        ]),
        pos: Vector2D(x: 0, y: 0),
        rot: 0,
        scale: 1,
      ),
      'p_corner3': Plate(
        id: 'p_corner3',
        layer: 0,
        shape: Polygon(vertices: [
          Vector2D(x: 0.15, y: 0.55),
          Vector2D(x: 0.45, y: 0.55),
          Vector2D(x: 0.45, y: 0.85),
          Vector2D(x: 0.15, y: 0.85),
        ]),
        pos: Vector2D(x: 0, y: 0),
        rot: 0,
        scale: 1,
      ),
      'p_center': Plate(
        id: 'p_center',
        layer: 1,
        shape: Polygon(vertices: [
          Vector2D(x: 0.35, y: 0.35),
          Vector2D(x: 0.75, y: 0.35),
          Vector2D(x: 0.75, y: 0.75),
          Vector2D(x: 0.35, y: 0.75),
        ]),
        pos: Vector2D(x: 0, y: 0),
        rot: 0,
        scale: 1,
      ),
    };

    const screws = {
      // 3 Red (0), 3 Yellow (2), 3 Green (3), 3 Blue (5)
      's1': Screw(id: 's1', plateId: 'p_corner1', anchorIndex: 0, color: 0, pos: Vector2D(x: 0.22, y: 0.22)),
      's2': Screw(id: 's2', plateId: 'p_corner1', anchorIndex: 1, color: 2, pos: Vector2D(x: 0.38, y: 0.22)),
      's3': Screw(id: 's3', plateId: 'p_corner1', anchorIndex: 2, color: 3, pos: Vector2D(x: 0.22, y: 0.38)),
      's4': Screw(id: 's4', plateId: 'p_corner2', anchorIndex: 0, color: 0, pos: Vector2D(x: 0.78, y: 0.22)),
      's5': Screw(id: 's5', plateId: 'p_corner2', anchorIndex: 1, color: 2, pos: Vector2D(x: 0.62, y: 0.22)),
      's6': Screw(id: 's6', plateId: 'p_corner2', anchorIndex: 2, color: 5, pos: Vector2D(x: 0.78, y: 0.38)),
      's7': Screw(id: 's7', plateId: 'p_corner3', anchorIndex: 0, color: 3, pos: Vector2D(x: 0.22, y: 0.78)),
      's8': Screw(id: 's8', plateId: 'p_corner3', anchorIndex: 1, color: 5, pos: Vector2D(x: 0.38, y: 0.78)),
      's9': Screw(id: 's9', plateId: 'p_corner3', anchorIndex: 2, color: 0, pos: Vector2D(x: 0.22, y: 0.62)),
      's10': Screw(id: 's10', plateId: 'p_center', anchorIndex: 0, color: 2, pos: Vector2D(x: 0.45, y: 0.45)),
      's11': Screw(id: 's11', plateId: 'p_center', anchorIndex: 1, color: 3, pos: Vector2D(x: 0.65, y: 0.45)),
      's12': Screw(id: 's12', plateId: 'p_center', anchorIndex: 2, color: 5, pos: Vector2D(x: 0.55, y: 0.65)),
    };

    return const LevelDef(
      id: 5,
      title: 'Chill Oasis',
      trayLimit: 5,
      plates: plates,
      screws: screws,
      boxQueue: [0, 2, 3, 5],
      isChill: true,
    );
  }

  // --- Level 6 to 10 (progressive layouts) ---
  static LevelDef _level6() => _makeTierLevel(6, 'Pinwheel', [1, 2, 4, 6], 5);
  static LevelDef _level7() => _makeTierLevel(7, 'Layer Stack', [0, 3, 5, 7], 5);
  static LevelDef _level8() => _makeTierLevel(8, 'Double Chevron', [1, 3, 4, 6, 7], 5);
  static LevelDef _level9() => _makeTierLevel(9, 'Labyrinth', [0, 2, 3, 5, 6], 5);
  static LevelDef _level10() => _makeTierLevel(10, 'Master Forge', [0, 1, 2, 3, 4, 5], 5, isHard: true);

  static LevelDef _makeTierLevel(
    int id,
    String title,
    List<int> colors,
    int trayLimit, {
    bool isHard = false,
  }) {
    final plates = <String, Plate>{};
    final screws = <String, Screw>{};

    for (int l = 0; l < colors.length; l++) {
      final pId = 'p_$l';
      final offset = l * 0.05;
      plates[pId] = Plate(
        id: pId,
        layer: l,
        shape: Polygon(vertices: [
          Vector2D(x: 0.15 + offset, y: 0.18 + offset),
          Vector2D(x: 0.85 - offset, y: 0.18 + offset),
          Vector2D(x: 0.85 - offset, y: 0.82 - offset),
          Vector2D(x: 0.15 + offset, y: 0.82 - offset),
        ]),
        pos: const Vector2D(x: 0, y: 0),
        rot: 0,
        scale: 1,
      );

      final color = colors[l];
      screws['s_${l}_0'] = Screw(
        id: 's_${l}_0',
        plateId: pId,
        anchorIndex: 0,
        color: color,
        pos: Vector2D(x: 0.22 + offset, y: 0.26 + offset),
      );
      screws['s_${l}_1'] = Screw(
        id: 's_${l}_1',
        plateId: pId,
        anchorIndex: 1,
        color: color,
        pos: Vector2D(x: 0.78 - offset, y: 0.26 + offset),
      );
      screws['s_${l}_2'] = Screw(
        id: 's_${l}_2',
        plateId: pId,
        anchorIndex: 2,
        color: color,
        pos: Vector2D(x: 0.5, y: 0.74 - offset),
      );
    }

    return LevelDef(
      id: id,
      title: title,
      trayLimit: trayLimit,
      plates: plates,
      screws: screws,
      boxQueue: colors,
      isHard: isHard,
    );
  }
}
