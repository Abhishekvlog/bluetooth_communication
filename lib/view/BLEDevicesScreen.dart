import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/bluetooth_controller.dart';

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
  final BluetoothController btController = Get.put(BluetoothController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Bluetooth Devices'),
      ),
      body: SizedBox(
        // Wrap with Container to provide explicit constraints
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Obx(() {
                  btController.checkWebSupport();
                  final bool support = btController.supported.value;
                  final bool connected = btController.connected.value;
                  final bool showDataScreen = btController.showData.value;
                  if (support) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            btController.scanDevices();
                          },
                          child: const Text("scan device"),
                        ),
                        if (connected)
                          Center(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      height: 100,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            btController.startNotification();
                                          },
                                          child: const Text("start session")),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            btController.stopNotification();
                                          },
                                          child: const Text("end session")),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            btController.disconnect();
                                          },
                                          child: const Text("disconnect")),
                                    ),
                                  ],
                                ),
                                if (showDataScreen)
                                  Center(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                              onPressed: () {btController.getList();},
                                              child: const Text("get Data")),
                                        ),],
                                    ),
                                  ),
                                if(btController.isLoading.value)
                                  Center(
                                    child: LinearProgressIndicator(),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ));
                  } else {
                    return const Center(child: Text("Browser is not supported"));
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
