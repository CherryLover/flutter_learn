import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  List<String> _list = [];
  List<IconData> icons = [];
  List<MaterialColor> colorList = [];

  @override
  void initState() {
    for (var i = 0; i < 40; i++) {
      _list.add("Title ${i + 1}");
    }
    icons = [
      Icons.abc,
      Icons.ac_unit,
      Icons.access_alarm,
      Icons.baby_changing_station,
      Icons.safety_check,
      Icons.safety_divider
    ];
    colorList = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.purple,
      Colors.orange
    ];
  }

  void delayAppend() {
    Future.delayed(Duration(milliseconds: 100), () {
      appendList();
      // setState(() {
      //   _list.add("Title ${_list.length}");
      // });
    });
  }

  appendList() {
    setState(() {
      var start = _list.length;
      for (var i = start; i < start + 40; i++) {
        _list.add("Title ${i + 1}");
      }
    });
  }

  Future<void> _onRefresh() async {
    // await Future.delayed(Duration(seconds: 2));
    print("refresh");
    setState(() {
      _list.clear();
    });
    await Future.delayed(Duration(seconds: 2), () {
      print("refresh");
      setState(() {
        for (var i = 0; i < 10; i++) {
          _list.add("Title ${i + 1}");
        }
      });
    });
  }

  Widget buildListItem() {
    return RefreshIndicator(
      child: ListView.builder(
        itemCount: _list.length,
        addRepaintBoundaries: false,
        addAutomaticKeepAlives: false,
        itemBuilder: (context, index) {
          if (index == _list.length - 1) {
            return Column(children: [
              ListTile(
                leading: Icon(icons[index % icons.length],
                    color: colorList[index % colorList.length]),
                title: Text(_list[index]),
              ),
              loadMore()
            ]);
          } else {
            return ListTile(
              leading: Icon(icons[index % icons.length],
                  color: colorList[index % colorList.length]),
              title: Text(_list[index]),
            );
          }
        },
      ),
      onRefresh: _onRefresh,
    );
  }

  Widget loadMore() {
    if (_list.length < 200) {
      delayAppend();
      return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 10),
                    Text("Loading...")
                  ],
                ),
                SizedBox(height: 8),
              ],
            )
          ]);
    } else {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: Text(
          "没有更多了",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List View"),
      ),
      body: buildListItem(),
      floatingActionButton: Column(children: [
        FloatingActionButton(
          onPressed: () {
            print("FloatingActionButton");
            // appendList();
          },
          child: Icon(Icons.add),
        ),
        FloatingActionButton(
          onPressed: () {
            print("FloatingActionButton");
            _onRefresh();
          },
          child: Icon(Icons.refresh),
        )
      ]),
    );
  }
}
