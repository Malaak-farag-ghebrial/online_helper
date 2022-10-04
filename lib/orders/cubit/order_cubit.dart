
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_helper/customer/cubit/customer_cubit.dart';
import 'package:online_helper/models/customer_model.dart';
import 'package:online_helper/orders/cubit/order_states.dart';
import 'package:online_helper/product/cubit/product_cubit.dart';
import 'package:online_helper/shared/constants/app_constants.dart';
import 'package:online_helper/shared/global_variable.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/order_model.dart';
import '../../models/product_model.dart';
import '../../shared/component/toast.dart';
import '../../shared/network/locale/cached_helper.dart';

class OrderCubit extends Cubit<OrderStates>{
  OrderCubit() : super(InitialOrderState());

  static OrderCubit get(context) => BlocProvider.of(context);

  bool showCustomer = false;
  bool setCust = false;
  int customerId = 0;
  int productId = 0;
  String? customer;
  String? product;
  List<ProductModel> productById = [];
  List<ProductModel> productByIdPlaced = [];
  List<ProductModel> productByIdBinding = [];
  List<ProductModel> productByIdDelivered = [];
  List<CustomerModel> customerByIdPlaced = [];
  List<CustomerModel> customerByIdBinding = [];
  List<CustomerModel> customerByIdDelivered = [];
  int custId = 0;
  List<OrderModel> orders = [];
  List<OrderModel> ordersPlaced = [];
  List<OrderModel> ordersBinding = [];
  List<OrderModel> ordersDelivered = [];
  List<OrderModel> customerOrder = [];

  void setCustomer({
    required String selectedCustomer,
    required BuildContext context,
}){

    customer = selectedCustomer;
    if(selectedCustomer == CustomerCubit.get(context).customers[0].name){
      showCustomer = true;
    }else{
      showCustomer = false;
    }
    for(int i =0; i< CustomerCubit.get(context).customers.length; i++){
      if(selectedCustomer == CustomerCubit.get(context).customers[i].name){
        customerId = CustomerCubit.get(context).customers[i].id!;
      }
    }
    emit(SetCustomerOrderState());
  }

  void setProduct({
    required String selectedProduct,
    required BuildContext context,
}){
    product = selectedProduct;
   for(int i=0;i< ProductCubit.get(context).products.length;i++){
     if(selectedProduct == ProductCubit.get(context).products[i].name){
       productId = ProductCubit.get(context).products[i].id!;
     }
   }
   emit(SetProductOrderState());
  }


  void addOrder({
    required int productId,
     String notes = '',
     required int status ,
    String? custName,
    String? custAddress,
    String? custPhone,
    required BuildContext context,
})async{

     await CacheHelper.getData(key: '${AppConst.customer_id}').then((value){
      custId = value;
    }).catchError((error){
      GlobalFunction.errorPrint(error, 'cached custId add order');
     });

    Batch batch = database.batch();
    batch.insert(
      AppConst.order_table,
      OrderModel(
      notes: notes,
      productId: productId,
      status: status,
      customerId: showCustomer? custId + 1 : customerId,
    ).toJson(),
    );

    await batch.commit().then((value){
      if(showCustomer){
        CustomerCubit.get(context).addCustomer(
            name: custName ?? '',
            phone: custPhone ?? '',
            address: custAddress ?? '',
        );
      }
      print('ORDER +++++ INSERTED');
      emit(AddOrderState());
      getOrder();
    }).catchError((error){
      GlobalFunction.errorPrint(error, 'add order');
    });
  }

  void updateOrder({
    required int id,
    required int status,
    int? productId,
    int? customerId,
    String? notes,
  })async{
    Batch batch = database.batch();
    batch.update(
      AppConst.order_table, OrderModel(
      productId: productId,
      customerId: customerId,
      notes: notes,
      status: status < 2 ? status + 1 : status,
    ).toJson(),
      where: '${AppConst.id}=?',
      whereArgs: [id],
    );
    await batch.commit().then((value){
      print('ORDER +++++ UPDATED');
      emit(UpdateOrderState());
      getOrder();
    }).catchError((error){
      GlobalFunction.errorPrint(error, 'update order');
    });

  }

