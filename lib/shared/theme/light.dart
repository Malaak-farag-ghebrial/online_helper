

import 'package:flutter/material.dart';

import '../constants/colors.dart';

var light = ThemeData(
  primaryColor: Colors.red,

  appBarTheme:  AppBarTheme(
    color: ColorRes.grey,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  iconTheme: const IconThemeData(
    size: 20,
    color: Colors.black54,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    hoverColor: Colors.black87,
    backgroundColor: Colors.grey,
    foregroundColor: Colors.white,
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.shifting,
    unselectedItemColor: Colors.grey,
    selectedItemColor: Colors.black,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.resolveWith((states){
        if(states.contains(MaterialState.pressed)){
          return 10;
        }
        return 5;
      }),
      backgroundColor: MaterialStateProperty.resolveWith((states){
        return Colors.white;
      },
      ),
    )
  )
);