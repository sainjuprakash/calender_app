import 'package:calendar_app/helpers/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AppLanguage { english, nepali }

class LanguageCubit extends Cubit<AppLanguage> {
  LanguageCubit() : super(AppLanguage.english) {
    SharedPreferencesHelper.getPreferedLangauge().then((value) {
      emit(value == "en" ? AppLanguage.english : AppLanguage.nepali);
    });
  }

  void changeLanguage(AppLanguage language) async {
    await SharedPreferencesHelper.setPreferedLangauge(
        language == AppLanguage.english ? "en" : "ne");
    emit(language);
  }
}
