import 'package:flutter/material.dart';
import '../../../app/theme.dart';
import '../../../domain/model/elements.dart';

/// Recessed 5-slot tray widget (UI_UX.md Section 3).
class TrayBar extends StatelessWidget {
  const TrayBar({
    super.key,
    required this.tray,
  });

  final List<Screw?> tray;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFCBB38B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: GameColors.ink, width: 2.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x332B2118),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: tray.map((screw) => _TraySlotWidget(screw: screw)).toList(),
      ),
    );
  }
}

class _TraySlotWidget extends StatelessWidget {
  const _TraySlotWidget({this.screw});

  final Screw? screw;

  @override
  Widget build(BuildContext context) {
    final hasScrew = screw != null;

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFF241C15), // Recessed dark slot hole
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF8B6C47), width: 2),
      ),
      child: hasScrew
          ? Center(
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: GameColors.getScrewColor(screw!.color),
                  shape: BoxShape.circle,
                  border: Border.all(color: GameColors.ink, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    GameColors.getScrewSymbol(screw!.color),
                    style: const TextStyle(
                      color: GameColors.ink,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
