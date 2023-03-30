// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:klicks_vendor/api/order.dart';
import 'package:klicks_vendor/modals/extra_service_detail.dart';
import 'package:klicks_vendor/modals/order.dart';
import 'package:klicks_vendor/screen/order_status/complete_model.dart';
import 'package:klicks_vendor/static/badge.dart';
import 'package:klicks_vendor/static/button.dart';
import 'package:klicks_vendor/static/checkOut_tile.dart';
import 'package:klicks_vendor/translations/locale_keys.g.dart';
import 'package:klicks_vendor/values/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderStatus extends StatefulWidget {
  const OrderStatus({super.key, this.order});
  final OrderModal? order;
  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  List<ExtraServiceDetail> services = [];
  bool? query;
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
        padding: EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Column(
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
                            LocaleKeys.Order_detail.tr(),
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
                      ],
                    ),
                    Text("a", style: TextStyle(color: White))
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  LocaleKeys.OrderID.tr() + ' ' + widget.order!.id.toString(),
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
                        title: LocaleKeys.Vehicle_Type.tr(),
                        discription: widget.order!.cartype,
                        image: 'assets/images/vehicleType.svg',
                      ),
                      CheckOutTile(
                        title: LocaleKeys.Number_Plate.tr(),
                        discription: widget.order!.plate_number,
                        image: 'assets/images/numberPlate.svg',
                      ),
                      CheckOutTile(
                        title: LocaleKeys.Parking_Number.tr(),
                        discription: widget.order!.parking,
                        image: 'assets/images/parkingNumber.svg',
                      ),
                      CheckOutTile(
                          title: LocaleKeys.Mall.tr(),
                          discription: widget.order!.mall,
                          image: 'assets/images/mallCheckout.svg'),
                      CheckOutTile(
                          title: LocaleKeys.Floor_Number.tr(),
                          discription: widget.order!.floor,
                          image: 'assets/images/floorNumberCheck.svg'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 224, 240, 255),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: SvgPicture.asset(
                                          'assets/images/Extras.svg',
                                          height: 12,
                                          width: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    LocaleKeys.Extras.tr(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: colorgrey),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                for (var service in services)
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Text(
                                      service == ''
                                          ? 'No Extra Services'
                                          : service.service_name! + ', ',
                                      maxLines: 3,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                              ],
                            )
                          ],
                        ),
                      ),
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
                            title: LocaleKeys.completed.tr(),
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
                                title: LocaleKeys.Rejected.tr(),
                                color: Colors.red,
                                ontap: () {},
                              )
                            ],
                          )
                        : SizedBox(),
              ],
            ),
            widget.order!.status == 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LargeButton(
                          title: LocaleKeys.Accept.tr(),
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            if (await OrderApi.orderaccept(
                                widget.order!.id,
                                widget.order!.userid!,
                                prefs.getString('company_id')!)) {
                              setState(() {
                                widget.order!.status = 1;
                              });
                            }
                          },
                          screenRatio: 0.4,
                          rounded: true,
                          color: badgeGreen),
                      LargeButton(
                          title: LocaleKeys.Reject.tr(),
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            if (await OrderApi.orderreject(
                                widget.order!.id,
                                widget.order!.userid!,
                                prefs.getString('company_id')!)) {
                              setState(() {
                                widget.order!.status = 2;
                              });
                            }
                          },
                          screenRatio: 0.4,
                          rounded: true,
                          color: Colors.red),
                    ],
                  )
                : widget.order!.status == 1
                    ? Column(
                        children: [
                          LargeButton(
                            title: LocaleKeys.Order_IN_Progress.tr(),
                            onPressed: () {},
                            color: InprocessColor,
                            screenRatio: 0.45,
                            rounded: true,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          LargeButton(
                            title: LocaleKeys.Mark_as_completed.tr(),
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              query = await Alert(
                                  context: context,
                                  content: OrderCompleteStatus(
                                    id: widget.order!.id!,
                                    userId: widget.order!.userid!,
                                    company_id: prefs.getString('company_id')!,
                                  ),
                                  buttons: [
                                    DialogButton(
                                        height: 0,
                                        color: White,
                                        onPressed: () async {},
                                        child: Text(''))
                                  ]).show();
                              if (query == true) {
                                setState(() {
                                  widget.order!.status = 3;
                                });
                              }
                            },
                            color: badgeGreen,
                            screenRatio: 0.6,
                            rounded: true,
                          ),
                        ],
                      )
                    : SizedBox()
          ],
        ),
      )),
    );
  }
}
