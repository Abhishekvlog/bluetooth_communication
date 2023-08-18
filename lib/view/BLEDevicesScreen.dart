import 'package:flutter/material.dart';
import 'package:flutter_web_bluetooth/flutter_web_bluetooth.dart';

class NearBluetoothDevices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth Devices',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List<BluetoothDevice> nearbyDevices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Bluetooth Devices'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: (){
                final supported = FlutterWebBluetooth.instance.isBluetoothApiSupported;
                print('support - $supported');
              },
              child: const Text('Support'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async{
                final available = FlutterWebBluetooth.instance.isAvailable;
                print('available -  $available');
              },
              child: const Text('availability'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
