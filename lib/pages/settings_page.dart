import 'package:calendar_app/core/utils/common_dialogs.dart';
import 'package:calendar_app/cubit/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/theme_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.generalSettings,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).cardColor,
            ),
            child: Column(
              children: [
                BlocBuilder<LanguageCubit, AppLanguage>(
                  builder: (context, language) {
                    return buildSettingWidget(
                      title: AppLocalizations.of(context)!.language,
                      subtitle: language == AppLanguage.english
                          ? AppLocalizations.of(context)!.english
                          : AppLocalizations.of(context)!.nepali,
                      icon: Icons.language,
                      onTap: () {
                        showToggleDialog(
                          context,
                          names: [
                            AppLocalizations.of(context)!.english,
                            AppLocalizations.of(context)!.nepali,
                          ],
                          title: AppLocalizations.of(context)!.changeLanguage,
                          onSelected: [
                            () {
                              BlocProvider.of<LanguageCubit>(context)
                                  .changeLanguage(AppLanguage.english);
                              Navigator.pop(context);
                            },
                            () {
                              BlocProvider.of<LanguageCubit>(context)
                                  .changeLanguage(AppLanguage.nepali);
                              Navigator.pop(context);
                            }
                          ],
                          selectedIndex:
                              language == AppLanguage.english ? 0 : 1,
                        );
                      },
                    );
                  },
                ),
                const Divider(),
                BlocBuilder<ThemeCubit, ThemeMode>(
                  builder: (context, theme) {
                    return buildSettingWidget(
                      title: AppLocalizations.of(context)!.theme,
                      subtitle: theme == ThemeMode.dark
                          ? AppLocalizations.of(context)!.dark
                          : AppLocalizations.of(context)!.light,
                      icon: Icons.brightness_6,
                      onTap: () {
                        showToggleDialog(context,
                            names: [
                              AppLocalizations.of(context)!.light,
                              AppLocalizations.of(context)!.dark,
                              // AppLocalizations.of(context)!.system,
                            ],
                            title: AppLocalizations.of(context)!.changeTheme,
                            onSelected: [
                              () {
                                BlocProvider.of<ThemeCubit>(context)
                                    .toggleTheme();
                                Navigator.pop(context);
                              },
                              () {
                                BlocProvider.of<ThemeCubit>(context)
                                    .toggleTheme();
                                Navigator.pop(context);
                              }
                            ],
                            selectedIndex: theme == ThemeMode.light ? 0 : 1);
                      },
                    );
                  },
                ),
                const Divider(),
                buildSettingWidget(
                  title: AppLocalizations.of(context)!.calendarDate,
                  subtitle: AppLocalizations.of(context)!.nepali,
                  icon: Icons.calendar_today,
                  onTap: () {
                    showToggleDialog(context,
                        names: [
                          AppLocalizations.of(context)!.nepali,
                          AppLocalizations.of(context)!.english,
                        ],
                        title: AppLocalizations.of(context)!.changeCalanderDate,
                        onSelected: [() {}],
                        selectedIndex: 0);
                  },
                ),
                const Divider(),
                buildSettingWidget(
                  title: AppLocalizations.of(context)!.notification,
                  subtitle: AppLocalizations.of(context)!.on,
                  icon: Icons.notifications,
                  onTap: () {
                    showToggleDialog(context,
                        names: [
                          AppLocalizations.of(context)!.on,
                          AppLocalizations.of(context)!.off,
                        ],
                        title: AppLocalizations.of(context)!.changeNotification,
                        onSelected: [() {}],
                        selectedIndex: 0);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget buildSettingWidget({
  required String title,
  required String subtitle,
  required IconData icon,
  required Function onTap,
}) {
  return ListTile(
    title: Text(title),
    subtitle: Text(subtitle),
    leading: Icon(icon),
    onTap: () {
      onTap();
    },
  );
}
