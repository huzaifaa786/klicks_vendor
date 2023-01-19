// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:klicks_vendor/static/title_topbar.dart';
import 'package:klicks_vendor/static/today_sale.dart';
import 'package:klicks_vendor/values/styles.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  CalendarFormat format = CalendarFormat.month;
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
          child: Column(
        children: [
          TitleTopbar(
            text: 'Today Sale',
            ontap: () {
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                TableCalendar(
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: today,
                  onDaySelected: _onDaySelected,
                  calendarStyle: CalendarStyle(
                    markerDecoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    isTodayHighlighted: true,
                    outsideDaysVisible: false,
                  ),
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                  },
                  calendarFormat: format,
                  onFormatChanged: (CalendarFormat _format) {
                    setState(() {
                      format = _format;
                    });
                  },
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  daysOfWeekVisible: true,

                  //Day Changed
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TodaySale(
                    imageicon: 'assets/images/car2.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: TodaySale(
                    imageicon: 'assets/images/car1.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: TodaySale(
                    imageicon: 'assets/images/car2.png',
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
