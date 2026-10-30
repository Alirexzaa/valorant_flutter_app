import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<String> {
  // زبان پیش‌فرض انگلیسی آمریکایی
  LanguageCubit() : super('en-US');

  void changeLanguage(String languageCode) {
    emit(languageCode);
  }
}
