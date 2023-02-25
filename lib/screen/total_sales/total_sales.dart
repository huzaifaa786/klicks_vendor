// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:klicks_vendor/api/order.dart';
import 'package:klicks_vendor/modals/sale.dart';
import 'package:klicks_vendor/modals/sales_data_model.dart';
import 'package:klicks_vendor/static/title_topbar.dart';
import 'package:klicks_vendor/values/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key, required this.id});
  final String? id;

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  SaleModal? order;
  List<SaleModal> orders = [];
  List<SaleModal> searchedorders = [];
  CalendarFormat format = CalendarFormat.week;
  var format1 = 'week';
  DateTime Ourdate = DateTime.now();
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateTime today = DateTime.now();
  List<SalesData> _spots = [];

  getservice() async {
    var morder = await OrderApi.getcompleteorder();
    setState(() {
      orders = [];
      orders = morder;
      searchedorders = orders;
    });
    daySale(today);
  }

  getsale() async {
    var sales = await OrderApi.getSlaes(format1, Ourdate, widget.id!);
    _spots = [];
    price = sales['totalSale'];
    for (var sale in sales['days']) {
      _spots.add(SalesData(
          sale['date'].toString(), double.parse(sale['amount'].toString())));
    }
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getservice();
      getsale();
    });
  }

  void _onDaySelected(DateTime day, DateTime foucsedDay) async {
    await daySale(day);
    setState(() {
      today = day;
      // price = 0;
      // for (var i = 0; i < searchedorders.length; i++) {
      //   print(searchedorders[i].price!);
      //   price += int.parse(searchedorders[i].price.toString());
      // }
    });
  }

  daySale(DateTime day) {
    List<SaleModal> orderlist =
        orders.where((i) => i.dateTime!.day == day.day).toList();
    setState(() {
      searchedorders = orderlist;
      // price = 0;
      // for (var i = 0; i < searchedorders.length; i++) {
      //   print(searchedorders[i].price!);
      //   price += int.parse(searchedorders[i].price.toString());
      // }
    });
  }

  int price = 0;
  double size = 0.53;

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
                height: MediaQuery.of(context).size.height * 0.82,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TableCalendar(
                            selectedDayPredicate: (day) =>
                                isSameDay(day, today),
                            firstDay: DateTime.utc(2010, 10, 16),
                            lastDay: DateTime.now(),
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
                            availableCalendarFormats: const {
                              CalendarFormat.month: 'Month',
                              CalendarFormat.week: 'Week',
                            },
                            onPageChanged: (date) {
                              // Update your UI based on the selected month
                              print('Selected month: ${date}');
                              // Ourdate = date;
                              // getsale();
                            },
                            calendarFormat: format,
                            onFormatChanged: (CalendarFormat _format) {
                              setState(() {
                                _format == CalendarFormat.week
                                    ? size = 0.59
                                    : size = 0.319;
                                _format == CalendarFormat.week
                                    ? format1 = 'week'
                                    : format1 = 'month';
                                format = _format;
                                getsale();
                              });
                            },
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            daysOfWeekVisible: true,
                          ),
                          Text(
                            'Order Detail',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height * size,
                          //   child: ListView.builder(
                          //       itemCount: searchedorders.length,
                          //       itemBuilder: (BuildContext context, int index) {
                          //         return TodaySale(
                          //           name: searchedorders[index].user!,
                          //           type: searchedorders[index].cartype,
                          //           price: searchedorders[index].price,
                          //           imageicon: 'assets/images/car_order.svg',
                          //         );
                          //       }),
                          // )
                          SizedBox(height: 16),
                          SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            series: <LineSeries<SalesData, String>>[
                              LineSeries<SalesData, String>(
                                dataSource: _spots,
                                xValueMapper: (SalesData sales, _) =>
                                    sales.days,
                                yValueMapper: (SalesData sales, _) =>
                                    sales.sales,
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: true),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 10, left: 10, bottom: 8, top: 8),
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
                          Text(price.toString(),
                              style: TextStyle(
                                  color: White,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(" AED",
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
      )),
    );
  }
}
