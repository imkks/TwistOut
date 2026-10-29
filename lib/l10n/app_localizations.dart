import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// Game title
  ///
  /// In en, this message translates to:
  /// **'Twist Out'**
  String get app_title;

  /// Play level button label
  ///
  /// In en, this message translates to:
  /// **'Level {n}'**
  String play_level(int n);

  /// Double reward button label
  ///
  /// In en, this message translates to:
  /// **'Double'**
  String get double_reward;

  /// Next level button
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Revive button label
  ///
  /// In en, this message translates to:
  /// **'Revive +3 slots'**
  String get revive;

  /// Restart button
  ///
  /// In en, this message translates to:
  /// **'Restart'**
  String get restart;

  /// Resume button
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// Home button
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Pause title
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// Settings title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Music toggle label
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get music;

  /// Sound effects toggle label
  ///
  /// In en, this message translates to:
  /// **'Sound Effects'**
  String get sound;

  /// Haptics toggle label
  ///
  /// In en, this message translates to:
  /// **'Haptics'**
  String get haptics;

  /// Colorblind symbols mode toggle label
  ///
  /// In en, this message translates to:
  /// **'Colorblind Symbols'**
  String get colourblind;

  /// Win modal title
  ///
  /// In en, this message translates to:
  /// **'Level Complete!'**
  String get level_won;

  /// Lose modal title
  ///
  /// In en, this message translates to:
  /// **'Tray Full!'**
  String get level_lost;

  /// Coins earned label
  ///
  /// In en, this message translates to:
  /// **'+{coins} Coins'**
  String coins_earned(int coins);

  /// Out of boosters prompt
  ///
  /// In en, this message translates to:
  /// **'Get more'**
  String get out_of_boosters;

  /// Extra slot booster name
  ///
  /// In en, this message translates to:
  /// **'Extra Slot'**
  String get booster_extra_slot;

  /// Magnet booster name
  ///
  /// In en, this message translates to:
  /// **'Magnet'**
  String get booster_magnet;

  /// Smash booster name
  ///
  /// In en, this message translates to:
  /// **'Smash'**
  String get booster_smash;

  /// Daily reward title
  ///
  /// In en, this message translates to:
  /// **'Daily reward'**
  String get daily_title;

  /// Workshop title
  ///
  /// In en, this message translates to:
  /// **'Workshop'**
  String get workshop_title;

  /// Rate prompt
  ///
  /// In en, this message translates to:
  /// **'Enjoying Twist Out?'**
  String get rate_pre;

  /// Remove ads button
  ///
  /// In en, this message translates to:
  /// **'Remove ads'**
  String get remove_ads;

  /// Restore purchases button
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get restore;

  /// No ad message
  ///
  /// In en, this message translates to:
  /// **'No ad available right now'**
  String get no_ad_available;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
