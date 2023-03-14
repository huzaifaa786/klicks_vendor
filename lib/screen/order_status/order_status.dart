// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:klicks_vendor/api/order.dart';
import 'package:klicks_vendor/modals/extra_service_detail.dart';
import 'package:klicks_vendor/modals/order.dart';
import 'package:klicks_vendor/static/badge.dart';
import 'package:klicks_vendor/static/button.dart';
import 'package:klicks_vendor/static/checkOut_tile.dart';
import 'package:klicks_vendor/static/icon_button.dart';
import 'package:klicks_vendor/values/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(60),
                          ),
                        ),
                        child: Icon(
                          Icons.keyboard_arrow_left_outlined,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 6.0),
                          child: Text(
                            'Order Detail',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                        FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SvgPicture.asset('assets/images/order.svg',
                                height: 20, width: 20)),
                                Text('')
                      ],
                    ),
                
                  ],
                ),
                    SizedBox(height: 30),
                     Text('Order ID '+  
                 widget.order!.id.toString(),
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(right: 2, left: 1),
                  padding:
                      EdgeInsets.only(right: 12, left: 12, top: 16, bottom: 16),
                  decoration: BoxDecoration(
                    color: White,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  
                  child: Column(
                    children: [
                      CheckOutTile(
                        title: 'Vehicle Type',
                        discription: widget.order!.cartype,
                        image: 'assets/images/vehicleType.svg',
                      ),
                      CheckOutTile(
                        title: 'Number Plate',
                        discription: widget.order!.plate_number,
                        image: 'assets/images/numberPlate.svg',
                      ),
                      CheckOutTile(
                        title: 'Prking Number',
                        discription: widget.order!.parking,
                        image: 'assets/images/parkingNumber.svg',
                      ),
                      CheckOutTile(
                          title: 'Mall',
                          discription: widget.order!.mall,
                          image: 'assets/images/mallCheckout.svg'),
                      CheckOutTile(
                          title: 'Floor Number',
                          discription: widget.order!.floor,
                          image: 'assets/images/floorNumberCheck.svg'),
                      CheckOutTile(
                          title: 'Extra',
                          discription: widget.order!.service == null
                              ? 'No, Extra service added'
                              : widget.order!.service!.length.toString() +
                                  ' ' +
                                  'Extra service added',
                          image: 'assets/images/Extras.svg'),
                      Text(
                        widget.order!.price! + " AED",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 23),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                SizedBox(height: 40),
                widget.order!.status == 3
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Badge(
                            title: 'Complete',
                            color: Colors.green,
                            ontap: () {},
                          )
                        ],
                      )
                    : widget.order!.status == 2
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Badge(
                                title: 'Rejected',
                                color: Colors.red,
                                ontap: () {},
                              )
                            ],
                          )
                        : SizedBox(),
              ],
            ),
            widget.order!.status == 0
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 380),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LargeButton(
                            title: 'Accept',
                            onPressed: () async {
                              await OrderApi.orderaccept(widget.order!.id);
                              setState(() {
                                widget.order!.status = 1;
                              });
                            },
                            screenRatio: 0.4,
                            rounded: true,
                            color: badgeGreen),
                        LargeButton(
                            title: 'Reject',
                            onPressed: () async {
                              await OrderApi.orderreject(widget.order!.id);
                              setState(() {
                                widget.order!.status = 2;
                              });
                            },
                            screenRatio: 0.4,
                            rounded: true,
                            color: Colors.red),
                      ],
                    ),
                  )
                : widget.order!.status == 1
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 310),
                        child: Column(
                          children: [
                            Badge(
                              title: 'Order in Progress',
                              color: Color.fromARGB(255, 218, 201, 51),
                              ontap: () {},
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            LargeButton(
                              title: 'Mark as Completed',
                              onPressed: ()  {
                                 completeorder(context, widget.order!.id);
                                setState(() {
                                  widget.order!.status = 3;
                                });
                              },
                              color: badgeGreen,
                              screenRatio: 0.5,
                              rounded: true,
                            ),
                          ],
                        ),
                      )
                    : SizedBox()
          ],
        ),
      )),
    );
  }

  completeorder(
    context,
    id,
  ) async {
    print('id');

    delservice() async {
      var mMalls = await OrderApi.ordercomplete(id);
    }

    Alert(
      context: context,
      image: SvgPicture.asset('assets/images/alert.svg'),
   
      desc: "Are you sure to mark as complete ",
      buttons: [
        DialogButton(
          child: Text(
            "YES",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () async {
            await delservice();
            Navigator.pop(context);
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "NO",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0),
          ]),
        )
      ],
    ).show();
  }
}
