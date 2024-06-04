import 'dart:developer';

import 'package:calendar_app/cubit/language_cubit.dart';
import 'package:calendar_app/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:intl/intl.dart';

class CalendarTestPage extends StatefulWidget {
  const CalendarTestPage({super.key});

  @override
  State<CalendarTestPage> createState() => _CalendarTestPageState();
}

class _CalendarTestPageState extends State<CalendarTestPage> {
  NepaliDateTime now = NepaliDateTime.now();
  late NepaliDateTime startDateOfWeek;

  List<String> weekDatesToShowInUI = [];
  List<String> weekDays = [];

  changeWeekDates() {
    List<String> weekDates = [];
    for (int i = 0; i < 7; i++) {
      NepaliDateTime date = startDateOfWeek.add(Duration(days: i));
      weekDates.add(date.day.toString());
    }

    weekDatesToShowInUI = weekDates;
  }

  final todayDate = NepaliDateTime.now();

  @override
  void initState() {
    super.initState();
    startDateOfWeek = now.subtract(Duration(days: now.weekday - 1));
    changeWeekDates();
    for (int i = 0; i < 7; i++) {
      NepaliDateTime date = startDateOfWeek.add(Duration(days: i));
      weekDays.add(NepaliDateFormat.E().format(date));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                      //display which month date is showing in ui

                      "${NepaliDateFormat.MMMM().format(startDateOfWeek)} ${NepaliDateFormat('yyyy').format(startDateOfWeek)}",
                      style: const TextStyle(
                        fontSize: 16,
                      )),
                  const Spacer(),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            startDateOfWeek = startDateOfWeek
                                .subtract(const Duration(days: 7));
                            changeWeekDates();
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 18,
                        ),
                      ),
                      // const SizedBox(
                      //   width: 10,
                      // ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            startDateOfWeek =
                                startDateOfWeek.add(const Duration(days: 7));
                            changeWeekDates();
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: weekDatesToShowInUI
                      .map((e) => Column(
                            children: [
                              Text(
                                weekDays[weekDatesToShowInUI.indexOf(e)],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: todayDate.day == int.parse(e)
                                      ? Theme.of(context).colorScheme.primary
                                      : null,
                                  fontWeight: todayDate.day == int.parse(e)
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              BlocBuilder<LanguageCubit, AppLanguage>(
                                builder: (context, language) {
                                  final englishDate = DateFormat('d').format(
                                      startDateOfWeek.add(Duration(
                                          days:
                                              weekDatesToShowInUI.indexOf(e))));

                                  final nepaliDate = NepaliDateFormat.d()
                                      .format(startDateOfWeek.add(Duration(
                                          days:
                                              weekDatesToShowInUI.indexOf(e))));
                                  return Text(
                                    language == AppLanguage.english
                                        ? englishDate
                                        : nepaliDate,
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: todayDate.day == int.parse(e)
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : null,
                                      fontWeight: todayDate.day == int.parse(e)
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ))
                      .toList()),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
