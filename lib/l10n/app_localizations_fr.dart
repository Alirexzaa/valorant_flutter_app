// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Application Valorant';

  @override
  String get home => 'Accueil';

  @override
  String get agents => 'Agents';

  @override
  String get weapons => 'Armes';

  @override
  String get maps => 'Cartes';

  @override
  String get favorites => 'Favoris';

  @override
  String get welcome => 'Bienvenue sur l\'application Valorant';

  @override
  String get signOut => 'Se déconnecter';

  @override
  String get noFavorites => 'Pas encore de favoris !';

  @override
  String get loading => 'Chargement...';
}
