import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_helper/orders/cubit/order_states.dart';
import 'package:online_helper/product/cubit/product_cubit.dart';

import '../../customer/cubit/customer_cubit.dart';
import '../../shared/component/custom_navigator.dart';
import '../../shared/component/image_fade.dart';
import '../../shared/component/input_field.dart';
import '../../shared/constants/app_constants.dart';
import '../../shared/global_variable.dart';
import '../cubit/order_cubit.dart';

var formKey = GlobalKey<FormState>();

addOrderPopUp({
  required String notes,
  Function()? action,
  required BuildContext context,
}) =>
    BlocConsumer<OrderCubit, OrderStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var orderCubit = OrderCubit.get(context);
          var productCubit = ProductCubit.get(context);
          var customerCubit = CustomerCubit.get(context);
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30,
            ),
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConst.curveRadius),
              ),
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    underline: null,
                                    hint: const Text('choose'),
                                    itemHeight: 70,
                                    value: orderCubit.product,
                                    items: productCubit.products
                                        .map<DropdownMenuItem<String>>((e) {
                                      return DropdownMenuItem(
                                        value: e.name,
                                        alignment: Alignment.center,
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              radius: 20,
                                              child: imageNetwork(
                                                image: e.image!,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            title: Text(e.name!),
                                            subtitle: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    'EGP ${e.price}',
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'QTY ${e.amount}',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      orderCubit.setProduct(
                                          selectedProduct: value!,
                                          context: context);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                      isExpanded: true,
                                      underline: null,
                                      hint: const Text('choose'),
                                      itemHeight: 70,
                                      value: orderCubit.customer,
                                      items: customerCubit.customers
                                          .map<DropdownMenuItem<String>>((e) {
                                        return DropdownMenuItem(
                                          value: e.name,
                                          alignment: Alignment.center,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ListTile(
                                              title: Text(e.name!),
                                              subtitle: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      '${e.address}',
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      '${e.phone}',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        orderCubit.setCustomer(
                                            selectedCustomer: value!,
                                            context: context);
                                      }),
                                ),
                              ),
                              Visibility(
                                visible: orderCubit.showCustomer,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              inputField(
                                                controller: customerNameController,
                                                hintText: 'Name',
                                              ),
                                              SizedBox(height: 22,),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: inputField(
                                            controller: customerPhoneController,
                                            hintText: 'Phone',
                                            keyboardType: TextInputType.phone,
                                            maxChar: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                    inputField(
                                      controller: customerAddressController,
                                      hintText: 'Address',
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              inputField(
                                controller: notesController,
                                hintText: 'Notes',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        ElevatedButton(
                          onPressed: action,
                          child: const Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            pop(context);
                            customerNameController.clear();
                            customerPhoneController.clear();
                            customerAddressController.clear();
                            notesController.clear();
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
