import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_helper/shared/constants/colors.dart';
import 'package:online_helper/shared/global_variable.dart';

import '../../category/cubit/category_cubit.dart';
import '../../shared/component/input_field.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_states.dart';

class AddProductScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.grey,
      appBar: AppBar(),
      body: BlocConsumer<ProductCubit, ProductStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var productCubit = ProductCubit.get(context);
          var categroyCubit = CategoryCubit.get(context);
          return Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 0.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                          isExpanded: true,
                                          underline: null,
                                          hint: const Text('choose'),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          value: productCubit.category,
                                          items: categroyCubit.categories
                                              .map<DropdownMenuItem<String>>(
                                                  (e) {
                                            return DropdownMenuItem(
                                              value: e.name,
                                              child: Text(e.name!),
                                            );
                                          }).toList(),
                                          onChanged: (v) {
                                            //cubit.setCategory(v!);
                                            print(v);
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Visibility(
                                  visible: productCubit.showField,
                                  child: inputField(
                                    controller: categoryController,
                                    hintText: 'category',
                                  ),
                                ),
                              )
                            ],
                          ),
                          inputField(
                            controller: nameController,
                            hintText: 'name',
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: inputField(
                                  controller: priceController,
                                  hintText: 'price',
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              Expanded(
                                child: inputField(
                                    controller: costController,
                                    hintText: 'cost',
                                    keyboardType: TextInputType.number),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: inputField(
                                    controller: taxController,
                                    hintText: 'tax',
                                    keyboardType: TextInputType.number),
                              ),
                              Expanded(
                                child: inputField(
                                    controller: amountController,
                                    hintText: 'amount',
                                    keyboardType: TextInputType.number),
                              ),
                            ],
                          ),
                          inputField(
                              controller: descriptionController,
                              hintText: 'description'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text(
          'Add',
        ),
      ),
    );
  }
}
