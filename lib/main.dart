import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRCode Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String scanResult = '';
  PermissionStatus _permissionStatus;
//function that launches the scanner
  Future scanQRCode() async {
    _permissionStatus = await Permission.camera.status;
    // if (await Permission.camera.request().isGranted) {
    //   _permissionStatus = await Permission.camera.status;
    // }
    String cameraScanResult = '';
    if (_permissionStatus.isGranted) {
        cameraScanResult = await scanner.scan();
    } else {
      cameraScanResult = _permissionStatus.toString();
    }
    setState(() {
      scanResult = cameraScanResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            scanResult == '' ? Text('Result will be displayed here') : Text(scanResult),
            SizedBox(height: 20),
            RaisedButton(
              color: Colors.blue,
              child: Text('Click To Scan', style: TextStyle(color: Colors.white),),
              onPressed: scanQRCode,
            )
          ],
        ),
      ),
    );
  }
}

