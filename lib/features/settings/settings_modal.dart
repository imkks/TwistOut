import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';

/// Settings modal for audio, haptics, and accessibility.
class SettingsModal extends ConsumerWidget {
  const SettingsModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerProvider);
    final notifier = ref.read(playerProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: GameColors.paper,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: GameColors.ink.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Settings',
            style: TextStyle(
              color: GameColors.ink,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _SettingSwitchTile(
            title: 'Sound Effects',
            icon: Icons.volume_up,
            value: player.sfxEnabled,
            onChanged: (_) => notifier.toggleSfx(),
          ),
          _SettingSwitchTile(
            title: 'Music',
            icon: Icons.music_note,
            value: player.musicEnabled,
            onChanged: (_) => notifier.toggleMusic(),
          ),
          _SettingSwitchTile(
            title: 'Haptics',
            icon: Icons.vibration,
            value: player.hapticsEnabled,
            onChanged: (_) => notifier.toggleHaptics(),
          ),
          _SettingSwitchTile(
            title: 'Colorblind Symbols',
            icon: Icons.visibility,
            value: player.colourblindMode,
            onChanged: (_) => notifier.toggleColourblind(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _SettingSwitchTile extends StatelessWidget {
  const _SettingSwitchTile({
    required this.title,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: GameColors.ink, size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  color: GameColors.ink,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Switch(
            value: value,
            activeThumbColor: GameColors.ctaPrimary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
