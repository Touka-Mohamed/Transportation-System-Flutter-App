import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:flutter_arc_text/flutter_arc_text.dart';

class SectionedCircle extends OutlinedBorder
{
  SectionedCircle({this.startAngle= 0, this.gap = 0, required this.radius, str,});
  final double startAngle;
  final double gap;
  final double radius;

  @override
  OutlinedBorder copyWith({BorderSide? side}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;
  

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path path = Path();
    path.arcTo(rect, math.radians(startAngle), math.radians(120), false);
    path.lineTo(rect.center.dx, rect.center.dy);
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // TODO: implement paint
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    throw UnimplementedError();
  }

}

class SectionedCircleButton extends StatefulWidget
{
  SectionedCircleButton({
    Key? key,
    required this.radius,
    required this.onTap,
    this.text = '',
    this.color = Colors.white,
    this.startAngle = 0,
    this.gap = 0
  }) : super(key: key);

  final String text;
  void Function() onTap;
  Color color;
  double radius;
  double startAngle;
  double gap;

  @override
  State<StatefulWidget> createState() => SectionedCircleButtonState();
}

class SectionedCircleButtonState extends State<SectionedCircleButton>
{
  @override
  Widget build(BuildContext context)
  {
    return Material(
          shape: SectionedCircle(radius: widget.radius, startAngle: widget.startAngle, gap: widget.gap),
          color: widget.color,
          child: InkWell(
            onTap: widget.onTap,
            child: ArcText(
              radius: widget.radius * 0.75,
              textStyle: const TextStyle(
                fontSize: 10,
              ),
              text: widget.text,
              startAngle: math.radians(150 + widget.startAngle),
              placement: Placement.middle,
              interLetterAngle: math.radians(1),
              startAngleAlignment: StartAngleAlignment.center,
            ),
          ),
        );
  }

}