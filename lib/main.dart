import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarIconBrightness: Brightness.dark));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: DrawableView(),
      ),
      floatingActionButton: new FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {
          setState(() {});
        },
      ),
    );
  }
}

class DrawableView extends StatefulWidget {
  @override
  _DrawableViewState createState() => _DrawableViewState();
}

class _DrawableViewState extends State<DrawableView> {
  List<Offset> _points = <Offset>[];

  @override
  void didUpdateWidget(DrawableView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _points.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          RenderBox renderBox = context.findRenderObject();
          Offset newPoints = renderBox.globalToLocal(details.globalPosition);
          //print(newPoints);
          setState(() {
            _points = List.from(_points)..add(newPoints);
          });
        },
        onPanEnd: (DragEndDetails a) => _points.add(null),
        child: CustomPaint(
          size: Size.infinite,
          painter: CanvasPainter(_points),
        ));
  }
}

class CanvasPainter extends CustomPainter {
  Paint _paint;
  List<Offset> _points;
  CanvasPainter(this._points) {
    _paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 1; i < this._points.length; i++) {
      if (_points[i - 1] != null && _points[i] != null) canvas.drawLine(_points[i - 1], _points[i], _paint);
    }
  }

  @override
  bool shouldRepaint(CanvasPainter oldDelegate) {
    return oldDelegate._points != _points;
  }
}
