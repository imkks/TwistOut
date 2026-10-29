import 'package:flutter/material.dart';
import '../../../app/theme.dart';
import '../../../domain/model/elements.dart';

/// Active boxes and upcoming queue bar (UI_UX.md Section 3).
class BoxBar extends StatelessWidget {
  const BoxBar({
    super.key,
    required this.activeBoxes,
    required this.boxQueue,
  });

  final List<BoxState> activeBoxes;
  final List<int> boxQueue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Active boxes (up to 3)
          ...activeBoxes.map((box) => _ActiveBoxWidget(box: box)),

          // Upcoming queue preview
          if (boxQueue.isNotEmpty) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: GameColors.paper.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: GameColors.ink.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: boxQueue.take(2).map((color) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: GameColors.getScrewColor(color),
                      shape: BoxShape.circle,
                      border: Border.all(color: GameColors.ink, width: 1.5),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ActiveBoxWidget extends StatelessWidget {
  const _ActiveBoxWidget({required this.box});

  final BoxState box;

  @override
  Widget build(BuildContext context) {
    final color = GameColors.getScrewColor(box.color);
    final symbol = GameColors.getScrewSymbol(box.color);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 68,
      height: 64,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: GameColors.ink, width: 2.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x332B2118),
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Engraved symbol
          Text(
            symbol,
            style: const TextStyle(
              color: GameColors.ink,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          // 3 Capacity indicator dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              final isFilled = index < box.count;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isFilled ? Colors.white : Colors.black26,
                  shape: BoxShape.circle,
                  border: Border.all(color: GameColors.ink, width: 1.5),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
