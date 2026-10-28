import 'package:test/test.dart';
import 'package:twist_out/domain/model/elements.dart';
import 'package:twist_out/domain/model/game_state.dart';
import 'package:twist_out/domain/model/geometry.dart';
import 'package:twist_out/domain/rules/commands.dart';
import 'package:twist_out/domain/rules/events.dart';
import 'package:twist_out/domain/rules/reducer.dart';

void main() {
  group('Reducer — TapScrew', () {
    const defaultPlate = Plate(
      id: 'p1',
      layer: 0,
      shape: Polygon(vertices: [
        Vector2D(x: 0, y: 0),
        Vector2D(x: 1, y: 0),
        Vector2D(x: 1, y: 1),
        Vector2D(x: 0, y: 1),
      ]),
      pos: Vector2D(x: 0, y: 0),
      rot: 0,
      scale: 1,
    );

    test('rejects tap if game is not in playing status', () {
      final state = const GameState(
        plates: {},
        screwsOnBoard: {
          's1': Screw(id: 's1', plateId: 'p', anchorIndex: 0, color: 0, pos: Vector2D(x: 0, y: 0)),
        },
        activeBoxes: [],
        boxQueue: [],
        tray: [],
        status: GameStatus.won,
      );

      final result = step(state, const TapScrew('s1'));
      expect(result.state, equals(state));
      expect(
        result.events,
        equals([const ScrewRejected('s1', RejectionReason.gameNotPlaying)]),
      );
    });

    test('rejects tap if screw not found', () {
      final state = GameState.initial(
        plates: {'p1': defaultPlate},
        screwsOnBoard: {},
        initialBoxQueue: [0],
      );

      final result = step(state, const TapScrew('missing_screw'));
      expect(result.state, equals(state));
      expect(
        result.events,
        equals([const ScrewRejected('missing_screw', RejectionReason.screwNotFound)]),
      );
    });

    test('rejects tap if screw is blocked', () {
      const blockedScrew = Screw(
        id: 's1',
        plateId: 'p1',
        anchorIndex: 0,
        color: 0,
        pos: Vector2D(x: 0.5, y: 0.5),
        isBlocked: true,
      );

      final state = GameState.initial(
        plates: {'p1': defaultPlate},
        screwsOnBoard: {'s1': blockedScrew},
        initialBoxQueue: [0],
      );

      final result = step(state, const TapScrew('s1'));
      expect(result.state, equals(state));
      expect(
        result.events,
        equals([const ScrewRejected('s1', RejectionReason.screwBlocked)]),
      );
    });

    test('rejects tap if tray is full and no matching active box exists', () {
      const screw = Screw(
        id: 's1',
        plateId: 'p1',
        anchorIndex: 0,
        color: 5,
        pos: Vector2D(x: 0.5, y: 0.5),
      );

      const trayScrew = Screw(
        id: 'st',
        plateId: 'p1',
        anchorIndex: 1,
        color: 9,
        pos: Vector2D(x: 0, y: 0),
      );

      final state = const GameState(
        plates: {'p1': defaultPlate},
        screwsOnBoard: {'s1': screw},
        activeBoxes: [BoxState(color: 0, count: 0)],
        boxQueue: [],
        tray: [trayScrew],
        trayLimit: 1,
      );

      final result = step(state, const TapScrew('s1'));
      expect(result.state, equals(state));
      expect(
        result.events,
        equals([const ScrewRejected('s1', RejectionReason.trayFull)]),
      );
    });

    test('tap screw moves directly to matching active box', () {
      const screw = Screw(
        id: 's1',
        plateId: 'p1',
        anchorIndex: 0,
        color: 0,
        pos: Vector2D(x: 0.5, y: 0.5),
      );

      final state = GameState.initial(
        plates: {'p1': defaultPlate},
        screwsOnBoard: {'s1': screw},
        initialBoxQueue: [0],
      );

      final result = step(state, const TapScrew('s1'));

      expect(result.state.screwsOnBoard, isEmpty);
      expect(result.state.activeBoxes[0].count, equals(1));
      expect(result.state.moves, equals(1));
      expect(
        result.events,
        contains(const ScrewMovedToBox(screw, 0)),
      );
      expect(result.events, contains(const PlateFell('p1')));
    });

    test('tap screw moves to tray when no matching active box exists', () {
      const screw = Screw(
        id: 's1',
        plateId: 'p1',
        anchorIndex: 0,
        color: 5,
        pos: Vector2D(x: 0.5, y: 0.5),
      );

      final state = GameState.initial(
        plates: {'p1': defaultPlate},
        screwsOnBoard: {'s1': screw},
        initialBoxQueue: [0],
        trayLimit: 3,
      );

      final result = step(state, const TapScrew('s1'));

      expect(result.state.screwsOnBoard, isEmpty);
      expect(result.state.tray[0], equals(screw));
      expect(result.state.trayOccupancy, equals(1));
      expect(result.state.trayPeak, equals(1));
      expect(
        result.events,
        contains(const ScrewMovedToTray(screw, 0)),
      );
    });

    test('box completion clears box and activates next from queue', () {
      const s3 = Screw(
        id: 's3',
        plateId: 'p1',
        anchorIndex: 2,
        color: 0,
        pos: Vector2D(x: 0.5, y: 0.5),
      );

      final state = const GameState(
        plates: {'p1': defaultPlate},
        screwsOnBoard: {'s3': s3},
        activeBoxes: [BoxState(color: 0, count: 2)],
        boxQueue: [1],
        tray: [null, null, null],
        trayLimit: 3,
      );

      final result = step(state, const TapScrew('s3'));

      expect(
        result.events,
        contains(const BoxCleared(0, 0)),
      );
      expect(
        result.events,
        contains(const BoxActivated(1, 0)),
      );
      expect(result.state.activeBoxes[0].color, equals(1));
      expect(result.state.activeBoxes[0].count, equals(0));
    });

    test('cascade reaction: new box draws matching screws from tray', () {
      const s3 = Screw(
        id: 's3',
        plateId: 'p1',
        anchorIndex: 2,
        color: 0,
        pos: Vector2D(x: 0.5, y: 0.5),
      );

      const trayScrew1 = Screw(
        id: 'st1',
        plateId: 'p1',
        anchorIndex: 3,
        color: 1,
        pos: Vector2D(x: 0.1, y: 0.1),
      );

      final state = const GameState(
        plates: {'p1': defaultPlate},
        screwsOnBoard: {'s3': s3},
        activeBoxes: [BoxState(color: 0, count: 2)],
        boxQueue: [1],
        tray: [trayScrew1, null, null],
        trayLimit: 3,
      );

      final result = step(state, const TapScrew('s3'));

      expect(
        result.events,
        contains(const TrayToBoxMove(trayScrew1, 0, 0)),
      );
      expect(result.state.tray[0], isNull);
      expect(result.state.activeBoxes[0].color, equals(1));
      expect(result.state.activeBoxes[0].count, equals(1));
    });

    test('win condition triggers when all boxes cleared and queue empty', () {
      const sLast = Screw(
        id: 'sLast',
        plateId: 'p1',
        anchorIndex: 2,
        color: 0,
        pos: Vector2D(x: 0.5, y: 0.5),
      );

      final state = const GameState(
        plates: {'p1': defaultPlate},
        screwsOnBoard: {'sLast': sLast},
        activeBoxes: [BoxState(color: 0, count: 2)],
        boxQueue: [],
        tray: [null, null],
        trayLimit: 2,
      );

      final result = step(state, const TapScrew('sLast'));

      expect(result.state.status, equals(GameStatus.won));
      expect(result.events, contains(const Won()));
      expect(result.state.activeBoxes, isEmpty);
    });

    test('lose condition triggers when tray is full and no valid taps exist', () {
      const trayScrew = Screw(
        id: 'st',
        plateId: 'p1',
        anchorIndex: 0,
        color: 9,
        pos: Vector2D(x: 0, y: 0),
      );

      const sMismatch = Screw(
        id: 'sMismatch',
        plateId: 'p1',
        anchorIndex: 1,
        color: 2,
        pos: Vector2D(x: 0.2, y: 0.2),
      );

      final state = const GameState(
        plates: {'p1': defaultPlate},
        screwsOnBoard: {'sMismatch': sMismatch},
        activeBoxes: [BoxState(color: 0, count: 0)],
        boxQueue: [],
        tray: [trayScrew, null],
        trayLimit: 2,
      );

      final result = step(state, const TapScrew('sMismatch'));

      expect(result.state.trayOccupancy, equals(2));
      expect(result.state.status, equals(GameStatus.lost));
      expect(result.events, contains(const Lost()));
    });
  });

  group('Reducer — Boosters & Slots', () {
    test('ExtraSlot booster adds slot to tray', () {
      final state = GameState.initial(
        plates: {},
        screwsOnBoard: {},
        initialBoxQueue: [0],
        trayLimit: 3,
      );

      final result = step(state, const UseBooster(BoosterType.extraSlot));
      expect(result.state.tray.length, equals(4));
      expect(result.state.trayLimit, equals(4));
      expect(result.events, contains(const BoosterApplied(BoosterType.extraSlot)));
      expect(result.events, contains(const TraySlotsGranted(1, 4)));
    });

    test('GrantTraySlots with non-positive slots does nothing', () {
      final state = GameState.initial(plates: {}, screwsOnBoard: {}, initialBoxQueue: []);
      final res = step(state, const GrantTraySlots(0));
      expect(res.state, equals(state));
      expect(res.events, isEmpty);
    });

    test('GrantTraySlots revives game from lost status', () {
      final state = const GameState(
        plates: {},
        screwsOnBoard: {},
        activeBoxes: [BoxState(color: 0, count: 0)],
        boxQueue: [],
        tray: [
          Screw(id: 's1', plateId: 'p', anchorIndex: 0, color: 1, pos: Vector2D(x: 0, y: 0)),
        ],
        trayLimit: 1,
        status: GameStatus.lost,
      );

      final result = step(state, const GrantTraySlots(2));
      expect(result.state.status, equals(GameStatus.playing));
      expect(result.state.tray.length, equals(3));
      expect(result.events, contains(const TraySlotsGranted(2, 3)));
    });

    test('Magnet booster with no active boxes does nothing', () {
      final state = const GameState(
        plates: {},
        screwsOnBoard: {},
        activeBoxes: [],
        boxQueue: [],
        tray: [],
      );
      final result = step(state, const UseBooster(BoosterType.magnet));
      expect(result.state, equals(state));
    });

    test('Magnet booster when all boxes are full does nothing', () {
      final state = const GameState(
        plates: {},
        screwsOnBoard: {},
        activeBoxes: [BoxState(color: 0, count: 3)],
        boxQueue: [],
        tray: [],
      );
      final result = step(state, const UseBooster(BoosterType.magnet));
      expect(result.state, equals(state));
    });

    test('Magnet booster pulls matching screws from tray and board', () {
      const s1 = Screw(id: 's1', plateId: 'p1', anchorIndex: 0, color: 0, pos: Vector2D(x: 0, y: 0));
      const s2 = Screw(id: 's2', plateId: 'p1', anchorIndex: 1, color: 0, pos: Vector2D(x: 0, y: 0));
      const s3Tray = Screw(id: 's3', plateId: 'p1', anchorIndex: 2, color: 0, pos: Vector2D(x: 0, y: 0));

      final state = const GameState(
        plates: {
          'p1': Plate(
            id: 'p1',
            layer: 0,
            shape: Polygon(vertices: [Vector2D(x: 0, y: 0), Vector2D(x: 1, y: 0), Vector2D(x: 0, y: 1)]),
            pos: Vector2D(x: 0, y: 0),
            rot: 0,
            scale: 1,
          ),
        },
        screwsOnBoard: {'s1': s1, 's2': s2},
        activeBoxes: [BoxState(color: 0, count: 0)],
        boxQueue: [],
        tray: [s3Tray, null, null],
        trayLimit: 3,
      );

      final result = step(state, const UseBooster(BoosterType.magnet));
      expect(result.state.screwsOnBoard, isEmpty);
      expect(result.state.tray[0], isNull);
      expect(result.state.status, equals(GameStatus.won));
      expect(result.events, contains(const Won()));
    });

    test('Smash booster placeholder returns state and event', () {
      final state = GameState.initial(plates: {}, screwsOnBoard: {}, initialBoxQueue: []);
      final res = step(state, const UseBooster(BoosterType.smash));
      expect(res.state, equals(state));
      expect(res.events, contains(const BoosterApplied(BoosterType.smash)));
    });
  });
}
