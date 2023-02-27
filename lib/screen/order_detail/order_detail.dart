// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:klicks_vendor/modals/order.dart';
import 'package:klicks_vendor/static/title_topbar.dart';
import 'package:klicks_vendor/static/today_sale.dart';
import 'package:table_calendar/table_calendar.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key, this.order});
final OrderModal? order;
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

  String str = 'bezkoder.com';
 

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
