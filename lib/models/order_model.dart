import 'package:online_helper/shared/constants/app_constants.dart';

import 'customer_model.dart';

class OrderModel{
  int? id;
  int? productId;
  String? notes;
  String? status;
  int? customerId;

  OrderModel({
    this.id,
   this.productId,
   this.notes,
    this.customerId,
    this.status,
});

  OrderModel.fromJson(Map<String,dynamic> json){
    id = json[AppConst.id];
    productId = json[AppConst.product_id];
    customerId = json[AppConst.customer_id];
    notes = json[AppConst.note];
    status = json[AppConst.status]; /// focus spelling
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = Map<String,dynamic>();
    data[AppConst.note] = notes;
    data[AppConst.product_id] = productId;
    data[AppConst.customer_id] = customerId;
    data[AppConst.status] = status; /// focus spelling
    return data;
  }
}

/// remain customer id , name, phone, address