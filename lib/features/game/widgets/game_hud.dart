import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../app/theme.dart';

/// Top HUD bar (Pause button, Level Title & Badge, Coins).
class GameHud extends StatelessWidget {
  const GameHud({
    super.key,
    required this.levelNumber,
    required this.levelTitle,
    required this.coins,
    required this.onPauseTap,
    this.isHard = false,
    this.isChill = false,
  });

  final int levelNumber;
  final String levelTitle;
  final int coins;
  final VoidCallback onPauseTap;
  final bool isHard;
  final bool isChill;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Pause button
          GestureDetector(
            onTap: onPauseTap,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: GameColors.paper,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: GameColors.ink, width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x222B2118),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                'assets/icons/hud/icon_pause.svg',
                placeholderBuilder: (_) => const Icon(
                  Icons.pause,
                  color: GameColors.ink,
                  size: 20,
                ),
              ),
            ),
          ),

          // Level Title and Badges
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isHard) ...[
                SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset('assets/icons/badges/badge_flame_hard.svg'),
                ),
                const SizedBox(width: 4),
              ] else if (isChill) ...[
                SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset('assets/icons/badges/badge_leaf_chill.svg'),
                ),
                const SizedBox(width: 4),
              ],
              Text(
                'Level $levelNumber',
                style: const TextStyle(
                  color: GameColors.ink,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Coin display
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: GameColors.paper,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: GameColors.ink, width: 2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: SvgPicture.asset('assets/icons/hud/icon_coin.svg'),
                ),
                const SizedBox(width: 6),
                Text(
                  '$coins',
                  style: const TextStyle(
                    color: GameColors.ink,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
