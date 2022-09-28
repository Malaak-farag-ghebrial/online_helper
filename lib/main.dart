import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_helper/category/cubit/category_cubit.dart';
import 'package:online_helper/customer/cubit/customer_cubit.dart';
import 'package:online_helper/home/cubit/home_cubit.dart';
import 'package:online_helper/login/cubit/login_cubit.dart';
import 'package:online_helper/login/screens/login_screen.dart';
import 'package:online_helper/orders/cubit/order_cubit.dart';
import 'package:online_helper/product/cubit/product_cubit.dart';
import 'package:online_helper/shared/network/bloc_observer.dart';
import 'package:online_helper/shared/network/locale/cached_helper.dart';
import 'package:online_helper/shared/network/remote/dio_helper.dart';
import 'package:online_helper/shared/theme/light.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await DioHelper.init();
  BlocOverrides.runZoned((){
    runApp( MyApp());
  },
  blocObserver: MyBlocObserver(),
  );

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> LoginCubit()),
        BlocProvider(create: (context)=> HomeCubit()..createDatabase()),
        BlocProvider(create: (context)=> ProductCubit()..getProduct()),
        BlocProvider(create: (context)=> CategoryCubit()..getCategory()),
        BlocProvider(create: (context)=> CustomerCubit()..getCustomer()),
        BlocProvider(create: (context)=> OrderCubit()..getOrder()),
      ],
      child: MaterialApp(
        title: 'online helper',
        debugShowCheckedModeBanner: false,
        theme: light,
        home: LoginScreen(),
      ),
    );
  }
}

