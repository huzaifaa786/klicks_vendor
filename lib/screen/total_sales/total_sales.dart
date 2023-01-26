// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:klicks_vendor/static/button.dart';
import 'package:klicks_vendor/static/title_topbar.dart';
import 'package:klicks_vendor/static/today_sale.dart';
import 'package:klicks_vendor/values/colors.dart';
import 'package:klicks_vendor/values/styles.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  CalendarFormat format = CalendarFormat.twoWeeks;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime foucsedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TitleTopbar(
                text: 'Today Sale',
                ontap: () {
                  Navigator.pop(context);
                },
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.85,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TableCalendar(
                          selectedDayPredicate: (day) => isSameDay(day, today),
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: today,
                          onDaySelected: _onDaySelected,
                          calendarStyle: CalendarStyle(
                            todayDecoration: BoxDecoration(
                                color: Color.fromARGB(255, 144, 205, 255),
                                shape: BoxShape.circle),
                            selectedDecoration: BoxDecoration(
                                color: mainColor, shape: BoxShape.circle),
                            markerDecoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            isTodayHighlighted: true,
                            outsideDaysVisible: false,
                          ),
                          // availableCalendarFormats: const {
                          //   CalendarFormat.month: 'Month',
                          // },
                          calendarFormat: format,
                          onFormatChanged: (CalendarFormat _format) {
                            setState(() {
                              format = _format;
                            });
                          },
                          startingDayOfWeek: StartingDayOfWeek.sunday,
                          daysOfWeekVisible: true,
                        ),
                        Text(
                          'Order Detail',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                TodaySale(
                                  imageicon: 'assets/images/tyre.png',
                                ),
                                TodaySale(
                                  imageicon: 'assets/images/tyre.png',
                                ),
                                TodaySale(
                                  imageicon: 'assets/images/tyre.png',
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Sales",
                                style: TextStyle(
                                    color: White,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500)),
                            Row(
                              children: [
                                Text("45.00 ",
                                    style: TextStyle(
                                        color: White,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600)),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text("AED ",
                                      style: TextStyle(
                                          color: White,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
