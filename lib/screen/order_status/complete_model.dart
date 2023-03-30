import 'package:flutter/material.dart';
import 'package:klicks_vendor/api/order.dart';
import 'package:klicks_vendor/static/button.dart';
import 'package:klicks_vendor/translations/locale_keys.g.dart';
import 'package:klicks_vendor/values/colors.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderCompleteStatus extends StatefulWidget {
  const OrderCompleteStatus(
      {Key? key,
      required this.id,
      required this.userId,
      required this.company_id})
      : super(key: key);
  final int id;
  final int userId;
  final String company_id;
  @override
  State<OrderCompleteStatus> createState() => _OrderCompleteStatusState();
}

class _OrderCompleteStatusState extends State<OrderCompleteStatus> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 6),
        Image(image: AssetImage('assets/images/checked.png')),
        Text(
          LocaleKeys.are_you_sure_to_mark_as_complete.tr(),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LargeButton(
                title: "yes",
                onPressed: () async {
                  await OrderApi.ordercomplete(
                      widget.id, widget.userId, widget.company_id);
                  Navigator.pop(context, true);
                },
                screenRatio: 0.3),
            SizedBox(width: 8),
            LargeButton(
              title: "No",
              onPressed: () {
                Navigator.pop(context);
              },
              screenRatio: 0.3,
              color: hintColor,
            )
          ],
        )
      ],
    );
  }
}
