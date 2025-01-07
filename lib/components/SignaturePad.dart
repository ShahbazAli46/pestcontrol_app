import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';

class SignaturePad extends StatefulWidget {
  final Function(Uint8List)? onSignatureCapture;
  final Color strokeColor;
  final double strokeWidth;

  const SignaturePad({
    Key? key,
    this.onSignatureCapture,
    this.strokeColor = Colors.black,
    this.strokeWidth = 3.0,
  }) : super(key: key);

  @override
  SignaturePadState createState() => SignaturePadState();
}

class SignaturePadState extends State<SignaturePad> {
  List<List<Offset>> _strokes = [];
  List<Offset>? _currentStroke;

  void _onPanStart(DragStartDetails details) {
    _currentStroke = [details.localPosition];
    setState(() {
      _strokes.add(_currentStroke!);
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _currentStroke?.add(details.localPosition);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    _currentStroke = null;
  }

  Future<Uint8List?> captureSignature() async {
    if (_strokes.isEmpty) return null;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // Draw white background
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRect(const Rect.fromLTWH(0, 0, 300, 150), paint);

    // Draw signature
    paint
      ..color = widget.strokeColor
      ..strokeWidth = widget.strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (final stroke in _strokes) {
      if (stroke.length < 2) continue;

      final path = Path();
      path.moveTo(stroke[0].dx, stroke[0].dy);

      for (int i = 1; i < stroke.length; i++) {
        path.lineTo(stroke[i].dx, stroke[i].dy);
      }

      canvas.drawPath(path, paint);
    }

    final picture = recorder.endRecording();
    final img = await picture.toImage(300, 150);
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

    return byteData?.buffer.asUint8List();
  }

  void clear() {
    setState(() {
      _strokes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      child: GestureDetector(
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: CustomPaint(
          painter: SignaturePainter(
            strokes: _strokes,
            strokeColor: widget.strokeColor,
            strokeWidth: widget.strokeWidth,
          ),
        ),
      ),
    );
  }
}

class SignaturePainter extends CustomPainter {
  final List<List<Offset>> strokes;
  final Color strokeColor;
  final double strokeWidth;

  SignaturePainter({
    required this.strokes,
    required this.strokeColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (final stroke in strokes) {
      if (stroke.length < 2) continue;

      final path = Path();
      path.moveTo(stroke[0].dx, stroke[0].dy);

      for (int i = 1; i < stroke.length; i++) {
        path.lineTo(stroke[i].dx, stroke[i].dy);
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) => true;
}