// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Aplicación Valorant';

  @override
  String get home => 'Inicio';

  @override
  String get agents => 'Agentes';

  @override
  String get weapons => 'Armas';

  @override
  String get maps => 'Mapas';

  @override
  String get favorites => 'Favoritos';

  @override
  String get welcome => 'Bienvenido a la aplicación Valorant';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get noFavorites => '¡Aún no hay favoritos!';

  @override
  String get loading => 'Cargando...';
}
