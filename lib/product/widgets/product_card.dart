import 'package:flutter/material.dart';
import 'package:online_helper/shared/component/image_fade.dart';
import 'package:online_helper/shared/constants/app_constants.dart';

import '../../shared/constants/colors.dart';
import '../../shared/constants/images.dart';

productCard({
  required String name,
  required int qty,
  required double price,
  int? catid,
  String? image,
  Color iconColor = Colors.white,
  Function()? edit,
}) =>
    Stack(
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
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: imageNetwork(
                    image: image ?? Images.networkImageTest,
                    fit: BoxFit.fill,
                    height: 100,
                    width: 80,
                  ),
                ),
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                          overflow: TextOverflow.ellipsis,
                           // maxLines: 1,
                          ),
                        ),
                        Text('Qty : $qty'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                subtitle: Text('EGP $price -- ${catid}'),
              )),
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
        const PositionedDirectional(
          bottom: 15,
          end: 15,
          child:
          Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.amber,
          ),
        ),
      ],
    );
