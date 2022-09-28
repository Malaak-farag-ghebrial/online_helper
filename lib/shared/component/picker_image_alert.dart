import 'package:flutter/material.dart';

pickImageAlert(
        {Widget? itemTitle1,
        Widget? itemTitle2,
        Function()? action1,
        Function()? action2,
        Widget? iconTrailing1,
        Widget? iconTrailing2}) =>
    AlertDialog(
      actions: [
        ListTile(
          title: itemTitle1,
          onTap: action1,
          trailing: iconTrailing1,
        ),
        ListTile(
          title: itemTitle2,
          onTap: action2,
          trailing: iconTrailing2,
        ),
      ],
    );
