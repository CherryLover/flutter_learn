import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Net {
  Net._internal() {
    print("net init");
  }

  factory Net() => _instance;

  static late final Net _instance = Net._internal();

  Dio? _client;

  getDio() {
    if (_client == null) {
      BaseOptions options = BaseOptions();
      if (kIsWeb == true) {
        options.baseUrl = "http://localhost:8000";
      } else {
        options.baseUrl = "http://127.0.0.1:8000";
      }

      options.headers = {
        "apikey":
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyAgCiAgICAicm9sZSI6ICJhbm9uIiwKICAgICJpc3MiOiAic3VwYWJhc2UtZGVtbyIsCiAgICAiaWF0IjogMTY0MTc2OTIwMCwKICAgICJleHAiOiAxNzk5NTM1NjAwCn0.dc_X5iR_VP_qT0zsiyj_I_OZ2T9FtRU2BBNWN8Bu4GE",
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyAgCiAgICAicm9sZSI6ICJhbm9uIiwKICAgICJpc3MiOiAic3VwYWJhc2UtZGVtbyIsCiAgICAiaWF0IjogMTY0MTc2OTIwMCwKICAgICJleHAiOiAxNzk5NTM1NjAwCn0.dc_X5iR_VP_qT0zsiyj_I_OZ2T9FtRU2BBNWN8Bu4GE",
      };

      _client = Dio(options);
      _client?.interceptors.add(NetLogInterceptor());
    }
    return _client;
  }
}

class NetLogInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("--> ${options.method} ${options.uri}");
    options.headers.forEach((key, value) {
      print("$key:$value");
    });
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        "<-- ${response.statusCode} ${response.statusMessage} ${response.requestOptions.uri}");
    response.headers.forEach((name, values) {
      print("$name:$values");
    });
    handler.next(response);
  }
}
