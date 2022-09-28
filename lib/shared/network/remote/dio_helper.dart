

import 'package:dio/dio.dart';

import '../../constants/app_constants.dart';

class DioHelper {
  static Dio? dio;

  static init(){
    dio = Dio(
        BaseOptions(
          baseUrl: AppConst.base_url,
          receiveDataWhenStatusError: true,
        )
    );}

  static Future<Response> getData({
    required String url,
    Map<String,dynamic>? query,
  }) async {
    return await dio!.get(
        url,
        queryParameters: query,
    ).catchError((onError){
      return onError;
    });
  }

  static Future<Response> postData({
    required String url,
    dynamic query,
    dynamic data,
})async{
    return await dio!.post(
    url,
    data: data,
    options: Options(
      followRedirects: false,
      validateStatus: (status){
        return status! < 500;
      }
    ),
    queryParameters: query,
    ).catchError((onError){
      print(onError);
    });
}

static Future<Response> updateData({
  required String url,
  dynamic data,
  Map<String,dynamic>? query,
})async{
    return await dio!.put(url,
    data: data,
      queryParameters: query,
    );
}

static Future<Response> deleteData({
  required String url,
  Map<String,dynamic>? query,
  dynamic data,
})async{
    return await dio!.delete(url,
    queryParameters: query,
      data: data,
    );
}

  static Future downloadData({
   required String url,
   required String urlSave,
})async{
    return await dio!.download(url, urlSave);
}

}