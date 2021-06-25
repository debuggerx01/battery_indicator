import 'package:flutter/material.dart';
import 'package:battery_indicator/battery_indicator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _styleItems = [
    DropdownMenuItem(
      child: Text('skeumorphism'),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text('flat'),
      value: 0,
    ),
  ];

  var _styleIndex = 0;

  var _colorful = true;

  var _showPercentSlide = true;
  var _showPercentNum = false;

  var _size = 18.0;

  var _ratio = 3.0;

  Color _color = Colors.blue;

  int bat = 34;

  void increment() {
    setState(() {
      if (bat < 100) {
        bat++;
      }
    });
  }

  void decrement() {
    setState(() {
      if (bat > 0) {
        bat--;
      }
    });
  }

  Widget getColorSelector(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          print(color);
          _color = color;
        });
      },
      child: CircleAvatar(
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200.0,
              height: 100.0,
              child: Center(
                child: BatteryIndicator(
                  batteryFromPhone: false,
                  batteryLevel: bat,
                  style: BatteryIndicatorStyle.values[_styleIndex],
                  colorful: _colorful,
                  showPercentNum: _showPercentNum,
                  mainColor: _color,
                  size: _size,
                  ratio: _ratio,
                  showPercentSlide: _showPercentSlide,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('color:'),
                  getColorSelector(Colors.blue),
                  getColorSelector(Colors.red),
                  getColorSelector(Colors.black),
                  getColorSelector(Colors.grey),
                  getColorSelector(Colors.yellow),
                  getColorSelector(Colors.green),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('size:'),
                  Expanded(
                    child: Slider(
                      min: 8.0,
                      max: 48.0,
                      divisions: 300,
                      label: '${_size.toStringAsFixed(1)}',
                      value: _size,
                      onChanged: (val) {
                        setState(() {
                          _size = val;
                        });
                      },
                    ),
                  ),
                  Text('ratio:'),
                  Expanded(
                    child: Slider(
                      min: 1.0,
                      max: 4.0,
                      divisions: 30,
                      label: '${_ratio.toStringAsFixed(1)}',
                      value: _ratio,
                      onChanged: (val) {
                        setState(() {
                          _ratio = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('colorful:'),
                Checkbox(
                  value: _colorful,
                  onChanged: (val) {
                    setState(() {
                      _colorful = val ?? _colorful;
                    });
                  },
                ),
                Text('percentNum:'),
                Checkbox(
                  value: _showPercentNum,
                  onChanged: (val) {
                    setState(() {
                      _showPercentNum = val ?? _showPercentNum;
                    });
                  },
                ),
                Text('percentSlide:'),
                Checkbox(
                  value: _showPercentSlide,
                  onChanged: (val) {
                    setState(() {
                      _showPercentSlide = val ?? _showPercentSlide;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('style:'),
                DropdownButton(
                  value: _styleIndex,
                  items: _styleItems,
                  onChanged: (val) {
                    setState(() {
                      _styleIndex = val as int;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: decrement, child: Text("Down")),
                ElevatedButton(onPressed: increment, child: Text("Up")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
