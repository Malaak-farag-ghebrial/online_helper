
import 'package:flutter/material.dart';
import '../../shared/constants/app_constants.dart';

categoryCard({
  required String name,

  Function()? delete,
  Function()? edit,
})=> Padding(
  padding: const EdgeInsets.all(5.0),
  child: Stack(
    children: [
      Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(AppConst.curveRadius),
        ),
        child: Center(
          child: Text(
            name,//'${categoryCubit.categories[index + 1].name} / ${categoryCubit.categories[index + 1].id}',
          ),
        ),
      ),
      PositionedDirectional(
        top: 1,
        end: 20,
        height: 50,
        width: 40,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          child: IconButton(
            onPressed: edit,
            icon: const Icon(Icons.edit, color: Colors.white),
          ),
        ),
      ),
      PositionedDirectional(
        bottom: 20,
        start: 1,
        height: 40,
        width: 50,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(30),
            ),
          ),
          child: IconButton(
            onPressed: delete,
            icon: const Icon(Icons.cancel, color: Colors.white),
          ),
        ),
      ),
    ],
  ),
);