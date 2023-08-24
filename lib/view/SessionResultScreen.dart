import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_trivia/controller/bluetooth_controller.dart';
import 'package:number_trivia/view/listView.dart';

class SessionResultScreen extends StatefulWidget {
  const SessionResultScreen({super.key});

  @override
  State<SessionResultScreen> createState() => _SessionResultScreenState();
}

class _SessionResultScreenState extends State<SessionResultScreen> {
  final BluetoothController btController = Get.put(BluetoothController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Session Screen'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Leakage'),
              Tab(text: 'Obstruction'),
              Tab(text: 'No Error'),
              Tab(text: 'HighRate'),
              Tab(text: 'HarshBreath'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListViewScreen(list : btController.leakageList),
            ListViewScreen(list : btController.optList),
            ListViewScreen(list : btController.noErrorList),
            ListViewScreen(list : btController.highRateList),
            ListViewScreen(list : btController.harshList),
          ],
        ),
      ),
    );
  }
}
