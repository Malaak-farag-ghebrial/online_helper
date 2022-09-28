
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toast({
  required String msg,
  required state,
})=> Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: chooseToastColor(state)
);

enum ToastStates{SUCCESS,WARNING, FAILED}

Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS :
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.FAILED:
      color = Colors.red;
      break;
  }
  return color;
}