import '../shared/constants/app_constants.dart';

class CategoryModel{
  int? id;
  String? name;


  CategoryModel({
    this.id,
    this.name,
});
  CategoryModel.fromJson(Map<String,dynamic> json){
     id   = json[AppConst.id]  ;
     name = json[AppConst.name];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = Map<String,dynamic>();
    data[AppConst.name] = name;

    return data;
  }
}