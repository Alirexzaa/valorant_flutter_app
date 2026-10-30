// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Приложение Valorant';

  @override
  String get home => 'Главная';

  @override
  String get agents => 'Агенты';

  @override
  String get weapons => 'Оружие';

  @override
  String get maps => 'Карты';

  @override
  String get favorites => 'Избранное';

  @override
  String get welcome => 'Добро пожаловать в приложение Valorant';

  @override
  String get signOut => 'Выйти';

  @override
  String get noFavorites => 'Пока нет избранного!';

  @override
  String get loading => 'Загрузка...';
}
