library battery_indicator;

import 'package:flutter/material.dart';

import 'package:battery/battery.dart';

enum BatteryIndicatorStyle { flat, skeumorphism }

class BatteryIndicator extends StatefulWidget {
  /// 指示器样式，[BatteryIndicatorStyle.flat]为简洁样式,[BatteryIndicatorStyle.skeumorphism]为拟物样式
  /// indicator style，[BatteryIndicatorStyle.flat] and [BatteryIndicatorStyle.skeumorphism]
  final BatteryIndicatorStyle style;

  /// 控制横宽比例，默认为2.5：1
  /// widget`s width / height , default to 2.5：1
  final double ratio;

  /// 主体颜色，包括边框和单色模式下的填充色
  /// color of borderline , and fill color when colorful is false
  final Color mainColor;

  /// 彩色模式，为true时自动根据电量绘制不同的颜色，为false时填充主体色
  /// if colorful = true , then the fill color will automatic change depend on battery value
  final bool colorful;

  /// 是否绘制百分比的电量填充
  /// whether paint fill color
  final bool showPercentSlide;

  /// 是否绘制百分比数字，建议单色模式下不要开启显示百分比
  /// whether show battery value , Recommended [NOT] set to True when colorful = false
  final bool showPercentNum;

  /// 控制整体大小，默认14.0，建议不要太大，否则很难看
  /// default to 14.0
  final double size;

  BatteryIndicator(
      {this.style = BatteryIndicatorStyle.flat,
      this.ratio = 2.5,
      this.mainColor = Colors.black,
      this.colorful = true,
      this.showPercentNum = true,
      this.showPercentSlide = true,
      this.size = 14.0});

  @override
  _BatteryIndicatorState createState() => new _BatteryIndicatorState();
}

class _BatteryIndicatorState extends State<BatteryIndicator> {
  int batteryLv = 0;
  Battery battery = new Battery();

  @override
  Widget build(BuildContext context) {
    battery.batteryLevel.then((val) {
      setState(() {
        batteryLv = val;
      });
    });

    return new Container(
      child: new SizedBox(
        height: widget.size,
        width: widget.size * widget.ratio,
        child: new CustomPaint(
          painter: new BatteryIndicatorPainter(
              batteryLv, widget.style, widget.showPercentSlide, widget.colorful, widget.mainColor),
          child: new Center(
            child: new Padding(
              padding: new EdgeInsets.only(
                  right: widget.style == BatteryIndicatorStyle.flat ? 0.0 : widget.size * widget.ratio * 0.04),
              child: widget.showPercentNum
                  ? new Text(
                      '$batteryLv',
                      style: new TextStyle(fontSize: widget.size - 2),
                    )
                  : new Text(
                      '',
                      style: new TextStyle(fontSize: widget.size - 2),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class BatteryIndicatorPainter extends CustomPainter {
  int batteryLv;
  BatteryIndicatorStyle style;
  bool colorful;
  bool showPercentSlide;
  Color mainColor;

  BatteryIndicatorPainter(this.batteryLv, this.style, this.showPercentSlide, this.colorful, this.mainColor);

  @override
  void paint(Canvas canvas, Size size) {
    if (style == BatteryIndicatorStyle.flat) {
      /// 绘制轮廓
      canvas.drawRRect(
          new RRect.fromLTRBR(0.0, size.height * 0.05, size.width, size.height * 0.95, const Radius.circular(100.0)),
          new Paint()
            ..color = mainColor
            ..strokeWidth = 0.5
            ..style = PaintingStyle.stroke);

      if (showPercentSlide) {
        /// 制作绘制遮盖区域
        canvas.clipRect(
            new Rect.fromLTWH(0.0, size.height * 0.05, size.width * fixedBatteryLv / 100, size.height * 0.95));

        double offset = size.height * 0.1;

        /// 绘制填充
        canvas.drawRRect(
            new RRect.fromLTRBR(offset, size.height * 0.05 + offset, size.width - offset, size.height * 0.95 - offset,
                const Radius.circular(100.0)),
            new Paint()
              ..color = colorful ? getBatteryLvColor : mainColor
              ..style = PaintingStyle.fill);
      }
    } else {
      /// 绘制拟物轮廓电池圆柱部分
      canvas.drawRRect(
          new RRect.fromLTRBR(
              0.0, size.height * 0.05, size.width * 0.92, size.height * 0.95, new Radius.circular(size.height * 0.1)),
          new Paint()
            ..color = mainColor
            ..strokeWidth = 0.8
            ..style = PaintingStyle.stroke);

      /// 绘制拟物轮廓电池头部
      canvas.drawRRect(
          new RRect.fromLTRBR(size.width * 0.92, size.height * 0.25, size.width, size.height * 0.75,
              new Radius.circular(size.height * 0.1)),
          new Paint()
            ..color = mainColor
            ..style = PaintingStyle.fill);

      if (showPercentSlide) {
        /// 制作绘制遮盖区域
        canvas.clipRect(
            new Rect.fromLTWH(0.0, size.height * 0.05, size.width * 0.92 * fixedBatteryLv / 100, size.height * 0.95));

        double offset = size.height * 0.1;

        /// 绘制填充
        canvas.drawRRect(
            new RRect.fromLTRBR(offset, size.height * 0.05 + offset, size.width * 0.92 - offset,
                size.height * 0.95 - offset, new Radius.circular(size.height * 0.1)),
            new Paint()
              ..color = colorful ? getBatteryLvColor : mainColor
              ..style = PaintingStyle.fill);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return (oldDelegate as BatteryIndicatorPainter).batteryLv != batteryLv ||
        (oldDelegate as BatteryIndicatorPainter).mainColor != mainColor;
  }

  get fixedBatteryLv => batteryLv < 10 ? 4 + batteryLv / 2 : batteryLv;

  get getBatteryLvColor => batteryLv < 15 ? Colors.red : batteryLv < 30 ? Colors.orange : Colors.green;
}
