import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../app/theme.dart';
import '../../../domain/model/elements.dart';

/// Booster action bar (Extra Slot, Magnet, Smash) with inventory badges.
class BoosterBar extends StatelessWidget {
  const BoosterBar({
    super.key,
    required this.extraSlots,
    required this.magnets,
    required this.smashes,
    required this.onUseBooster,
  });

  final int extraSlots;
  final int magnets;
  final int smashes;
  final void Function(BoosterType type) onUseBooster;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _BoosterButton(
            title: 'Slot',
            count: extraSlots,
            assetPath: 'assets/icons/boosters/booster_extra_slot.svg',
            fallbackIcon: Icons.add_circle_outline,
            onTap: () => onUseBooster(BoosterType.extraSlot),
          ),
          _BoosterButton(
            title: 'Magnet',
            count: magnets,
            assetPath: 'assets/icons/boosters/booster_magnet.svg',
            fallbackIcon: Icons.flash_on,
            onTap: () => onUseBooster(BoosterType.magnet),
          ),
          _BoosterButton(
            title: 'Smash',
            count: smashes,
            assetPath: 'assets/icons/boosters/booster_smash.svg',
            fallbackIcon: Icons.hardware,
            onTap: () => onUseBooster(BoosterType.smash),
          ),
        ],
      ),
    );
  }
}

class _BoosterButton extends StatelessWidget {
  const _BoosterButton({
    required this.title,
    required this.count,
    required this.assetPath,
    required this.fallbackIcon,
    required this.onTap,
  });

  final String title;
  final int count;
  final String assetPath;
  final IconData fallbackIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isAvailable = count > 0;

    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: isAvailable ? GameColors.paper : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isAvailable ? GameColors.ink : Colors.grey,
                    width: 2.5,
                  ),
                  boxShadow: isAvailable
                      ? const [
                          BoxShadow(
                            color: Color(0x332B2118),
                            blurRadius: 4,
                            offset: Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  assetPath,
                  placeholderBuilder: (ctx) => Icon(
                    fallbackIcon,
                    color: isAvailable ? GameColors.ink : Colors.grey,
                    size: 28,
                  ),
                ),
              ),
              // Count badge
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: isAvailable
                        ? GameColors.ctaPrimary
                        : GameColors.danger,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: isAvailable ? GameColors.ink : Colors.grey.shade600,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
