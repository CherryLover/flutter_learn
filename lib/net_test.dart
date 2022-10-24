import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import './net_config.dart';

class NetTestPage extends StatefulWidget {
  const NetTestPage({Key? key}) : super(key: key);

  @override
  State<NetTestPage> createState() => _NetTestPageState();
}

class _NetTestPageState extends State<NetTestPage> {

  bool responseSuccess(int? code) {
    var a = code ?? 0;
    return a >= 200 && a < 300;
  }

  sendGet() async {
    var net = Net();
    Response response =
        await Net().getDio().get("/rest/v1/record_type?select=*");
    var data = response.data;
    if (responseSuccess(response.statusCode)) {
      print("success ${data}");
    } else {
      print("error ${response.statusCode} ${data}");
    }
  }

  sendPost() async {
    var nowTime = new DateTime.now().second;
    var parameters = {
      "amount": 23,
      "type_id": 1,
      "detail": "mock detail",
      "user_id": 1,
    };
    parameters["create"] = nowTime;
    Options opt = new Options(headers: {
      "Content-Type": "application/json",
      "Prefer": "return=representation"
    });

    Response response = await Net()
        .getDio()
        .post("/rest/v1/record", data: parameters, options: opt);
    var data = response.data;
    if (responseSuccess(response.statusCode)) {
      print("success ${data}");
    } else {
      print("error ${response.statusCode} ${data}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Net Test Page"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    sendGet();
                  },
                  child: const Text("Get"),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    sendPost();
                  },
                  child: const Text("Post"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
