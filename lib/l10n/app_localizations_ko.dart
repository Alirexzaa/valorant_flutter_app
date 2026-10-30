// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '발로란트 앱';

  @override
  String get home => '홈';

  @override
  String get agents => '요원';

  @override
  String get weapons => '무기';

  @override
  String get maps => '지도';

  @override
  String get favorites => '즐겨찾기';

  @override
  String get welcome => '발로란트 앱에 오신 것을 환영합니다';

  @override
  String get signOut => '로그아웃';

  @override
  String get noFavorites => '아직 즐겨찾기가 없습니다!';

  @override
  String get loading => '로딩 중...';
}
