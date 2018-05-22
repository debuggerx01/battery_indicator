# flutter_battery_indicator

A battery indicator widget

![](https://github.com/debuggerx01/battery_indicator/blob/master/example/battery_indicator.gif?raw=true)


## Usage
To use this plugin, add `battery_indicator` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Example

``` dart
// Import package
import 'package:battery_indicator/battery_indicator.dart';

// Instantiate it
var batteryIndicator = new BatteryIndicator(
                                style: BatteryIndicatorStyle.values[_styleIndex],
                                colorful: _colorful,
                                showPercentNum: _showPercentNum,
                                mainColor: _color,
                                size: _size,
                                ratio: _ratio,
                                showPercentSlide: _showPercentSlide,
                              );

// and then add it to your layout .

```


## Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

For help on editing package code, view the [documentation](https://flutter.io/developing-packages/).
