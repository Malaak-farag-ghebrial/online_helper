import '../shared/constants/app_constants.dart';

class CustomerModel{
  int? id;
  String? name;
  String? phone;
  String? address;

  CustomerModel({
    this.id,
    this.name,
    this.phone,
    this.address,
});

  CustomerModel.fromJson(Map<String,dynamic> json){
    id = json[AppConst.id];
    name = json[AppConst.name];
    phone = json[AppConst.phone];
    address = json[AppConst.address];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = Map<String,dynamic>();
    data[AppConst.name] = name;
    data[AppConst.phone] = phone;
    data[AppConst.address] = address;
    return data;
  }
}