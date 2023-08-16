import 'package:flutter_web_bluetooth/web/js/js.dart';
import 'package:get/get.dart';
import 'package:js/js_util.dart' as js_util;
import 'package:web_blue/web_blue.dart';

class BluetoothDevice {
  final String id;
  final String name;

  BluetoothDevice(this.id, this.name);

  static checkUse() async {
    bool canUse = canUseBlue();
    print('canUse $canUse');
  }

  //
  //  Future<List<BluetoothDevice>> requestNearbyDevices() async {
  //   final jsPromise = js_util.callMethod(navigator, 'bluetooth.requestDevice', [js_util.newObject()]);
  //   final promise = js_util.promiseToFuture(jsPromise);
  //
  //   final result = await promise;
  //   final List<BluetoothDevice> devices = [];
  //
  //   if (result != null) {
  //     final id = js_util.getProperty(result, 'id') as String;
  //     final name = js_util.getProperty(result, 'name') as String;
  //     devices.add(BluetoothDevice(id, name));
  //   }
  //
  //   return devices;
  // }
}
