import 'package:flutter/material.dart';
import '../../shared/constants/app_constants.dart';

card({
  required String name,
  int qty = 0,
  Widget? centerWidget,
  Color color = Colors.amber,
  IconData icon = Icons.subject,
  Function()? onTap,
}) =>
    InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          color: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConst.curveRadius),
          ),
          elevation: 10,
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(AppConst.curveRadius),),
            ),
            child: ListTile(
              title: TextButton.icon(
                  onPressed: null,
                  icon:  Icon(icon),
                  label: Text(name)),
              subtitle: Column(
                children: [
                  const SizedBox(height: 20,),
                  centerWidget?? Text(
                    '$qty',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: color, fontSize: 50),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
