import 'package:flutter/material.dart';
import 'package:klicks_vendor/api/auth.dart';
import 'package:klicks_vendor/api/order.dart';
import 'package:klicks_vendor/modals/order.dart';
import 'package:klicks_vendor/screen/order%20status/order_status.dart';
import 'package:klicks_vendor/static/order.dart';
import 'package:klicks_vendor/static/searchbar.dart';
import 'package:klicks_vendor/static/title_topbar.dart';

class OrderHistry extends StatefulWidget {
  const OrderHistry({super.key});

  @override
  State<OrderHistry> createState() => _OrderHistryState();
}

class _OrderHistryState extends State<OrderHistry> {
  List<OrderModal> orders = [];
  getOrders() async {
    var morder = await OrderApi.getorder();
    setState(() {
      orders = [];
      orders = morder;
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getOrders();
    });
  }

  List<String> monthNames = [
    '', // The first item is left empty so that the index of each month corresponds to its number (i.e. January is at index 1)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          TitleTopbar(
            text: 'Order History',
            ontap: () {
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SearchBar(
                    imageIcon: 'assets/images/search.png',
                    hint: 'search',
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height * 0.77,
                  child: ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (BuildContext context, int index) {
                        String monthName =
                            monthNames[orders[index].dateTime!.month];
                        return Order(
                          orderId: orders[index].id.toString(),
                          companyname: orders[index].company,
                          cartype: orders[index].cartype,
                          dateTime: monthName +
                              ' ' +
                              orders[index].dateTime!.day.toString() +
                              ', ' +
                              orders[index].dateTime!.year.toString(),
                          imageicon: 'assets/images/car_order.svg',
                          ontap: () {
                            Navigator.push(
                              
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OrderStatus(order: orders[index])));
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
