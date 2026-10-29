// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_title => 'Twist Out';

  @override
  String play_level(int n) {
    return 'Level $n';
  }

  @override
  String get double_reward => 'Double';

  @override
  String get next => 'Next';

  @override
  String get revive => 'Revive +3 slots';

  @override
  String get restart => 'Restart';

  @override
  String get resume => 'Resume';

  @override
  String get home => 'Home';

  @override
  String get pause => 'Pause';

  @override
  String get settings => 'Settings';

  @override
  String get music => 'Music';

  @override
  String get sound => 'Sound Effects';

  @override
  String get haptics => 'Haptics';

  @override
  String get colourblind => 'Colorblind Symbols';

  @override
  String get level_won => 'Level Complete!';

  @override
  String get level_lost => 'Tray Full!';

  @override
  String coins_earned(int coins) {
    return '+$coins Coins';
  }

  @override
  String get out_of_boosters => 'Get more';

  @override
  String get booster_extra_slot => 'Extra Slot';

  @override
  String get booster_magnet => 'Magnet';

  @override
  String get booster_smash => 'Smash';

  @override
  String get daily_title => 'Daily reward';

  @override
  String get workshop_title => 'Workshop';

  @override
  String get rate_pre => 'Enjoying Twist Out?';

  @override
  String get remove_ads => 'Remove ads';

  @override
  String get restore => 'Restore purchases';

  @override
  String get no_ad_available => 'No ad available right now';
}
