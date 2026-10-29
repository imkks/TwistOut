import 'package:flutter/material.dart';
import '../app/theme.dart';
import '../domain/model/elements.dart';
import '../domain/model/game_state.dart';

/// Interactive board rendering widget for Twist Out.
class BoardWidget extends StatelessWidget {
  const BoardWidget({
    super.key,
    required this.gameState,
    required this.onScrewTapped,
    this.showColorblindSymbols = false,
  });

  final GameState gameState;
  final void Function(String screwId) onScrewTapped;
  final bool showColorblindSymbols;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final availableHeight = constraints.maxHeight;

        // Maintain 4:5 board aspect ratio (TDD Section 5)
        double width = availableWidth;
        double height = width * 1.25;

        if (height > availableHeight) {
          height = availableHeight;
          width = height / 1.25;
        }

        return Center(
          child: SizedBox(
            width: width,
            height: height,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapUp: (details) => _handleTap(details.localPosition, width, height),
              child: CustomPaint(
                size: Size(width, height),
                painter: _BoardPainter(
                  gameState: gameState,
                  showColorblindSymbols: showColorblindSymbols,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleTap(Offset localPos, double boardWidth, double boardHeight) {
    // Normalise tap coordinates
    final tapX = localPos.dx / boardWidth;
    final tapY = localPos.dy / boardHeight;

    // Hit test screws: radius is ~0.06 in board space
    const tapRadius = 0.08;
    String? hitScrewId;
    double closestDist = double.infinity;

    for (final screw in gameState.screwsOnBoard.values) {
      final dx = screw.pos.x - tapX;
      final dy = screw.pos.y - tapY;
      final dist = dx * dx + dy * dy;

      if (dist <= tapRadius * tapRadius && dist < closestDist) {
        closestDist = dist;
        hitScrewId = screw.id;
      }
    }

    if (hitScrewId != null) {
      onScrewTapped(hitScrewId);
    }
  }
}

class _BoardPainter extends CustomPainter {
  _BoardPainter({
    required this.gameState,
    required this.showColorblindSymbols,
  });

  final GameState gameState;
  final bool showColorblindSymbols;

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw Plates ordered by layer (lowest to highest)
    final sortedPlates = gameState.plates.values.where((p) => p.present).toList()
      ..sort((a, b) => a.layer.compareTo(b.layer));

    for (final plate in sortedPlates) {
      _drawPlate(canvas, size, plate);
    }

    // 2. Draw Screws
    for (final screw in gameState.screwsOnBoard.values) {
      _drawScrew(canvas, size, screw);
    }
  }

  void _drawPlate(Canvas canvas, Size size, Plate plate) {
    final poly = plate.worldPolygon;
    if (poly.vertices.length < 3) return;

    final path = Path();
    final first = poly.vertices.first;
    path.moveTo(first.x * size.width, first.y * size.height);

    for (int i = 1; i < poly.vertices.length; i++) {
      final v = poly.vertices[i];
      path.lineTo(v.x * size.width, v.y * size.height);
    }
    path.close();

    // Plate Drop Shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.15 + (plate.layer * 0.05).clamp(0.0, 0.25))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.save();
    canvas.translate(0, 4.0 + plate.layer * 2.0);
    canvas.drawPath(path, shadowPaint);
    canvas.restore();

    // Plate Wood Texture Body
    final plateFill = Paint()
      ..color = (plate.layer % 2 == 0)
          ? GameColors.plateWoodLight
          : GameColors.plateWoodDark
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, plateFill);

    // Plate Border
    final plateStroke = Paint()
      ..color = GameColors.plateBorder
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, plateStroke);
  }

  void _drawScrew(Canvas canvas, Size size, Screw screw) {
    final cx = screw.pos.x * size.width;
    final cy = screw.pos.y * size.height;
    final radius = size.width * 0.055;

    final isBlocked = screw.isBlocked;
    final baseColor = GameColors.getScrewColor(screw.color);

    // Screw Drop Shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: isBlocked ? 0.1 : 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawCircle(Offset(cx, cy + 2.5), radius, shadowPaint);

    // Screw Head Body
    final bodyPaint = Paint()
      ..color = isBlocked
          ? Color.lerp(baseColor, Colors.black, 0.45)!
          : baseColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(cx, cy), radius, bodyPaint);

    // Outer Rim
    final rimPaint = Paint()
      ..color = isBlocked ? const Color(0xFF1F1A14) : GameColors.ink
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(cx, cy), radius, rimPaint);

    // Inner Gloss Ring (free screws)
    if (!isBlocked) {
      final glossPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.4)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(Offset(cx, cy), radius * 0.75, glossPaint);
    }

    // Engraved Symbol or Slot
    final symbol = GameColors.getScrewSymbol(screw.color);
    final textPainter = TextPainter(
      text: TextSpan(
        text: symbol,
        style: TextStyle(
          color: isBlocked ? Colors.white30 : GameColors.ink,
          fontSize: radius * 1.05,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(cx - textPainter.width / 2, cy - textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant _BoardPainter oldDelegate) {
    return oldDelegate.gameState != gameState ||
        oldDelegate.showColorblindSymbols != showColorblindSymbols;
  }
}
