import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future showToggleDialog(BuildContext context,
    {required List<String> names,
    required String title,
    required List<VoidCallback> onSelected,
    required int selectedIndex}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: names
              .map(
                (e) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Visibility(
                        visible: selectedIndex == names.indexOf(e),
                        child: const Icon(Icons.check)),
                    title: Text(e),
                    onTap: onSelected.length == names.length
                        ? onSelected[names.indexOf(e)]
                        : () {}),
              )
              .toList(),
        ),
      );
    },
  );
}

class EventAddDialog extends StatefulWidget {
  final String date;
  final Function(String, String, String) onAdd;

  const EventAddDialog({
    super.key,
    required this.date,
    required this.onAdd,
  });

  @override
  State<EventAddDialog> createState() => _EventAddDialogState();
}

class _EventAddDialogState extends State<EventAddDialog> {
  final TextEditingController eventTitleController = TextEditingController();
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("${widget.date}                        "),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: TextField(
              controller: eventTitleController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.eventTitle,
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.startDate,
                      style: const TextStyle(fontSize: 15)),
                  const SizedBox(height: 5),
                  InkWell(
                    onTap: () async {
                      final time = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      if (time != null) {
                        setState(() {
                          startTime = time;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          startTime == null
                              ? AppLocalizations.of(context)!.pickTime
                              : startTime!.format(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.endDate),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () async {
                      final time = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      if (time != null) {
                        setState(() {
                          endTime = time;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          endTime == null
                              ? AppLocalizations.of(context)!.pickTime
                              : endTime!.format(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: TextField(
              maxLines: 6,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                isDense: true,
                labelText: AppLocalizations.of(context)!.eventDescription,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            if (eventTitleController.text.isNotEmpty) {
              widget.onAdd(
                eventTitleController.text,
                "${startTime!.hour}:${startTime!.minute}",
                "${endTime!.hour}:${endTime!.minute}",
              );
              Navigator.of(context).pop();
            }
          },
          child: Text(AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }
}
