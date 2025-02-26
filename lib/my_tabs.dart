import 'package:flutter/material.dart';

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
            color: Colors.grey.withAlpha((0.3*255).toInt()),
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
