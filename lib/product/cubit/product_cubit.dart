import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_helper/product/cubit/product_states.dart';
import 'package:online_helper/shared/network/locale/cached_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../../category/cubit/category_cubit.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../shared/constants/app_constants.dart';
import '../../shared/global_variable.dart';

class ProductCubit extends Cubit<ProductStates>{
  ProductCubit() : super(InitialAddStates());
  static ProductCubit get(context) => BlocProvider.of(context);

  String? category;
  File? photo;
  int categoryId = 0;
  bool showField = false;
  bool set = false;  // to reset the category for update
  int catId = 0;
  List<ProductModel> products = [];
  List<ProductModel> categoryProducts = [];

  void setCategory({
    required String selectedCategory,
    required BuildContext context,
}){
    set = true;
    print(set);
    category = selectedCategory;
    if(selectedCategory == CategoryCubit.get(context).categories[0].name){
      showField = true;
    }
    else{
      showField = false;
    }
    for(int i=0;i< CategoryCubit.get(context).categories.length;i++){
      if(selectedCategory == CategoryCubit.get(context).categories[i].name){
        categoryId = CategoryCubit.get(context).categories[i].id!;
      }
    }

    emit(SetCategoryProductState());
  }



  void pickImageGallery(img)async{
    img =  await ImagePicker().pickImage(source: ImageSource.gallery);
    photo = File(img!.path);
    emit(PickProductImageGalleryState());
  }

  void pickImageCamera(img)async{
    img =  await ImagePicker().pickImage(source: ImageSource.camera);
    photo = File(img!.path);
    emit(PickProductImageCameraState());
  }

  void addProduct({
    required String name,
    required String price,
    required String image,
    required String amount,
    required String cost,
    required String desc,
    required String tax,
    String? categoryName,
    required BuildContext context,
  })async{

      await CacheHelper.getData(key: '${AppConst.category_id}').then((value){
        catId = value;
    }).catchError((error){
      GlobalFunction.errorPrint(error, 'cached catId add product');
      });

    set = false;
    Batch batch = database.batch();

    batch.insert(AppConst.product_table, ProductModel(
      name: name,
      price: double.parse(price.toString()),
      image: image,
      amount: int.parse(amount.toString()),
      categoryId: showField? catId + 1  : categoryId,
      cost: double.parse(cost.toString()),
      description: desc,
      taxes: double.parse(tax.toString()),
    ).toJson(),
    );
    await batch.commit().then((value){
      print('PRODUCT ++++++ INSERTED');
      if(showField){
        CategoryCubit.get(context).addCategory(name: categoryName?? '');
      }

      emit(AddProductState());
      getProduct();
    }).catchError((error){
      GlobalFunction.errorPrint(error,'add product');
    });
  }

  void updateProduct(
      int id,
      {
        required String name,
        required String price,
        required String image,
        required String amount,
        required String cost,
        required String desc,
        required String tax,
        required int categoryById,
        String? categoryName,
        required BuildContext context,
      })async{

    await CacheHelper.getData(key: '${AppConst.category_id}').then((value){
      catId = value;
    }).catchError((error){
      GlobalFunction.errorPrint(error, 'cached catId update product');
    });

    Batch batch = database.batch();
    batch.update(AppConst.product_table,
    ProductModel(
      //id: id,
      name: name,
      image: image,
      amount: int.parse(amount.toString()),
      categoryId: set == false ? showField? catId + 1 : categoryById : categoryId,
      cost: double.parse(cost.toString()),
      price: double.parse(price.toString()),
      taxes: double.parse(tax.toString()),
      description: desc,
    ).toJson(),
      where: '${AppConst.id}=?',
      whereArgs: [id],
    );

   await batch.commit().then((value){
      print('PRODUCT ++++++ UPDATED');
      if(showField){
        CategoryCubit.get(context).addCategory(
            name: categoryName?? '',
        );
      }
      emit(UpdateProductState());
      getProduct();
      set = false;
    }).catchError((error){
      GlobalFunction.errorPrint(error,'update product');
    });
  }

  void deleteProduct(int id,index,int i){
    database.delete(AppConst.product_table,
        where: '${AppConst.id}=?',
        whereArgs: [id],
    ).then((value){
      i == 0 ? products.removeAt(index) : categoryProducts.removeAt(index);
      print('PRODUCT ------ DELETED');
      emit(DeleteProductState());
      getProduct();
    }).catchError((error){
      GlobalFunction.errorPrint(error,'delete product');
    });
  }

  void getProduct(){
    database.query(AppConst.product_table).then((value){
      products = [];
      for(int i = 0; i < value.length; i++ ){
        products.add(ProductModel.fromJson(value[i]));
        print('Cid$i : ${products[i].categoryId}');
        print('Pid$i : ${products[i].id}');
      }
      print(products[0].price);
      print(products[0].amount);
      emit(GetProductState());
    }).catchError((error){
      GlobalFunction.errorPrint(error,'get product');
    });
  }

  Future<List<ProductModel>> getCategoryProduct(int categoryId)async{
    emit(LoadingGetCategoryProductState());

   return await database.query(AppConst.product_table,
    where: '${AppConst.category_id} =?',
      whereArgs: [categoryId],
    ).then((value){
      categoryProducts = [];
      for(int i = 0; i < value.length; i++ ){
        categoryProducts.add(ProductModel.fromJson(value[i]));
        print(categoryProducts[i].name);
      }
      emit(GetCategoryProductState());
      return categoryProducts;
    }).catchError((error){
      GlobalFunction.errorPrint(error,'get cat product');
    });
  }

}