import 'package:flutter/material.dart';

customButton({
  required Widget child,
  required Function() onPressed,
}) =>
    ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.resolveWith((states){
          return const EdgeInsets.symmetric(horizontal: 20);
        }),
       backgroundColor: MaterialStateProperty.resolveWith((states){
         if(states.contains(MaterialState.pressed)){
           return Colors.black87;
         }
         return Colors.grey;
       }),
        textStyle: MaterialStateProperty.resolveWith((states){
          if(states.contains(MaterialState.pressed)){
            return const TextStyle(fontSize: 25,fontWeight: FontWeight.bold);
          }
          return const TextStyle(fontSize: 15,fontWeight: FontWeight.bold);
        })
      ),
      child: child,
    );
