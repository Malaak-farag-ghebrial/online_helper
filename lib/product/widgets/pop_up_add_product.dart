import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_helper/category/cubit/category_cubit.dart';
import 'package:online_helper/category/cubit/category_states.dart';
import 'package:online_helper/product/cubit/product_cubit.dart';
import 'package:online_helper/product/cubit/product_states.dart';
import 'package:online_helper/shared/component/custom_navigator.dart';
import 'package:online_helper/shared/component/image_fade.dart';
import 'package:online_helper/shared/component/picker_image_alert.dart';
import 'package:online_helper/shared/constants/app_constants.dart';

import '../../shared/component/input_field.dart';
import '../../shared/constants/images.dart';
import '../../shared/global_variable.dart';

var formKey = GlobalKey<FormState>();

addProductPopUp({
  bool update = false,
  int? id,
  int? categoryId,
  String? image,
  String? category,
}) =>
    BlocConsumer<ProductCubit, ProductStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var productCubit = ProductCubit.get(context);
        var categoryCubit = CategoryCubit.get(context);
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
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            OutlinedButton(
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => pickImageAlert(
                                    itemTitle1: const Text('Camera'),
                                    iconTrailing1: const Icon(Icons.camera),
                                    action1: () {
                                      productCubit
                                          .pickImageCamera(productCubit.photo);
                                      pop(context);
                                    },
                                    itemTitle2: const Text('Gallery'),
                                    iconTrailing2:
                                        const Icon(Icons.photo_library),
                                    action2: () {
                                      productCubit
                                          .pickImageGallery(productCubit.photo);
                                      pop(context);
                                    },
                                  ),
                                );
                              },
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: productCubit.photo == null
                                    ? const Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 50,
                                        ),
                                        child: Icon(
                                          Icons.image,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(1),
                                        child: update
                                            ? imageNetwork(
                                                image: image!,
                                                fit: BoxFit.cover,
                                                width: 100,
                                              )
                                            : Image.file(
                                                productCubit.photo!,
                                                fit: BoxFit.cover,
                                                width: 100,
                                              ),
                                      ),
                              ),
                            ),
                            inputField(
                              controller: imageController,
                              hintText: 'Image Link',
                              prefixIcon: const Icon(Icons.image),
                              keyboardType: TextInputType.url,
                              validate: false,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 15,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 0.5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: BlocBuilder<CategoryCubit,CategoryStates>(
                                        builder: (context,state) {
                                          print('HEREEEE : ${categoryCubit.categoryById}');
                                          print('HEREEEE : ${productCubit.category}');
                                          return DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              underline: null,
                                              hint: const Text('choose'),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              value: update && !productCubit.set
                                                  ? categoryCubit.categoryById
                                                  : productCubit.category,
                                              items: categoryCubit.categories
                                                  .map<DropdownMenuItem<String>>(
                                                      (e) {
                                                return DropdownMenuItem(
                                                  value: e.name,
                                                  child: Text(e.name!),
                                                );
                                              }).toList(),
                                              onChanged: (v) {
                                                productCubit.setCategory(
                                                  selectedCategory: v!,
                                                  context: context,
                                                );
                                                print(v);
                                              },
                                            ),
                                          );
                                        }
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
                                      // onSubmit: (value){
                                      //   categoryCubit.addCategory(
                                      //       name: categoryController.text,
                                      //   );
                                      // }
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
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: inputField(
                                    controller: taxController,
                                    hintText: 'tax',
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                Expanded(
                                  child: inputField(
                                    controller: amountController,
                                    hintText: 'amount',
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            inputField(
                              controller: descriptionController,
                              hintText: 'description',
                              validate: false,
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
                        onPressed: () {
                          if (!update) {
                            if (formKey.currentState!.validate()) {
                              productCubit.addProduct(
                                name: nameController.text,
                                price: priceController.text,
                                image: imageController.text.isEmpty
                                    ? Images.networkImageTest
                                    : imageController.text,
                                amount: amountController.text,
                                cost: costController.text,
                                desc: descriptionController.text,
                                tax: taxController.text,
                                categoryName: categoryController.text,
                                context: context,
                              );
                              pop(context);
                              categoryController.clear();
                              nameController.clear();
                              priceController.clear();
                              costController.clear();
                              taxController.clear();
                              amountController.clear();
                              descriptionController.clear();
                            }
                          } else {
                            productCubit.updateProduct(
                             id!,
                              name: nameController.text,
                              price: priceController.text,
                              image: imageController.text,
                              amount: amountController.text,
                              cost: costController.text,
                              desc: descriptionController.text,
                              tax: taxController.text,
                              categoryById: categoryId!,
                              context: context,
                            );
                            pop(context);
                            categoryController.clear();
                            nameController.clear();
                            priceController.clear();
                            costController.clear();
                            taxController.clear();
                            amountController.clear();
                            descriptionController.clear();
                          }
                        },
                        child: Text(
                          update ? 'Update' : 'Add',
                          style: const TextStyle(
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
                          categoryController.clear();
                          nameController.clear();
                          priceController.clear();
                          costController.clear();
                          taxController.clear();
                          amountController.clear();
                          descriptionController.clear();
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
      },
    );
