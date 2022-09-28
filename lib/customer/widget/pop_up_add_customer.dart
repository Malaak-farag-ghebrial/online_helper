import 'package:flutter/material.dart';

import '../../shared/component/custom_navigator.dart';
import '../../shared/component/input_field.dart';
import '../../shared/constants/app_constants.dart';
import '../../shared/global_variable.dart';

var formKey = GlobalKey<FormState>();

addCustomerPopUp(
  context, {
  Function()? action,
  bool update = false,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConst.curveRadius),
        ),
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              right: 10,
            left: 10,
            top: 50,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: inputField(
                        controller: customerNameController,
                        hintText: 'Name',
                      ),
                    ),
                    Expanded(
                      child: inputField(
                        controller: customerPhoneController,
                        hintText: 'Phone',
                      ),
                    ),
                  ],
                ),
                inputField(
                  controller: customerAddressController,
                  hintText: 'Address',
                ),
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      onPressed: action,
                      child: Text(
                        update ? 'Update' : 'Add',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    ElevatedButton(
                      onPressed: () {
                        pop(context);
                        customerNameController.clear();
                        customerPhoneController.clear();
                        customerAddressController.clear();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
