
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_helper/category/cubit/category_cubit.dart';
import 'package:online_helper/category/cubit/category_states.dart';
import 'package:online_helper/category/widgets/category_card.dart';
import 'package:online_helper/category/widgets/pop_up_add_category.dart';
import 'package:online_helper/product/cubit/product_cubit.dart';
import 'package:online_helper/product/cubit/product_states.dart';
import 'package:online_helper/product/screens/category_product_screen.dart';
import 'package:online_helper/shared/component/custom_navigator.dart';
import 'package:online_helper/shared/constants/app_constants.dart';
import 'package:online_helper/shared/global_variable.dart';

import '../../shared/component/no_data.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var categoryCubit = CategoryCubit.get(context);
          return Scaffold(
            body: Padding(
              padding:  EdgeInsets.only(top: AppConst.paddingDistance),
              child: categoryCubit.categories.length - 1 == 0 ? noData() : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: categoryCubit.categories.length - 1,
                itemBuilder: (context, index) {
                  return BlocBuilder<ProductCubit,ProductStates>(
                    builder:(context,state){
                      var productCubit = ProductCubit.get(context);
                      return InkWell(
                        onTap: ()async{
                          /// to show product in it
                         await productCubit.getCategoryProduct(categoryCubit.categories[index + 1].id!).whenComplete((){
                           navigateTo(context, ShowCategoryProductScreen());
                         });
                        },
                        child: BlocBuilder<ProductCubit,ProductStates>(builder: (context,state){
                          return categoryCard(
                            name: '${categoryCubit.categories[index + 1].name} / ${categoryCubit.categories[index + 1].id}',
                            delete:    () async{
                              await ProductCubit.get(context).getCategoryProduct(categoryCubit.categories[index + 1].id!).then((value){
                                categoryCubit.deleteCategory(
                                  categoryCubit.categories[index + 1].id,
                                  index + 1,
                                  context,
                                );
                              });
                              // return pState is LoadingGetCategoryProductState
                              //     ? indicator()
                              //     : categoryCubit.deleteCategory(
                              //   categoryCubit.categories[index + 1].id,
                              //   index + 1,
                              //   context,
                              // );
                            },
                            edit: ()async{
                              categoryController.text =  categoryCubit.categories[index + 1].name!;
                              await showDialog(context: context, builder: (context){
                               return addCategoryPopUp(
                                 context,
                                 update: true,
                                 action: () {
                                   categoryCubit.updateCategory(
                                      id: categoryCubit.categories[index + 1].id!,
                                       name: categoryController.text,
                                   );
                                   categoryController.clear();
                                   pop(context);
                                 },
                               );
                              });
                            },
                          );
                        })
                      );
                    }
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (context)=> addCategoryPopUp(context,
                      action: () {
                          categoryCubit.addCategory(
                              name: categoryController.text,
                          );
                          categoryController.clear();
                          pop(context);
                        },
                      ),);
                },
                label: const Text('add category',),
            ),
          );
        });
  }
}
