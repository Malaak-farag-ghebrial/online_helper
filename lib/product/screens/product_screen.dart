
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_helper/category/cubit/category_cubit.dart';
import 'package:online_helper/category/cubit/category_states.dart';
import 'package:online_helper/product/cubit/product_cubit.dart';
import 'package:online_helper/product/cubit/product_states.dart';
import 'package:online_helper/product/widgets/pop_up_add_product.dart';
import 'package:online_helper/shared/constants/app_constants.dart';
import 'package:online_helper/shared/global_variable.dart';

import '../../shared/component/no_data.dart';
import '../widgets/product_card.dart';

class ShowProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var productCubit = ProductCubit.get(context);
          return Scaffold(
            body: Container(
              padding:  EdgeInsets.only(top: AppConst.paddingDistance,),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: productCubit.products.length == 0? noData() : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: productCubit.products.length,
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
                            productCubit.products[index].id!, index, 0);

                        /// delete
                        print('$index deleted');
                      }
                    },
                    child: BlocBuilder<CategoryCubit, CategoryStates>(
                      builder: (context, state){
                        var categoryCubit = CategoryCubit.get(context);
                        return InkWell(
                          onTap: () {
                            print('${productCubit.products[index].categoryId}');
                          },
                          child: productCard(
                            image: productCubit.products[index].image,
                            name: productCubit.products[index].name!,
                            qty: productCubit.products[index].amount!,
                            price: productCubit.products[index].price!,
                            catid: productCubit.products[index].categoryId,
                            edit: () async {

                              productCubit.showField = false;
                              nameController.text =
                              productCubit.products[index].name!;
                              priceController.text =
                                  productCubit.products[index].price!.toString();
                              costController.text =
                                  productCubit.products[index].cost!.toString();
                              amountController.text =
                                  productCubit.products[index].amount!.toString();
                              taxController.text =
                                  productCubit.products[index].taxes!.toString();
                              imageController.text =
                                  productCubit.products[index].image!.toString();
                              descriptionController.text = productCubit
                                  .products[index].description!
                                  .toString();
                              print('TESTTTT P ID : ${productCubit.products[index].id}');
                             await categoryCubit.getCategoryById(
                                  productCubit.products[index].categoryId!).whenComplete(()async{
                                await showDialog(
                                 context: context,
                                 builder: (context) {
                                   return  addProductPopUp(
                                     update: true,
                                     id: productCubit.products[index].id,
                                     categoryId: productCubit.products[index].categoryId,
                                     image: productCubit
                                         .products[index].image,
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
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) => addProductPopUp());
                },
                label: const Text('Add product')),
          );
        },
    );
  }
}
