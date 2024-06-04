import 'package:calendar_app/cubit/language_cubit.dart';
import 'package:calendar_app/cubit/theme_cubit.dart';
import 'package:calendar_app/helpers/themehelper.dart';
import 'package:calendar_app/routes/app_route_config.dart';
import 'package:calendar_app/routes/app_route_names.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'helpers/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(
          create: (context) => LanguageCubit(),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<LanguageCubit, AppLanguage>(
        builder: (context, language) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, theme) {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: FlexThemeData.light(
                          scheme: FlexScheme.deepBlue, useMaterial3: true)
                      .copyWith(
                          dividerTheme: DividerThemeData(
                              thickness: 1, color: Colors.grey[300]),
                          visualDensity: VisualDensity.adaptivePlatformDensity,
                          scaffoldBackgroundColor: Colors.grey[100]),
                  darkTheme: FlexThemeData.dark(
                          scheme: FlexScheme.deepBlue, useMaterial3: true)
                      .copyWith(
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    scaffoldBackgroundColor: Colors.grey.withOpacity(.08),
                  ),
                  themeMode: theme,
                  onGenerateRoute: AppRouteConfig.generateRoutes,
                  initialRoute: AppRouteNames.splashPage,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  locale: language == AppLanguage.english
                      ? const Locale('en')
                      : const Locale('ne'));
            },
          );
        },
      ),
    );
  }
}
