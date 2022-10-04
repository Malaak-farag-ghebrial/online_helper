
import 'package:flutter/material.dart';
import 'package:online_helper/models/customer_model.dart';

import '../../shared/constants/app_constants.dart';
import '../../shared/constants/colors.dart';

customerCard({
  required CustomerModel customer,
  Color iconColor = Colors.white,
  Function()? edit,
  Function()? call,
})=> Stack(
  children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 100,
          padding: const EdgeInsets.only(
            top: 10,
            right: 50,
            left: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppConst.curveRadius),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 1),
                color: Colors.grey,
                spreadRadius: 0,
                blurRadius: 2,
              ),
            ],
          ),
          child: ListTile(
            leading: SizedBox(),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        customer.name!,
                        overflow: TextOverflow.ellipsis,
                        // maxLines: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            subtitle: Row(
              children: [
                Expanded(child: Text('${customer.address}  -  ${customer.id}',),),
               // Spacer(),
                Text('${customer.phone}'),
              ],
            ),
          ),
      ),
    ),
    PositionedDirectional(
      top: 3,
      end: 20,
      width: 40,
      child: Container(
        decoration: BoxDecoration(
          color: ColorRes.homeColor,
          borderRadius:  BorderRadius.vertical(
            bottom: Radius.circular(AppConst.curveRadius,),
          ),
        ),
        child: IconButton(
          onPressed: edit,
          icon: Icon(
            Icons.edit,
            color: iconColor,
          ),
        ),
      ),
    ),
     PositionedDirectional(
      top: 34,
      start: 4,
        height: 40,
       // width: 40,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.greenAccent,//ColorRes.homeColor,

          borderRadius:  BorderRadius.horizontal(
            right: Radius.circular(AppConst.curveRadius,),
          ),
        ),
        child: IconButton(
          onPressed: call,
          icon: Icon(
            Icons.phone,
            color: iconColor,
          ),
        ),
      ),
    ),
    const PositionedDirectional(
      bottom: 20,
      end: 20,
      child:
      Icon(
        Icons.info_outline,
        color: Colors.amber,
      ),
    ),
  ],
);