// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'تطبيق فالورانت';

  @override
  String get home => 'الرئيسية';

  @override
  String get agents => 'الوكلاء';

  @override
  String get weapons => 'الأسلحة';

  @override
  String get maps => 'الخرائط';

  @override
  String get favorites => 'المفضلة';

  @override
  String get welcome => 'مرحبا بك في تطبيق فالورانت';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get noFavorites => 'لا توجد مفضلات بعد!';

  @override
  String get loading => 'جاري التحميل...';
}
