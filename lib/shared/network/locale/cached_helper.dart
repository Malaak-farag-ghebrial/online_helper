
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{

  static SharedPreferences? sharedPreferences;
  static init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<dynamic> putData({
    required String key,
    required dynamic value,
  })async{
    if(value is bool){
      return await sharedPreferences!.setBool(key, value);
    }
    else if(value is String){
      return await sharedPreferences!.setString(key, value);
    }
    else if(value is int){
      return await sharedPreferences!.setInt(key, value);
    }
    else if(value is List<String>){
      return await sharedPreferences!.setStringList(key, value);
    }
  }

  static Future<dynamic> getData({
    required String key,
  })async{
    return sharedPreferences!.get(key);
  }

  static Future<dynamic> getDataList({
    required String key,
  })async{
    print('##########${sharedPreferences!.getStringList(key)}');
    return  sharedPreferences!.getStringList(key);
  }

  static dynamic removeData({
    required String key,
  })async{
    return await sharedPreferences!.remove(key);
  }

  static dynamic clearData()async{
    return await sharedPreferences!.clear();
}
}