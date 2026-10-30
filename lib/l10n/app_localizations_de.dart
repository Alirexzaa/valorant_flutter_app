// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Valorant App';

  @override
  String get home => 'Startseite';

  @override
  String get agents => 'Agenten';

  @override
  String get weapons => 'Waffen';

  @override
  String get maps => 'Karten';

  @override
  String get favorites => 'Favoriten';

  @override
  String get welcome => 'Willkommen bei der Valorant App';

  @override
  String get signOut => 'Abmelden';

  @override
  String get noFavorites => 'Noch keine Favoriten!';

  @override
  String get loading => 'Wird geladen...';
}
