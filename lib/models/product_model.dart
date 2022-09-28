import 'package:online_helper/shared/constants/app_constants.dart';

class ProductModel {
  int? id;
  String? name;
  String? image;
  int? categoryId;
  String? description;
  double? price;
  double? cost;
  double? taxes;
  int? amount;

  ProductModel({
    this.id,
    this.name,
    this.image,
    this.categoryId,
    this.description,
    this.price,
    this.cost,
    this.taxes,
    this.amount,
});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json[AppConst.id];
    name = json[AppConst.name];
    image = json[AppConst.image];
    categoryId = json[AppConst.category_id];
    description = json[AppConst.description];
    price = json[AppConst.price];
    cost = json[AppConst.cost];
    taxes = json[AppConst.tax];
    amount = json[AppConst.amount];
  }

  Map<String, dynamic>  toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    // if(id != null){
    //   data[AppConst.id] = id;
    // }
    data[AppConst.name] = name;
    data[AppConst.image] = image;
    data[AppConst.category_id] = categoryId;
    data[AppConst.description] = description;
    data[AppConst.price] = price;
    data[AppConst.cost] = cost;
    data[AppConst.tax] = taxes;
    data[AppConst.amount] = amount;

    return data;
  }
}
