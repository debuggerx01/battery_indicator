import 'package:flutter/material.dart';
import 'package:battery_indicator/battery_indicator.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _styleItems = [
    new DropdownMenuItem(
      child: new Text('skeumorphism'),
      value: 1,
    ),
    new DropdownMenuItem(
      child: new Text('flat'),
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

  Widget getColorSelector(Color color) {
    return new GestureDetector(
      onTap: () {
        setState(() {
          print(color);
          _color = color;
        });
      },
      child: new CircleAvatar(
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new SizedBox(
              width: 200.0,
              height: 100.0,
              child: new Center(
                child: new BatteryIndicator(
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
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text('color:'),
                  getColorSelector(Colors.blue),
                  getColorSelector(Colors.red),
                  getColorSelector(Colors.black),
                  getColorSelector(Colors.grey),
                  getColorSelector(Colors.yellow),
                  getColorSelector(Colors.green),
                ],
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text('size:'),
                  new Expanded(
                    child: new Slider(
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
                  new Text('ratio:'),
                  new Expanded(
                    child: new Slider(
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
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Text('colorful:'),
                new Checkbox(
                  value: _colorful,
                  onChanged: (val) {
                    setState(() {
                      _colorful = val;
                    });
                  },
                ),
                new Text('percentNum:'),
                new Checkbox(
                  value: _showPercentNum,
                  onChanged: (val) {
                    setState(() {
                      _showPercentNum = val;
                    });
                  },
                ),
                new Text('percentSlide:'),
                new Checkbox(
                  value: _showPercentSlide,
                  onChanged: (val) {
                    setState(() {
                      _showPercentSlide = val;
                    });
                  },
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Text('style:'),
                new DropdownButton(
                  value: _styleIndex,
                  items: _styleItems,
                  onChanged: (val) {
                    setState(() {
                      _styleIndex = val;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
