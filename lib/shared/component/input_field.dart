import 'package:flutter/material.dart';

Widget inputField({
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  String hintText = '',
  Widget? prefixIcon,
  Widget? suffix,
  bool obscureText = false,
  bool validate = true,
  Iterable<String>? autoFill,
  Function(String value)? onSubmit,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 15,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText ,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffix,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
        ),
        autofillHints: autoFill,
        validator: (value){
              if(validate){
            if (value!.isEmpty) {
              return '$hintText is empty';
            }
          }
        },
        onFieldSubmitted: onSubmit,
      ),
    );
