
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_helper/category/cubit/category_cubit.dart';
import 'package:online_helper/home/cubit/home_cubit.dart';
import 'package:online_helper/home/cubit/home_states.dart';
import 'package:online_helper/orders/screens/order_screen.dart';
import 'package:online_helper/product/cubit/product_cubit.dart';
import 'package:online_helper/product/cubit/product_states.dart';
import 'package:online_helper/product/widgets/pop_up_add_product.dart';
import 'package:online_helper/shared/component/indicator.dart';
import '../../category/cubit/category_states.dart';
import '../../category/widgets/pop_up_add_category.dart';
import '../widget/admin_card.dart';
import '../../product/screens/product_screen.dart';
import '../../shared/component/custom_navigator.dart';
import '../../shared/constants/colors.dart';
import '../../shared/global_variable.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder:(context,state){
        return state is LoadingState ? indicator() : Scaffold(
          body: Center(
            child: GridView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              children: [
                // card(
                //     name: 'customers',
                //     qty: '15',
                //     icon: Icons.person_outline_rounded,
                //     onTap: () {},),
                BlocBuilder<ProductCubit,ProductStates>(builder: (context,state){
                  return card(
                    name: 'products',
                    icon: Icons.dashboard_customize_outlined,
                    qty:  ProductCubit.get(context).products.length,
                    onTap: () {
                      navigateTo(context, ShowProductScreen());
                    },
                  );
                },),
                card(
                  name: 'orders',
                  icon: Icons.shop_rounded,
                  qty: 32,
                  onTap: () {
                    navigateTo(context, OrderScreen(),
                    );
                  },),
                // card(
                //     name: 'categories',
                //     icon: Icons.category_outlined,
                //     qty: '5',
                //     onTap: () {},),
                BlocBuilder<CategoryCubit,CategoryStates>(
                    builder: (context,state){
                      var categoryCubit = CategoryCubit.get(context);
                  return card(
                    name: 'add product',
                    icon: Icons.add_task,
                    centerWidget: const Icon(
                      Icons.add_circle_outlined,
                      color: Colors.amber,
                      size: 50,
                    ),
                    onTap: () async{
                      await showDialog(context: context,
                        builder: (context) => addProductPopUp(),);
                    },);
                }),
                BlocBuilder<CategoryCubit,CategoryStates>(
                  builder: (context,state){
                    var categoryCubit = CategoryCubit.get(context);
                    return card(
                      name: 'add category',
                      icon: Icons.add_circle_outline_sharp,
                      centerWidget: Icon(
                        Icons.add_circle_outline_sharp,
                        color: ColorRes.homeColor,
                        size: 50,
                      ),
                      onTap: () {
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
                    );
                  }
                  ,)
              ],
            ),
          ),
        );
      }
    );
  }
}
