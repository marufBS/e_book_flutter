import 'package:flutter/material.dart';
// import 'package:e_book/app_colors.dart' as app_colors;

class  AppTabs extends StatelessWidget {
  final Color? color;
  final String? text;
  const  AppTabs({super.key,this.text,this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color!,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 7,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Text(
        text!,
        style: TextStyle(color: Colors.white,fontSize: 20),
      ),
    );
  }
}
