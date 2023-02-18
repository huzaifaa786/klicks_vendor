// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:klicks_vendor/api/order.dart';
import 'package:klicks_vendor/modals/Service.dart';
import 'package:klicks_vendor/modals/extra_service_detail.dart';
import 'package:klicks_vendor/modals/order.dart';
import 'package:klicks_vendor/static/badge.dart';
import 'package:klicks_vendor/static/button.dart';
import 'package:klicks_vendor/static/checkOut_tile.dart';
import 'package:klicks_vendor/static/icon_button.dart';
import 'package:klicks_vendor/static/order.dart';
import 'package:klicks_vendor/values/colors.dart';

class OrderStatus extends StatefulWidget {
  const OrderStatus({super.key, this.order});
  final OrderModal? order;
  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  List<ExtraServiceDetail> services = [];
  getservice() async {
    var morderServices =
        await OrderApi.ExtraServicesINOrder(widget.order!.id.toString());
    log(widget.order!.id.toString());
    setState(() {
      services = [];
      services = morderServices;
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getservice();
    });
  }

  String? isSelected = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(top: 50, right: 20, left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Text(
                        'Order Detail',
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                    SvgPicture.asset('assets/images/order.svg'),
                  ],
                ),
                SizedBox(height: 20),
                CheckOutTile(
                  title: 'Vehicle Type',
                  discription: widget.order!.cartype,
                ),
                CheckOutTile(
                  title: 'Build Company:',
                  discription: widget.order!.company,
                ),
                CheckOutTile(
                  title: 'Number Plate:',
                  discription: widget.order!.plate_number,
                ),
                CheckOutTile(
                  title: 'Parking Number:',
                  discription: widget.order!.parking,
                ),
                CheckOutTile(
                  title: 'Mall',
                  discription: widget.order!.mall,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        'Extras: ',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: colorgrey),
                      ),
                    ),
                    Column(
                      children: [
                        for (var service in services)
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Text(
                              service == ''
                                  ? 'No Extra Services'
                                  : service.service_name! + ', ',
                              maxLines: 3,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                          )
                      ],
                    )
                  ],
                ),
                // for (var service in services)
                //   service == null
                //       ? CheckOutTile(
                //           title: 'Extras: ',
                //           discription: '',
                //         )
                //       : CheckOutTile(
                //           title: 'Extras: ',
                //           discription: service.service_name,
                //         ),
                isSelected == 'reject'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Status',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: colorgrey),
                          ),
                          Badge(
                            title: 'Rejected',
                            color: Colors.red,
                            ontap: () {
                              OrderApi.orderaccept(widget.order!.id);
                            },
                          )
                        ],
                      )
                    : isSelected == 'accept'
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              "Order is accepted and in progress now, mark your order\n as completed after finishing the work",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: colorgrey),
                            ),
                          )
                        : SizedBox()
              ],
            ),
            isSelected == ''
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LargeButton(
                            title: 'Accept',
                            onPressed: () {
                              setState(() {
                                isSelected = 'accept';
                              });
                            },
                            screenRatio: 0.4,
                            rounded: true,
                            color: badgeGreen),
                        LargeButton(
                            title: 'Reject',
                            onPressed: () {
                              setState(() {
                                isSelected = 'reject';
                              });
                            },
                            screenRatio: 0.4,
                            rounded: true,
                            color: Colors.red),
                      ],
                    ),
                  )
                : isSelected == 'accept'
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: IconsButton(
                          title: 'Complete',
                          onPressed: () {},
                          color: badgeGreen,
                        ),
                      )
                    : SizedBox()
          ],
        ),
      )),
    );
  }
}