  void deleteOrder(int id,int index,int i){

      database.delete(
        AppConst.order_table,
        where: '${AppConst.id}=?',
        whereArgs: [id],
      ).then((value) {
        print('ORDER ------ DELETED');
        if (i == 0) {
          ordersPlaced.removeAt(index);
          productByIdPlaced.removeAt(index);
        }
        if (i == 1) {
          ordersBinding.removeAt(index);
          productByIdBinding.removeAt(index);
        }
        if (i == 2) {
          ordersDelivered.removeAt(index);
          productByIdDelivered.removeAt(index);
        }
        emit(DeleteOrderState());
        getOrder();
      }).catchError((error) {
        GlobalFunction.errorPrint(error, 'delete order');
      });

  }

  void getOrder(){
    orders = [];
    ordersPlaced = [];
    ordersBinding = [];
    ordersDelivered = [];
    database.query(AppConst.order_table).then((value)async{
      for(int i=0; i<value.length;i++){
        orders.add(OrderModel.fromJson(value[i]));
        if(OrderModel.fromJson(value[i]).status == 0){
          ordersPlaced.add(OrderModel.fromJson(value[i]));
        }
        if(OrderModel.fromJson(value[i]).status == 1){
          ordersBinding.add(OrderModel.fromJson(value[i]));
        }
        if(OrderModel.fromJson(value[i]).status == 2){
          ordersDelivered.add(OrderModel.fromJson(value[i]));
        }
      }
      emit(GetOrderState());
       getProductOrder();
       getOrderCustomer();
    }).catchError((error){
      GlobalFunction.errorPrint(error, 'get order');
    });
  }

  void getProductOrder()async{
    emit(LoadingGetOrderProductByIdState());
    productById = [];
    productByIdPlaced = [];
    productByIdBinding = [];
    productByIdDelivered = [];
    for(int i=0 ; i< orders.length ; i++){
      await database.query(
        AppConst.product_table,
        where: '${AppConst.id} = ?',
        whereArgs: [orders[i].productId],
      ).then((value){
        productById.add(ProductModel.fromJson(value[0]));
        if(orders[i].status == 0){
          productByIdPlaced.add(ProductModel.fromJson(value[0]));
        }
        if(orders[i].status == 1){
          productByIdBinding.add(ProductModel.fromJson(value[0]));
        }
        if(orders[i].status == 2){
          productByIdDelivered.add(ProductModel.fromJson(value[0]));
        }
        // print('%%%%%%%%%%%% ${productByIdPlaced[i].name}');
        // print('%%%%%%%%%%%% ${productByIdBinding[i].name}');
        // print('%%%%%%%%%%%% ${productByIdDelivered[i].name}');
        emit(GetOrderProductByIdState());
      }).catchError((error){
        GlobalFunction.errorPrint(error, 'get pro order byId $i');
      });
    }
  }

  void getOrderCustomer()async{
    customerByIdPlaced = [];
    customerByIdBinding = [];
    customerByIdDelivered = [];
    for(int i = 0; i< orders.length ; i++){
      await database.query(
        AppConst.customer_table,
        where : '${AppConst.id} = ?',
        whereArgs: [orders[i].customerId],
      ).then((value){
        if(orders[i].status == 0){
          customerByIdPlaced.add(CustomerModel.fromJson(value[0]));
        }
        if(orders[i].status == 1){
          customerByIdBinding.add(CustomerModel.fromJson(value[0]));
        }
        if(orders[i].status == 2){
          customerByIdDelivered.add(CustomerModel.fromJson(value[0]));
        }

        // print('%%%%%%%%%%%% ${customerByIdPlaced[i].name}');
      }).catchError((error){
        GlobalFunction.errorPrint(error, 'get cust order byId $i');
      });
    }
  }

  Future<List<OrderModel>> getCustomerOrder(int customerId)async{
    return await database.query(
      AppConst.order_table,
    where: '${AppConst.customer_id}=?',
      whereArgs: [customerId],
    ).then((value){
      customerOrder = [];
      for(int i=0; i< value.length; i++){
        customerOrder.add(OrderModel.fromJson(value[i]));
      }
      return customerOrder;
    }).catchError((error){
      GlobalFunction.errorPrint(error, 'get cust Order');
    });
  }
}