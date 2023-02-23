// ignore_for_file: prefer_const_constructors

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:klicks_vendor/api/order.dart';
import 'package:klicks_vendor/modals/sale.dart';
import 'package:klicks_vendor/static/title_topbar.dart';
import 'package:klicks_vendor/static/today_sale.dart';
import 'package:klicks_vendor/values/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  SaleModal? order;
  List<SaleModal> orders = [];
  List<SaleModal> searchedorders = [];
  CalendarFormat format = CalendarFormat.twoWeeks;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateTime today = DateTime.now();
  getservice() async {
    var morder = await OrderApi.getcompleteorder();
    setState(() {
      orders = [];
      orders = morder;
      searchedorders = orders;
    });
    daySale(today);
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getservice();
    });
  }

  void _onDaySelected(DateTime day, DateTime foucsedDay) async {
    await daySale(day);
    setState(() {
      today = day;
      price = 0;
      for (var i = 0; i < searchedorders.length; i++) {
        print(searchedorders[i].price!);
        price += int.parse(searchedorders[i].price.toString());
      }
    });
  }

  daySale(DateTime day) {
    List<SaleModal> orderlist =
        orders.where((i) => i.dateTime!.day == day.day).toList();

    setState(() {
      searchedorders = orderlist;
      price = 0;
      for (var i = 0; i < searchedorders.length; i++) {
        print(searchedorders[i].price!);
        price += int.parse(searchedorders[i].price.toString());
      }
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
                height: MediaQuery.of(context).size.height * 0.89,
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
                            var format1;
                            setState(() {
                              _format == CalendarFormat.week
                                  ? size = 0.59
                                  : format == CalendarFormat.twoWeeks
                                      ? size = 0.53
                                      : size = 0.319;
                              _format == CalendarFormat.week
                                  ? format1 = 'week'
                                  : format == CalendarFormat.twoWeeks
                                      ? format1 = 'twoWeek'
                                      : format1 = 'month';
                              format = _format;
                              OrderApi.getSlaes(format1);
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
                        Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: LineChart(
                            LineChartData(
                              rangeAnnotations:
                                  RangeAnnotations(horizontalRangeAnnotations: [
                                HorizontalRangeAnnotation(
                                  y1: 0.0,
                                  y2: 25.0,
                                  color: Colors.white.withOpacity(0.1),
                                )
                              ]),
                              lineTouchData: LineTouchData(
                                enabled: true,
                                getTouchLineEnd: (LineChartBarData, value) {
                                  return 500;
                                },
                                touchTooltipData: LineTouchTooltipData(
                                    tooltipBgColor: Colors.white,
                                    getTooltipItems:
                                        (List<LineBarSpot> touchedBarSpots) {
                                      return touchedBarSpots.map((barSpot) {
                                        if (barSpot.y >= 0.0 &&
                                            barSpot.y <= 25.0) {
                                          return LineTooltipItem(
                                            '',
                                            const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        } else {
                                          return LineTooltipItem(
                                            '',
                                            const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        }
                                      }).toList();
                                    }),
                              ),
                              borderData: FlBorderData(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.black),
                                      left: BorderSide(color: Colors.black))),
                              gridData: FlGridData(
                                  drawHorizontalLine: true,
                                  drawVerticalLine: true,
                                  horizontalInterval: 1000,
                                  verticalInterval: 1),
                              titlesData: FlTitlesData(
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    switch (value.toInt()) {
                                      case 0:
                                        return Text('0',
                                            style: TextStyle(fontSize: 12));
                                      case 1000:
                                        return Text('1k',
                                            style: TextStyle(fontSize: 12));
                                      case 2000:
                                        return Text('2k',
                                            style: TextStyle(fontSize: 12));
                                      case 3000:
                                        return Text('3k',
                                            style: TextStyle(fontSize: 12));
                                      case 4000:
                                        return Text('4k',
                                            style: TextStyle(fontSize: 12));
                                      case 5000:
                                        return Text('5k',
                                            style: TextStyle(fontSize: 12));
                                      case 6000:
                                        return Text('6k',
                                            style: TextStyle(fontSize: 12));
                                      case 7000:
                                        return Text('7k',
                                            style: TextStyle(fontSize: 12));
                                      case 8000:
                                        return Text('8k',
                                            style: TextStyle(fontSize: 12));
                                      case 9000:
                                        return Text('9k',
                                            style: TextStyle(fontSize: 12));
                                      case 10000:
                                        return Text('10k',
                                            style: TextStyle(fontSize: 12));
                                    }
                                    return Text('');
                                  },
                                )),
                                bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    switch (value.toInt()) {
                                      case 0:
                                        return Text('jan',
                                            style: TextStyle(fontSize: 12));
                                      case 1:
                                        return Text('feb',
                                            style: TextStyle(fontSize: 12));
                                      case 2:
                                        return Text('Mar',
                                            style: TextStyle(fontSize: 12));
                                      case 3:
                                        return Text('Apr',
                                            style: TextStyle(fontSize: 12));
                                      case 4:
                                        return Text('May',
                                            style: TextStyle(fontSize: 12));
                                      case 5:
                                        return Text('Jun',
                                            style: TextStyle(fontSize: 12));
                                      case 6:
                                        return Text('Jul',
                                            style: TextStyle(fontSize: 12));
                                      case 7:
                                        return Text('Aug',
                                            style: TextStyle(fontSize: 12));
                                      case 8:
                                        return Text('Sep',
                                            style: TextStyle(fontSize: 12));
                                      case 9:
                                        return Text('Oct',
                                            style: TextStyle(fontSize: 12));
                                      case 10:
                                        return Text('Nov',
                                            style: TextStyle(fontSize: 12));
                                      case 11:
                                        return Text('Dec',
                                            style: TextStyle(fontSize: 12));
                                    }
                                    return Text('');
                                  },
                                )),
                              ),
                              minX: 0,
                              minY: 0,
                              maxX: 11,
                              maxY: 10000,
                              lineBarsData: [
                                LineChartBarData(
                                    aboveBarData: BarAreaData(),
                                    isCurved: true,
                                    color: mainColor,
                                    dotData: FlDotData(show: true),
                                    spots: [
                                      FlSpot(0, 2000),
                                      FlSpot(1, 2510),
                                      FlSpot(2, 4000),
                                      FlSpot(3, 2000),
                                      FlSpot(4, 400),
                                      FlSpot(5, 2000),
                                      FlSpot(6, 7000),
                                      FlSpot(7, 2510),
                                      FlSpot(8, 4000),
                                      FlSpot(9, 2000),
                                      FlSpot(10, 4000),
                                      FlSpot(11, 9500),
                                    ])
                              ],
                            ),
                          ),
                        ),
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
            ],
          ),
        ),
      )),
    );
  }
}
