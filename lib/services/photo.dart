import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kdg/services/log.dart';

class PhotoService extends ChangeNotifier {
  Dio dio1;
  Dio dio2;
  Log log;
  String apiKeyGeneratedPhotos = "agYEn0fU1n-QQmQiqSwaeQ";
  String api1 = "https://api.generated.photos/api/v1";
  String api2 = "https://api.generated.photos/api/v1";

  PhotoService() {
    log = Log();
    dio1 = Dio();
    dio2 = Dio();
    dio1.options.baseUrl = 'https://api.generated.photos/api/v1';
    dio1.options.connectTimeout = 5000; //5s
    dio1.options.receiveTimeout = 3000;
//for second Dio
    dio2.options.baseUrl = 'https://randomuser.me/api/';
    dio2.options.connectTimeout = 5000; //5s
    dio2.options.receiveTimeout = 3000;
    getRandom1();
  }
  getRandom1({String gender = "female"}) async {
    try {
      final response = await dio1.request(
        "/faces?per_page=1",
        data: {},
        options: Options(
            method: 'GET',
            headers: {'Authorization': "API-Key $apiKeyGeneratedPhotos"}),
      );
      log.i(response.data['faces'][0]['urls'].toString());
    } catch (e, stack) {
      log.e('$e:: $stack');
    }
  }

  getRandom2({String gender = "female"}) async {
    final response = await dio1.request(
      "?results=5000",
      data: {},
      options: Options(
          method: 'GET',
          headers: {'Authorization': "Authorization $apiKeyGeneratedPhotos"}),
    );
    print(response.data);
  }
}
