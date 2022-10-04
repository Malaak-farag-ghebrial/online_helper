import 'package:online_helper/shared/constants/app_constants.dart';

class OrderModel {
  int? id;
  int? productId;
  int? customerId;
  String? notes;
  int? status;

  OrderModel({
    this.id,
    this.productId,
    this.notes,
    this.customerId,
    this.status,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json[AppConst.id];
    productId = json[AppConst.product_id];
    customerId = json[AppConst.customer_id];
    notes = json[AppConst.note];
    status = json[AppConst.status];

    /// focus spelling
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if(notes != null){
      data[AppConst.note] = notes;
    }
  if(productId != null){
    data[AppConst.product_id] = productId;
  }
   if(customerId != null){
     data[AppConst.customer_id] = customerId;
   }
    if(status != null){
      data[AppConst.status] = status;
    }
    /// focus spelling
    return data;
  }
}

/// remain customer id , name, phone, address
