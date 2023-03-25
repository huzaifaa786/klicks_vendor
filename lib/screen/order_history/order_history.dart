// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:klicks_vendor/api/order.dart';
import 'package:klicks_vendor/modals/order.dart';
import 'package:klicks_vendor/screen/order_status/order_status.dart';
import 'package:klicks_vendor/static/order.dart';
import 'package:klicks_vendor/static/title_topbar.dart';
import 'package:klicks_vendor/values/colors.dart';
import 'package:toggle_switch/toggle_switch.dart';

class OrderHistry extends StatefulWidget {
  const OrderHistry({super.key});

  @override
  State<OrderHistry> createState() => _OrderHistryState();
}

class _OrderHistryState extends State<OrderHistry> {
  List<OrderModal> orders = [];
  List<OrderModal> SearchOrders = [];
  getOrders() async {
    var morder = await OrderApi.getorder();
    setState(() {
      orders = [];
      orders = morder;
      SearchOrders = orders;
    });
  }

  List<String> monthNames = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  void searchOrders(String query) {
    setState(() {
      if (query == '') {
        SearchOrders = orders;
      } else {
        SearchOrders = orders
            .where((o) =>
                o.dateTime!.toString().contains(query.toLowerCase()) ||
                o.cartype!.toLowerCase().contains(query.toLowerCase()) ||
                o.id!.toString().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getOrders();
    });
  }

  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          TitleTopbar(
            text: 'Orders',
            ontap: () {
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
            child: Column(
              children: [
                ToggleSwitch(
                  minWidth: 85,
                  minHeight: 55,
                  initialLabelIndex: i,
                  totalSwitches: 4,
                  cornerRadius: 6,
                  fontSize: 12,
                  inactiveBgColor: Colors.blue.shade50,
                  labels: ['All', 'Completed', 'In Progress', 'Rejected'],
                  onToggle: (index) {
                    if (index == 0) {
                      setState(() {
                        SearchOrders = orders;
                        i = index!;
                      });
                    } else if (index == 1) {
                      setState(() {
                        i = index!;
                        SearchOrders =
                            orders.where((i) => i.status == 3).toList();
                      });
                    } else if (index == 2) {
                      setState(() {
                        i = index!;
                        SearchOrders = orders
                            .where((i) => i.status == 0 || i.status == 1)
                            .toList();
                      });
                    } else if (index == 3) {
                      setState(() {
                        i = index!;
                        SearchOrders =
                            orders.where((i) => i.status == 2).toList();
                      });
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Total Orders: ',style: TextStyle(fontWeight: FontWeight.bold,color: hintColor),),
                      Text(SearchOrders.length.toString(),style: TextStyle(color: hintColor))
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: ListView.builder(
                      itemCount: SearchOrders.length,
                      itemBuilder: (BuildContext context, int index) {
                        // int i = index + 1;
                        String monthName =
                            monthNames[SearchOrders[index].dateTime!.month];
                        return Order(
                          orderId: SearchOrders[index].id.toString(),
                          price: SearchOrders[index].price,
                          cartype: SearchOrders[index].cartype,
                          dateTime: monthName +
                              ' ' +
                              SearchOrders[index].dateTime!.day.toString() +
                              ', ' +
                              SearchOrders[index].dateTime!.year.toString(),
                          type: SearchOrders[index].cartype,
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderStatus(
                                        order: SearchOrders[index])));
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
