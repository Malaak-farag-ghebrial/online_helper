import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_helper/category/cubit/category_states.dart';
import 'package:online_helper/product/cubit/product_cubit.dart';
import 'package:online_helper/shared/component/toast.dart';
import 'package:online_helper/shared/constants/app_constants.dart';
import 'package:online_helper/shared/global_variable.dart';
import 'package:online_helper/shared/network/locale/cached_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/category_model.dart';

class CategoryCubit extends Cubit<CategoryStates> {
  CategoryCubit() : super(InitialCategoryState());

  static CategoryCubit get(context) => BlocProvider.of(context);


  String? categoryById ;
  List<String> catId= [];
  List<CategoryModel> categories = [
    CategoryModel(id: 0, name: ' + add category'),
  ];
  List<CategoryModel> categoryList = [
    CategoryModel(id: 0, name: ' + add category'),
    CategoryModel(id: 1, name: 'clothes'),
    CategoryModel(id: 2, name: 'accessories'),
    CategoryModel(id: 3, name: 'phones'),
  ];

  void addCategory({
    required String name,
  }) async{
    Batch batch = database.batch();
    batch.insert(
      AppConst.category_table,
      CategoryModel(
        name: name,
      ).toJson(),
    );
    await batch.commit().then((value)async{
      CacheHelper.getDataList(key: AppConst.category_id).then((value){
        catId = value;
        print('cashed helper${value}');
      }).catchError((error){
        GlobalFunction.errorPrint(error, 'get catId category');
      });
      catId.add('0');
      await CacheHelper.putData(key: '${AppConst.category_id}', value: catId);

      print('CATEGORY ++++++ INSERTED');
      emit(AddCategoryState());
      getCategory();
    }).catchError((error){
      GlobalFunction.errorPrint(error,'add category');
    });
  }

  void updateCategory({
    required int id,
  required String name,
})async{
    Batch batch = database.batch();
    batch.update(
        AppConst.category_table,
        CategoryModel(
      name: name,
    ).toJson(),
    where: '${AppConst.id}=?',
      whereArgs: [id]
    );
    await batch.commit().then((value){
      print('CATEGORY +++++ UPDATED');
      emit(UpdateCategoryState());
      getCategory();
    }).catchError((error){
      GlobalFunction.errorPrint(error, 'update category');
    });
  }

  void deleteCategory(id,index,context){

  //  print('||||||||||||||||| ${ProductCubit.get(context).categoryProducts.length}');
    if(ProductCubit.get(context).categoryProducts.length == 0){
      database.delete(AppConst.category_table,
          where: '${AppConst.id}=?',
          whereArgs: [id]
      ).then((value){
        categories.removeAt(index);
        print('CATEGORY ------ DELETED');
        emit(DeleteCategoryState());
        getCategory();
      }).catchError((error){
        GlobalFunction.errorPrint(error,'delete Category');
      });
    }else{
      toast(msg: 'can\'t delete, it has some product included', state: ToastStates.WARNING);
      emit(CantDeleteCategoryState());
    }
  }

  void getCategory() {
    categories = [
      CategoryModel(id: 0, name: ' + add category'),
    ];
    database.query(AppConst.category_table).then((value) {
      for (int i = 0; i < value.length; i++) {
        categories.add(CategoryModel.fromJson(value[i]));
        // print('catId$i : ${categories[i + 1].id}');
      }
      print(categories);
      emit(GetCategoryState());
    }).catchError((error) {
      GlobalFunction.errorPrint(error,'get category');
    });
  }



  Future<String> getCategoryById(int id)async{

    emit(LoadingCategoryState());

   return await database.query(
      AppConst.category_table,
        where: '${AppConst.id}=?',
       whereArgs: [id],
    ).then((value){
    categoryById = CategoryModel.fromJson(value[0]).name;
    print('cat by id : ${categoryById}');
    emit(GetCategoryByIdState());
    return categoryById!;
    }).catchError((error){
      GlobalFunction.errorPrint(error,'get Cat By id');
    });

  }
}
