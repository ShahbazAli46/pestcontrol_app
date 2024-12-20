import 'package:accurate/utils/AppImages.dart';
import 'package:flutter/material.dart';

class NavWithBack extends StatefulWidget {
  @override
  State<NavWithBack> createState() => _NavWithBackState();
}

class _NavWithBackState extends State<NavWithBack> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), //color of shadow
            spreadRadius: 0.1, //spread radius
            blurRadius: 1, // blur radius
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
                height: 50,
                width: 50,
                child: Center(child: Icon(Icons.arrow_back_ios))),
          ),
          Image.asset(AppImages.logo),
          Icon(Icons.circle_notifications)
        ],
      ),
    );
  }
}
