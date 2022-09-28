
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_helper/customer/cubit/customer_cubit.dart';
import 'package:online_helper/orders/cubit/order_states.dart';
import 'package:online_helper/shared/constants/app_constants.dart';
import 'package:online_helper/shared/global_variable.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/order_model.dart';
import '../../shared/network/locale/cached_helper.dart';

class OrderCubit extends Cubit<OrderStates>{
  OrderCubit() : super(InitialOrderState());

  static OrderCubit get(context) => BlocProvider.of(context);

  bool showCustomer = false;
  bool setCust = false;
  int customerId = 0;
  String? customer;
  List<String> custId = [];
  List<String> status = [];
  List<OrderModel> orders = [];

  void setCustomer({
    required String selectedCustomer,
    required BuildContext context,
}){
    setCust = true;
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

  void addOrder({
    required int productId,
     String notes = '',
     required String status,
    String? custName,
    String? custAddress,
    String? custPhone,
    required BuildContext context,
})async{

    await CacheHelper.getDataList(key: '${AppConst.customer_id}').then((value){
      custId = value;
      print(value);
    }).catchError((error){
      GlobalFunction.errorPrint(error, 'get customerId order add');
    });

    Batch batch = database.batch();
    batch.insert(AppConst.id, OrderModel(
      notes: notes,
      productId: productId,
      status: status,
      customerId: showCustomer? custId.length + 1 : customerId,
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

  void deleteOrder(int id,int index){
    database.delete(AppConst.order_table,
    where: '${AppConst.id}=?',
      whereArgs: [id],
    ).then((value){
      print('ORDER ------ DELETED');
      orders.removeAt(index);
      emit(DeleteOrderState());
      getOrder();
    }).catchError((error){
      GlobalFunction.errorPrint(error, 'delete order');
    });
  }

  void getOrder(){
    status = [
      'placed',
      'delivered',
    ];
    database.query(AppConst.order_table).then((value){
      orders = [];
      for(int i=0; i<value.length;i++){
        orders.add(OrderModel.fromJson(value[i]));
        print(orders[i]);
      }
      emit(GetOrderState());
    }).catchError((error){
      GlobalFunction.errorPrint(error, 'get order');
    });
  }
}