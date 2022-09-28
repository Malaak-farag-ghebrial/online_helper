import 'package:flutter/material.dart';

navigateTo(
  BuildContext context,
  Widget route,
) =>
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => route),
    );

navigatorBackless(
  BuildContext context,
  Widget route,
) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => route),
    );

pop(BuildContext context) => Navigator.pop(context);
