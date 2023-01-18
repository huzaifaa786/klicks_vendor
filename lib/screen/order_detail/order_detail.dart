import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:klicks_vendor/static/title_topbar.dart';
import 'package:klicks_vendor/static/today_sale.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key});
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TableCalendar Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
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
          child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            TitleTopbar(
              text: 'Today Sale',
              ontap: () {},
            ),
            
            TableCalendar(
              selectedDayPredicate: (day) => isSameDay(day, today),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: today,
             onDaySelected: _onDaySelected,
             calendarStyle: Colors.blue,
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
      )),
    );
  }
}
