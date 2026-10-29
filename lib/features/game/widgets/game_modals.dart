import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../app/theme.dart';

/// Modal dialog presented when a level is won (UI_UX.md Section 6).
class WinDialog extends StatelessWidget {
  const WinDialog({
    super.key,
    required this.stars,
    required this.coinsEarned,
    required this.onNextLevel,
    required this.onHome,
  });

  final int stars;
  final int coinsEarned;
  final VoidCallback onNextLevel;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: GameColors.paper,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: GameColors.ink, width: 3),
          boxShadow: const [
            BoxShadow(
              color: GameColors.scrim,
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'VICTORY!',
              style: TextStyle(
                color: GameColors.ctaPrimary,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Stars row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                final isEarned = index < stars;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: SizedBox(
                    width: isEarned ? 48 : 40,
                    height: isEarned ? 48 : 40,
                    child: SvgPicture.asset(
                      'assets/icons/hud/icon_star.svg',
                      colorFilter: isEarned
                          ? null
                          : const ColorFilter.mode(
                              Colors.black26, BlendMode.srcIn),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            // Coins reward badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: GameColors.coinGold.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: GameColors.coinGold, width: 2),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: SvgPicture.asset('assets/icons/hud/icon_coin.svg'),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '+$coinsEarned Coins',
                    style: const TextStyle(
                      color: GameColors.ink,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Next Level Button
            ElevatedButton(
              onPressed: onNextLevel,
              style: ElevatedButton.styleFrom(
                backgroundColor: GameColors.ctaPrimary,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: GameColors.ink, width: 2),
                ),
              ),
              child: const Text(
                'Next Level',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            // Home button
            TextButton(
              onPressed: onHome,
              child: const Text(
                'Back to Menu',
                style: TextStyle(
                  color: GameColors.ink,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Modal dialog presented when tray is full and no moves remain.
class FailDialog extends StatelessWidget {
  const FailDialog({
    super.key,
    required this.onRevive,
    required this.onRestart,
    required this.onHome,
  });

  final VoidCallback onRevive;
  final VoidCallback onRestart;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: GameColors.paper,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: GameColors.ink, width: 3),
          boxShadow: const [
            BoxShadow(
              color: GameColors.scrim,
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Tray Full!',
              style: TextStyle(
                color: GameColors.danger,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'No open slots left to unscrew.\nRevive with +3 slots to keep going!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: GameColors.ink,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            // Revive button
            ElevatedButton(
              onPressed: onRevive,
              style: ElevatedButton.styleFrom(
                backgroundColor: GameColors.ctaPrimary,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: GameColors.ink, width: 2),
                ),
              ),
              child: const Text(
                'Revive (+3 Slots)',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            // Restart button
            OutlinedButton(
              onPressed: onRestart,
              style: OutlinedButton.styleFrom(
                foregroundColor: GameColors.ink,
                minimumSize: const Size.fromHeight(48),
                side: const BorderSide(color: GameColors.ink, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Restart',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: onHome,
              child: const Text(
                'Quit to Menu',
                style: TextStyle(color: GameColors.ink, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// In-game pause modal.
class PauseDialog extends StatelessWidget {
  const PauseDialog({
    super.key,
    required this.onResume,
    required this.onRestart,
    required this.onHome,
  });

  final VoidCallback onResume;
  final VoidCallback onRestart;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: GameColors.paper,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: GameColors.ink, width: 3),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Game Paused',
              style: TextStyle(
                color: GameColors.ink,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onResume,
              style: ElevatedButton.styleFrom(
                backgroundColor: GameColors.ctaPrimary,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: GameColors.ink, width: 2),
                ),
              ),
              child: const Text('Resume',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: onRestart,
              style: OutlinedButton.styleFrom(
                foregroundColor: GameColors.ink,
                minimumSize: const Size.fromHeight(48),
                side: const BorderSide(color: GameColors.ink, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('Restart',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: onHome,
              child: const Text('Back to Home',
                  style: TextStyle(
                      color: GameColors.ink,
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
