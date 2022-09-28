import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_helper/category/cubit/category_states.dart';
import 'package:online_helper/shared/component/custom_navigator.dart';
import 'package:online_helper/shared/component/input_field.dart';
import 'package:online_helper/shared/global_variable.dart';

import '../cubit/category_cubit.dart';

addCategoryPopUp(
    context,
{
 bool update = false,
  Function()? action,
}) =>  AlertDialog(
  content: inputField(
    controller: categoryController,
    hintText: 'category name',
  ),
  actions: [
    ElevatedButton(
      onPressed: action,
      child:  Text(
        update? 'Update' : 'Add',
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    ),
    ElevatedButton(
      onPressed: () {
        pop(context);
        categoryController.clear();
      },
      child: const Text(
        'Cancel',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  ],
);