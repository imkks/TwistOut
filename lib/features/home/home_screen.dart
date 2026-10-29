import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../domain/levels/level_data.dart';
import '../settings/settings_modal.dart';

/// Main home screen and level select menu (UI_UX.md Section 5.1).
class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    super.key,
    required this.onStartLevel,
  });

  final void Function(int level) onStartLevel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [GameColors.world1BgStart, GameColors.world1BgEnd],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with Coins and Settings
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Coin Counter
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: GameColors.paper,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: GameColors.ink, width: 2),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 22,
                            height: 22,
                            child: SvgPicture.asset('assets/icons/hud/icon_coin.svg'),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${player.coins}',
                            style: const TextStyle(
                              color: GameColors.ink,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Settings Button
                    GestureDetector(
                      onTap: () => _openSettings(context),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: GameColors.paper,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: GameColors.ink, width: 2),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset('assets/icons/hud/icon_settings.svg'),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 1),

              // Game Logo / Hero Title
              Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x332B2118),
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: SvgPicture.asset('assets/icons/screws/screw_0_cross.svg'),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'TWIST OUT',
                    style: TextStyle(
                      color: GameColors.ink,
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const Text(
                    'Unscrew. Sort. Satisfy.',
                    style: TextStyle(
                      color: GameColors.ink,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Big Primary Play Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  onPressed: () => onStartLevel(player.highestUnlockedLevel),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GameColors.ctaPrimary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: GameColors.ink, width: 3),
                    ),
                    elevation: 6,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 28,
                        height: 28,
                        child: SvgPicture.asset(
                          'assets/icons/hud/icon_play.svg',
                          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'PLAY LEVEL ${player.highestUnlockedLevel}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(flex: 1),

              // Level Selector Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'All Levels',
                    style: TextStyle(
                      color: GameColors.ink,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Level Select Grid
              Container(
                height: 150,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: LevelCatalog.levels.length,
                  itemBuilder: (context, index) {
                    final levelNum = index + 1;
                    final isUnlocked = levelNum <= player.highestUnlockedLevel;
                    final stars = player.levelStars[levelNum] ?? 0;

                    return GestureDetector(
                      onTap: isUnlocked ? () => onStartLevel(levelNum) : null,
                      child: Container(
                        width: 90,
                        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                        decoration: BoxDecoration(
                          color: isUnlocked ? GameColors.paper : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isUnlocked ? GameColors.ink : Colors.grey.shade500,
                            width: 2.5,
                          ),
                          boxShadow: isUnlocked
                              ? const [
                                  BoxShadow(
                                    color: Color(0x222B2118),
                                    blurRadius: 4,
                                    offset: Offset(0, 3),
                                  ),
                                ]
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isUnlocked) ...[
                              Text(
                                '$levelNum',
                                style: const TextStyle(
                                  color: GameColors.ink,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(3, (sIdx) {
                                  final earned = sIdx < stars;
                                  return Icon(
                                    Icons.star,
                                    size: 14,
                                    color: earned ? GameColors.coinGold : Colors.black12,
                                  );
                                }),
                              ),
                            ] else ...[
                              const Icon(Icons.lock, color: Colors.black45, size: 28),
                              const SizedBox(height: 4),
                              Text(
                                '$levelNum',
                                style: const TextStyle(
                                  color: Colors.black45,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _openSettings(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const SettingsModal(),
    );
  }
}
