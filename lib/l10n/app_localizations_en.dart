// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Valorant App';

  @override
  String get home => 'Home';

  @override
  String get agents => 'Agents';

  @override
  String get weapons => 'Weapons';

  @override
  String get maps => 'Maps';

  @override
  String get favorites => 'Favorites';

  @override
  String get welcome => 'Welcome To Valorant App';

  @override
  String get signOut => 'Sign Out';

  @override
  String get noFavorites => 'No favorites yet!';

  @override
  String get loading => 'Loading...';
}
