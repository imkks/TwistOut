import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/theme.dart';
import 'features/game/game_screen.dart';
import 'features/home/home_screen.dart';
import 'l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: TwistOutApp()));
}

/// Root Twist Out application widget.
class TwistOutApp extends StatefulWidget {
  const TwistOutApp({super.key});

  @override
  State<TwistOutApp> createState() => _TwistOutAppState();
}

class _TwistOutAppState extends State<TwistOutApp> {
  int? _activeLevel;

  void _startLevel(int level) {
    setState(() {
      _activeLevel = level;
    });
  }

  void _backToHome() {
    setState(() {
      _activeLevel = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twist Out',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: _activeLevel != null
          ? GameScreen(
              key: ValueKey('level_$_activeLevel'),
              levelNumber: _activeLevel!,
              onBackToHome: _backToHome,
              onGoToLevel: _startLevel,
            )
          : HomeScreen(
              onStartLevel: _startLevel,
            ),
    );
  }
}
