
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_helper/category/cubit/category_cubit.dart';
import 'package:online_helper/category/cubit/category_states.dart';
import 'package:online_helper/product/cubit/product_cubit.dart';
import 'package:online_helper/product/cubit/product_states.dart';
import 'package:online_helper/product/widgets/pop_up_add_product.dart';
import 'package:online_helper/shared/component/no_data.dart';
import 'package:online_helper/shared/global_variable.dart';

import '../widgets/product_card.dart';

class ShowCategoryProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var productCubit = ProductCubit.get(context);
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: productCubit.categoryProducts.length == 0? noData() : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: productCubit.categoryProducts.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(color: Colors.red),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  secondaryBackground: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerRight,
                    decoration: const BoxDecoration(color: Colors.red),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart ||
                        direction == DismissDirection.startToEnd) {
                      productCubit.deleteProduct(
                          productCubit.categoryProducts[index].id!, index,1);

                      /// delete
                      print('$index deleted');
                    }
                  },
                  child: BlocBuilder<CategoryCubit, CategoryStates>(
                      builder: (context, state){
                        var categoryCubit = CategoryCubit.get(context);
                        return InkWell(
                          onTap: () {
                            print('${productCubit.categoryProducts[index].categoryId}');
                          },
                          child: productCard(
                            product: productCubit.products[index],
                            // image: productCubit.categoryProducts[index].image,
                            // name: productCubit.categoryProducts[index].name!,
                            // qty: productCubit.categoryProducts[index].amount!,
                            // price: productCubit.categoryProducts[index].price!,
                            edit: () async {

                              productCubit.showField = false;
                              nameController.text =
                              productCubit.categoryProducts[index].name!;
                              priceController.text =
                                  productCubit.categoryProducts[index].price!.toString();
                              costController.text =
                                  productCubit.categoryProducts[index].cost!.toString();
                              amountController.text =
                                  productCubit.categoryProducts[index].amount!.toString();
                              taxController.text =
                                  productCubit.categoryProducts[index].taxes!.toString();
                              imageController.text =
                                  productCubit.categoryProducts[index].image!.toString();
                              descriptionController.text = productCubit
                                  .categoryProducts[index].description!
                                  .toString();
                              print('TESTTTT P ID : ${productCubit.categoryProducts[index].id}');
                              await categoryCubit.getCategoryById(
                                  productCubit.categoryProducts[index].categoryId!).whenComplete(()async{
                                await showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return  addProductPopUp(
                                      update: true,
                                      id: productCubit.categoryProducts[index].id,
                                      categoryId: productCubit.categoryProducts[index].categoryId,
                                      image: productCubit
                                          .categoryProducts[index].image,
                                      category: categoryCubit.categoryById,
                                    );
                                  },
                                );
                              },
                              );
                            },
                          ),
                        );
                      }
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
