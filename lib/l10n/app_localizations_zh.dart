// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '无畏契约 App';

  @override
  String get home => '主页';

  @override
  String get agents => '特工';

  @override
  String get weapons => '武器';

  @override
  String get maps => '地图';

  @override
  String get favorites => '收藏';

  @override
  String get welcome => '欢迎来到无畏契约 App';

  @override
  String get signOut => '退出登录';

  @override
  String get noFavorites => '还没有收藏！';

  @override
  String get loading => '加载中...';
}
