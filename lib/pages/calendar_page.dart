import 'dart:developer';

import 'package:calendar_app/core/utils/common_dialogs.dart';
import 'package:calendar_app/cubit/language_cubit.dart';
import 'package:flutter/material.dart' hide CalendarDatePicker;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'test/calendar_test_page.dart';

/// Calendar Picker Example
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final ValueNotifier<NepaliDateTime> _selectedDate =
      ValueNotifier(NepaliDateTime.now());

  /// Events
  final List<Event> events = [
    Event(
        date: NepaliDateTime.now(),
        eventTitles: ['Holiday 23'],
        eventTimes: [TimeModel(startTime: '10:00 AM', endTime: '12:00 PM')]),
    Event(
        date: NepaliDateTime.now().add(const Duration(days: 30)),
        eventTitles: ['Holiday 1'],
        eventTimes: [TimeModel(startTime: '10:00 AM', endTime: '12:00 PM')]),
    Event(
        date: NepaliDateTime.now().subtract(const Duration(days: 5)),
        eventTitles: ['Event 1'],
        eventTimes: [TimeModel(startTime: '10:00 AM', endTime: '12:00 PM')]),
    Event(
        date: NepaliDateTime.now().add(const Duration(days: 8)),
        eventTitles: ['Seminar 1'],
        eventTimes: [TimeModel(startTime: '10:00 AM', endTime: '12:00 PM')]),
  ];

  bool isMonth = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => EventAddDialog(
                  date: getFormattedDate(_selectedDate.value),
                  onAdd: (title, startTime, endTime) {
                    final index = events.indexWhere(
                        (e) => _dayEquals(e.date, _selectedDate.value));
                    if (index != -1) {
                      events[index].eventTitles.add(title);
                      events[index].eventTimes.add(
                          TimeModel(startTime: startTime, endTime: endTime));
                    } else {
                      events.add(Event(date: _selectedDate.value, eventTitles: [
                        title
                      ], eventTimes: [
                        TimeModel(startTime: startTime, endTime: endTime)
                      ]));
                    }
                    setState(() {});
                  }));
        },
        label: Row(
          children: [
            const Icon(
              Icons.calendar_today,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(
              AppLocalizations.of(context)!.addEvent,
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  )),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                      onTap: () {
                        setState(() {
                          isMonth = true;
                        });
                      },
                      child: Container(
                        decoration: isMonth
                            ? BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(.7))
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month_rounded,
                                size: 20,
                                color: isMonth ? Colors.white : null,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(AppLocalizations.of(context)!.monthly,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isMonth ? Colors.white : null,
                                  )),
                            ],
                          ),
                        ),
                      )),
                  InkWell(
                      onTap: () {
                        setState(() {
                          isMonth = false;
                        });
                      },
                      child: Container(
                        decoration: isMonth
                            ? null
                            : BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(.7)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.timelapse_rounded,
                                size: 20,
                                color: !isMonth ? Colors.white : null,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(AppLocalizations.of(context)!.weekly,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: !isMonth ? Colors.white : null,
                                  )),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Visibility(visible: !isMonth, child: const CalendarTestPage()),
          Visibility(
            visible: isMonth,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
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
                child: BlocBuilder<LanguageCubit, AppLanguage>(
                  builder: (context, language) {
                    NepaliUtils().language = language == AppLanguage.english
                        ? Language.english
                        : Language.nepali;
                    return CalendarDatePicker(
                      initialDate: NepaliDateTime.now(),
                      firstDate: NepaliDateTime(2070),
                      lastDate: NepaliDateTime(2090),
                      onDateChanged: (date) => _selectedDate.value = date,
                      dayBuilder: (dayToBuild) {
                        return Stack(
                          children: <Widget>[
                            Center(
                              child: Text(
                                NepaliUtils().language == Language.english
                                    ? '${dayToBuild.day}'
                                    : NepaliUnicode.convert(
                                        '${dayToBuild.day}'),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: _dayEquals(
                                                dayToBuild, _selectedDate.value)
                                            ? Colors.white
                                            : null),
                              ),
                            ),
                            if (events.any(
                                (event) => _dayEquals(event.date, dayToBuild)))
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColor),
                                ),
                              )
                          ],
                        );
                      },
                      selectedDayDecoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(20),

                        // shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(.3),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(.7),
                          width: 1,
                        ),
                        // shape: BoxShape.circle,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            child: ValueListenableBuilder<NepaliDateTime>(
              valueListenable: _selectedDate,
              builder: (context, date, _) {
                Event? event;
                try {
                  event = events.firstWhere((e) => _dayEquals(e.date, date));
                } on StateError {
                  event = null;
                }

                if (event == null) {
                  return const Center(
                    child: Text('No Events'),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TodayWidget(
                        today: date,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: event.eventTitles.length,
                          itemBuilder: (context, index) => Container(
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
                            child: ListTile(
                              title: Text(event!.eventTitles[index]),
                              subtitle: Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                      '${event.eventTimes[index].startTime} - ${event.eventTimes[index].endTime}'),
                                ],
                              ),
                              onTap: () {},
                            ),
                          ),
                          separatorBuilder: (context, _) => const SizedBox(
                            height: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _dayEquals(NepaliDateTime? a, NepaliDateTime? b) =>
      a != null &&
      b != null &&
      a.toIso8601String().substring(0, 10) ==
          b.toIso8601String().substring(0, 10);
}

///
class TodayWidget extends StatelessWidget {
  ///
  final NepaliDateTime today;

  ///
  const TodayWidget({
    super.key,
    required this.today,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  NepaliDateFormat.EEEE()
                      .format(today)
                      .substring(0, 3)
                      .toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Spacer(),
            Text(
              NepaliDateFormat.d().format(today),
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

///
class Event {
  ///
  final NepaliDateTime date;

  ///
  final List<String> eventTitles;

  final List<TimeModel> eventTimes;

  ///
  Event(
      {required this.date,
      required this.eventTitles,
      required this.eventTimes});
}

String getFormattedDate(NepaliDateTime date) {
  return '${NepaliDateFormat.EEEE().format(date)}, ${NepaliDateFormat.d().format(date)} ${NepaliDateFormat.MMMM().format(date)} ${NepaliDateFormat.y().format(date)}';
}

class TimeModel {
  final String startTime;
  final String endTime;

  TimeModel({required this.startTime, required this.endTime});
}
