import 'package:flutter/material.dart';

class testPage extends StatefulWidget {
  const testPage({Key? key}) : super(key: key);
  @override
  State<testPage> createState() => _testPageState();
}

class _testPageState extends State<testPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("TEST SCROLL"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
        ),
        body: Container(
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyText2!,
            child: LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.minHeight,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          // A fixed-height child.
                          color: const Color(0xffeeee00), // Yellow
                          height: 120.0,
                          alignment: Alignment.center,
                          child: const Text('Fixed Height Content'),
                        ),
                        Container(
                          // Another fixed-height child.
                          color: const Color(0xff008000), // Green
                          height: 120.0,
                          alignment: Alignment.center,
                          child: const Text('Fixed Height Content'),
                        ),
                        Container(
                          // Another fixed-height child.
                          color: const Color(0xff008000), // Green
                          height: 120.0,
                          alignment: Alignment.center,
                          child: const Text('Fixed Height Content'),
                        ),
                        Container(
                          // Another fixed-height child.
                          color: const Color(0xff008000), // Green
                          height: 120.0,
                          alignment: Alignment.center,
                          child: const Text('Fixed Height Content'),
                        ),
                        Container(
                          // Another fixed-height child.
                          color: const Color(0xff008000), // Green
                          height: 120.0,
                          alignment: Alignment.center,
                          child: const Text('Fixed Height Content'),
                        ),
                        Container(
                          // Another fixed-height child.
                          color: const Color(0xff008000), // Green
                          height: 120.0,
                          alignment: Alignment.center,
                          child: const Text('Fixed Height Content'),
                        ),
                        Container(
                          // Another fixed-height child.
                          color: const Color(0xff008000), // Green
                          height: 120.0,
                          alignment: Alignment.center,
                          child: const Text('Fixed Height Content'),
                        ),
                        Container(
                          // Another fixed-height child.
                          color: const Color(0xff008000), // Green
                          height: 120.0,
                          alignment: Alignment.center,
                          child: const Text('Fixed Height Content'),
                        ),
                        Container(
                          // Another fixed-height child.
                          color: const Color(0xff008000), // Green
                          height: 120.0,
                          alignment: Alignment.center,
                          child: const Text('Fixed Height Content'),
                        ),
                        Container(
                          // Another fixed-height child.
                          color: const Color(0xff008000), // Green
                          height: 120.0,
                          alignment: Alignment.center,
                          child: const Text('Fixed Height Content'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget showLoad() {
    return CircularProgressIndicator();
  }
}
