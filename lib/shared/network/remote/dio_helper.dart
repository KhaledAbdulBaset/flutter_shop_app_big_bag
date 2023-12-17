import 'package:dio/dio.dart';
class dioHelper {

  static late Dio dio;

  static Inite() {
    dio = Dio(
        BaseOptions(
          baseUrl: "https://student.valuxapps.com/api/",
          receiveDataWhenStatusError: true,

        )

    );
  }


  static Future<Response> getData({
    required String url,
    required Map<String, dynamic>? quires,
    String lang = "en",
    String? Authorization
  }) async {
    dio.options.headers =
    {
      "Content-Type": "application/json",
      "lang": lang,
      "Authorization": Authorization
    };
    return await dio!.get(url, queryParameters: quires);
  }


  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? quires,
    required Map<String, dynamic> dataToPost,
    String lang = "ar",
    String? Authorization
  }) async {
    dio.options.headers =
    {
      "Content-Type": "application/json",
      "lang": lang,
      "Authorization": Authorization
    }
    ;

    return await dio.post(
        url,
        queryParameters: quires,
        data: dataToPost

    );
  }


static  Future<Response> updateData({
    String methodUrl="",
    Map<String, dynamic>? query,
    String? lang,
    String? token,
    required Map<String, dynamic> updatedDataMap
  }) async {
    dio.options.headers={
      "lang":lang,
      "Content-Type":"application/json",
      "Authorization":token
    };

    return await dio.put(
      methodUrl,
      queryParameters: query,
      data: updatedDataMap,

    );
  }

}