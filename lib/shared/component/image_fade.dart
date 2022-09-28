
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/images.dart';

imageNetwork({
  required String image,
  BoxFit fit = BoxFit.cover,
  double height = 300,
  double width = 50,
}) =>
    CachedNetworkImage(
      fadeInDuration: const Duration(milliseconds: 500),
      fadeInCurve: Curves.bounceIn,
      placeholder: (context, url) => Image.asset(
        Images.place_holder,
        fit: BoxFit.cover,
      ),
      errorWidget: (context, url, error) => Image.asset(
        Images.place_holder,
        fit: BoxFit.cover,
      ),
      imageUrl: image,
      fit: fit,
      height: height,
      width: width,
    );