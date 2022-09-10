import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late UnityWidgetController _unityWidgetController;
  bool estadoMovimiento = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Center(
                child: UnityWidget(
                  onUnityCreated: onUnityCreated,
                  onUnityMessage: onUnityMessage,
                  onUnitySceneLoaded: onUnitySceneLoaded,
                  fullscreen: false,
                ),
              ),
            ),
            MaterialButton(child: Icon(Icons.play_arrow),
                onPressed: () {
                  cambiarEstadoMovimiento(!estadoMovimiento);
                  estadoMovimiento = !estadoMovimiento;
                }),
            Text("Rotación en el eje X"),
            Row(children: [
              MaterialButton(child: Icon(Icons.remove_circle),
                  onPressed: () {
                    mermarVelocidad("X");
                  }),
              MaterialButton(child: Icon(Icons.add_circle),
                  onPressed: () {
                    aumentarVelocidad("X");
                  }),
            ],),
            Text("Rotación en el eje Y"),
            Row(children: [
              MaterialButton(child: Icon(Icons.remove_circle),
                  onPressed: () {
                    mermarVelocidad("Y");
                  }),
              MaterialButton(child: Icon(Icons.add_circle),
                  onPressed: () {
                    aumentarVelocidad("Y");
                  }),
            ],),
            Text("Rotación en el eje Z"),
            Row(children: [
              MaterialButton(child: Icon(Icons.remove_circle),
                  onPressed: () {
                    mermarVelocidad("Z");
                  }),
              MaterialButton(child: Icon(Icons.add_circle),
                  onPressed: () {
                    aumentarVelocidad("Z");
                  }),
            ],)
          ],
        ));
  }

  // Communication from Unity to Flutter
  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    this._unityWidgetController = controller;
  }

  // Communication from Unity when new scene is loaded to Flutter
  void onUnitySceneLoaded(SceneLoaded? sceneInfo) {
    print('Received scene loaded from unity: ${sceneInfo?.name}');
    print(
        'Received scene loaded from unity buildIndex: ${sceneInfo?.buildIndex}');
  }

  void cambiarEstadoMovimiento(bool nuevoEstadoMovimiento) {
    _unityWidgetController.postMessage(
      'Cube',
      'CambiarEstadoMovimiento',
      nuevoEstadoMovimiento.toString(),
    );
  }

  void mermarVelocidad(String eje) {
    _unityWidgetController.postMessage(
      'Cube',
      'MermarVelocidad$eje',
      '10',
    );
  }

  void aumentarVelocidad(String eje) {
    _unityWidgetController.postMessage(
      'Cube',
      'AumentarVelocidad$eje',
      '10',
    );
  }
}
