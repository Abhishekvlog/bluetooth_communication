import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_web_bluetooth/flutter_web_bluetooth.dart';
import 'package:flutter_web_bluetooth/js_web_bluetooth.dart';
import 'package:get/get.dart';
import 'package:number_trivia/view/SessionResultScreen.dart';

class BluetoothController extends GetxController {
  final RxBool supported = false.obs;
  final RxBool connected = false.obs;
  final RxBool showData = false.obs;
  final RxBool isLoading = false.obs;
  BluetoothDevice? connectedDevice;
  BluetoothCharacteristic? desiredCharacteristic;
  late StreamSubscription<ByteData> notificationSubscription;
  final RxString readableData = "".obs;
  RxList<List<String>> dataList = RxList<List<String>>();
  RxList<bool> leakageList = RxList<bool>();
  RxList<bool> highRateList = RxList<bool>();
  RxList<bool> optList = RxList<bool>();
  RxList<bool> noErrorList = RxList<bool>();
  RxList<bool> harshList = RxList<bool>();



  void checkWebSupport() {
    supported.value = FlutterWebBluetooth.instance.isBluetoothApiSupported;
  }

  Future<void> scanDevices() async {
    final requestOptions =
        RequestOptionsBuilder.acceptAllDevices(optionalServices: [
      BluetoothDefaultServiceUUIDS.deviceInformation.uuid,
      "fc6e1400-0c4e-4043-9d95-d257cd9ad5ff" // service uuid
    ]);
    try {
      connectedDevice =
          await FlutterWebBluetooth.instance.requestDevice(requestOptions);
      await connectedDevice?.connect();
      await connectedDevice?.discoverServices().then((services) async {
        for (BluetoothService service in services) {
          List<BluetoothCharacteristic> characteristics =
              await service.getCharacteristics();
          for (BluetoothCharacteristic characteristic in characteristics) {
            if (characteristic.uuid.toLowerCase() ==
                'fc6e1404-0c4e-4043-9d95-d257cd9ad5ff') {
              desiredCharacteristic = characteristic;
              break;
            }
          }
          if (desiredCharacteristic != null) {
            break;
          }
        }
      });
    } on UserCancelledDialogError {
      // The user cancelled the dialog
    } on DeviceNotFoundError {
      // There is no device in range for the options defined above
    }
    connected.value = true;
  }

  void disconnect() {
    connectedDevice?.disconnect();
    connected.value = false;
    readableData.value= "";
    leakageList.clear();
    optList.clear();
    highRateList.clear();
    noErrorList.clear();
  }

  void getList() async {
    Get.off(SessionResultScreen());
    filterData();
  }

  Future<void> startNotification() async {
    if (desiredCharacteristic != null) {
      if (desiredCharacteristic!.properties.notify) {
        await desiredCharacteristic!.startNotifications();
        isLoading.value =true;
        final element =
            desiredCharacteristic!.readValue(timeout: Duration(seconds: 5));
        print('element value - ${element.toString()}');
        notificationSubscription = desiredCharacteristic!.value.listen(
          (value) {
            // Process the data received in 'value'
            Uint8List dataBytes = Uint8List.view(value.buffer);
            readableData.value = utf8.decode(dataBytes);
            final String data = readableData.value;
            final List<String> splitData = data.split(", ");
            dataList.add(splitData);
            print('Notification received: $splitData');
          },
          onError: (error) {
            print('Error in notification subscription: $error');
          },
        );
      }
    }
  }
  void filterData() {
    int startIndex = readableData.value.indexOf(',') + 1;
    int endIndex = readableData.value.indexOf(',', startIndex);
    String intValueAsString = readableData.value.substring(startIndex, endIndex).trim();

    // Parsing the string as an integer
    int length = int.parse(intValueAsString);

    for(int j = 0 ; j< length; j++){
      if(dataList[j][1] == '1'){
        for (int i = j; i < length + j-1 ; i++) {
          leakageList.add(false);
          optList.add(false);
          noErrorList.add(false);
          highRateList.add(false);
          harshList.add(false);
          if( dataList[i][2].substring(0,4) == 'Leak' ){
            leakageList.removeLast();
            leakageList.add(true);
          }
          else if( dataList[i][2].substring(0,4) == 'Obst' ){
            optList.removeLast();
            optList.add(true);
          }
          else if( dataList[i][2].substring(0,4) == 'NoEr' ){
            noErrorList.removeLast();
            noErrorList.add(true);
          }
          else if( dataList[i][2].substring(0,4) == 'High'){
            highRateList.removeLast();
            highRateList.add(true);
          }
          else if( dataList[i][2].substring(0,4) == 'Hars'){
            harshList.removeLast();
            harshList.add(true);
          }
        }
        break;

      }
    }
    print("leakage list - $leakageList");
    print("high rate list - $highRateList");
    print("opt list - $optList");
    print("no error list - $noErrorList");
    print("harsh  - $harshList");

  }

  void stopNotification() async {
    if (desiredCharacteristic != null) {
      await desiredCharacteristic?.stopNotifications();
      print('is notifying - ${desiredCharacteristic!.isNotifying}');
      // Cancel the subscription to stop receiving notifications
      notificationSubscription.cancel();
      showData.value = true;
      isLoading.value = false;
      // Get.off(HomeScreen());
      // dataUpdating.value = false;
      print("Notification is off");
    }
  }
}
