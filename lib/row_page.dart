import 'package:flutter/material.dart';


class RowPage extends StatelessWidget {
  final String title;

  const RowPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("widget.title"),
        ),
        body: Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: FractionallySizedBox(
              alignment: Alignment.center,
              // decoration: const BoxDecoration(color: Colors.red),
              // color: Colors.red,
              widthFactor: 0.5,
              heightFactor: 1,
              // decoration: const BoxDecoration(color: Colors.green),
              child: Container(
                decoration: const BoxDecoration(color: Colors.green),
                child: FractionallySizedBox(
                    heightFactor: 0.5,
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.red),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Hello", style: TextStyle(color: Colors.white)),
                          Column(
                            children: <Widget>[
                              Text("Fuck"),
                              Text("World"),
                            ],
                          ),
                          Text("World"),
                          Container(
                            width: 150,
                            child: TextField(
                              onChanged: (v) {
                                print(v);
                              },
                            ),
                          ),

                        ],
                      ),
                    )),
              )),
        ));
  }
}