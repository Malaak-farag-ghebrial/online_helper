
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_helper/category/screens/category_screen.dart';
import 'package:online_helper/customer/screens/customer_screen.dart';
import 'package:online_helper/home/cubit/home_states.dart';
import 'package:online_helper/models/product_model.dart';
import 'package:online_helper/settings/screens/setting_screen.dart';
import 'package:online_helper/shared/global_variable.dart';
import 'package:sqflite/sqflite.dart';
import '../../shared/constants/app_constants.dart';
import '../screens/home_screen.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit() : super(InitialHomeState());

  static HomeCubit get(context) =>  BlocProvider.of(context);

  int barIndex = 0;
  List homeScreens = [
    HomeScreen(),
    CategoryScreen(),
    CustomerScreen(),
    SettingScreen(),
  ];

  Future<Database?> get db async{
    if(database == null){
      database = await createDatabase();
    }else{
      return database;
    }
  }




  void changeBottomNavBarIndex(index){
    barIndex = index;
    emit(ChangeNavBarIndexState());
  }

   createDatabase()async{
    emit(LoadingState());
    openDatabase('online_helper.db',
    version: 1,
    onCreate: (Database data , version)async{
       Batch batch = data.batch();
      batch.execute('''
      CREATE TABLE "${AppConst.product_table}" (
      '${AppConst.id}' INTEGER PRIMARY KEY AUTOINCREMENT,
      '${AppConst.name}' TEXT,
      '${AppConst.image}' TEXT,
      '${AppConst.price}' REAL,
      '${AppConst.category_id}' INTEGER,
      '${AppConst.cost}' REAL,
      '${AppConst.amount}' INTEGER,
      '${AppConst.description}' TEXT,
      '${AppConst.tax}' REAL)
      '''); // PRODUCT

      batch.execute('''
      CREATE TABLE "${AppConst.category_table}" (
      '${AppConst.id}' INTEGER PRIMARY KEY AUTOINCREMENT,
      '${AppConst.name}' TEXT)
      '''); // CATEGORY

      batch.execute('''
      CREATE TABLE "${AppConst.order_table}" (
      '${AppConst.id}' INTEGER PRIMARY KEY AUTOINCREMENT,
      '${AppConst.status}' INTEGER,
      '${AppConst.customer_id}' INTEGER,
      '${AppConst.product_id}' INTEGER,
      '${AppConst.note}' TEXT)
      '''); // ORDER

      batch.execute('''
      CREATE TABLE "${AppConst.customer_table}" (
      '${AppConst.id}' INTEGER PRIMARY KEY AUTOINCREMENT,
      '${AppConst.name}' TEXT,
      '${AppConst.address}' TEXT,
      '${AppConst.phone}' TEXT)
      '''); // CUSTOMER

      await batch.commit().then((value){
        print('TABLES ++++++++ CREATED');
      }).catchError((error){
        GlobalFunction.errorPrint(error,'create tables');
      });
    },

      onOpen: (data){
      print('DATABASE ****** OPENED');
      }
    ).then((value){
      database = value;
      emit(CreateOpenDatabaseState());
    }).catchError((error){
     GlobalFunction.errorPrint(error, 'create database');
    });
  }


}