import 'package:flutter/material.dart';
import 'package:flutter_web_bluetooth/flutter_web_bluetooth.dart';
import 'package:number_trivia/view/bluetoothDevice.dart';
import 'package:web_blue/web_blue.dart';

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


  Future<void> discoverNearbyDevices() async {
    // try {
    //   final devices = await BluetoothDevice.checkUse();
    //   setState(() {
    //     nearbyDevices = devices;
    //   });
    // } catch (e) {
    //   print('Error discovering devices: $e');
    // }
  }

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
                bool canUse = canUseBlue();
                print('canUse $canUse');
              },
              child: Text('check Use'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async{
                final supported = FlutterWebBluetooth.instance.isBluetoothApiSupported;
                print('supported -  $supported');
              },
              child: Text('getAvailability'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
