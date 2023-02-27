import 'package:flutter/material.dart';

class CardCar extends StatelessWidget {
  const CardCar({
    Key? key,
    this.text,
    this.icon,
    this.color,
    this.imageicon,
    this.onpress,
    this.image,
    this.shadowColor,
  }) : super(key: key);
  final text;
  final icon;
  final color;
    final onpress;
  final imageicon;
  final shadowColor;
  final image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: MediaQuery.of(context).size.width * 0.44,
       child: Column(
         children: [
           Image(
                    image: AssetImage(
                      image,
                    ),
                  ),
                  GestureDetector(
                    onTap: onpress,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: Card(child: Text('AED '+text,style: TextStyle(fontSize: 19,fontWeight: FontWeight.w600),)),
                    ),
                  )
         ],
       ),
              
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.all(Radius.circular(6)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
    );
  }
}
