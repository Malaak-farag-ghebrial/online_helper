import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_helper/home/cubit/home_cubit.dart';
import 'package:online_helper/home/cubit/home_states.dart';
import 'package:online_helper/shared/component/custom_navigator.dart';

class HomeLayOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
         var homeCubit = HomeCubit.get(context);
        return WillPopScope(
          onWillPop: ()async{
            return await showDialog(context: context, builder: (ctx){
              return AlertDialog(
                title: const Text('Are you sure you want to exit ?'),
                actions: [
                  TextButton(onPressed: (){
                    SystemNavigator.pop();
                  }, child: Text('Yes'),),
                  TextButton(onPressed: (){
                    pop(context);
                  }, child: Text('No'),),
                ],
              );
            });
          },
          child: Scaffold(
            body: homeCubit.homeScreens[homeCubit.barIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: homeCubit.barIndex,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'Home',),
                BottomNavigationBarItem(icon: Icon(Icons.category_outlined,),label: 'category',),
                BottomNavigationBarItem(icon: Icon(Icons.people_outline,),label: 'Customers',),
                BottomNavigationBarItem(icon: Icon(Icons.settings,),label: 'Settings',),
              ],
              onTap: (index){
                homeCubit.changeBottomNavBarIndex(index);
              },
            ),

          ),
        );
      },
    );
  }
}

/// home
/// category
/// customer
/// setting  => profile
///
/// user name, email,
/// show image and name
