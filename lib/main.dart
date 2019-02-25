import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
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
      appBar: AppBar(
        title: Text("widget.title"),
      ),
      body: Container(
        // color: Colors.red,
        child: DrawableView(),
      ),
      floatingActionButton: new FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {
          setState(() {
            print(" aa ");
          });
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
