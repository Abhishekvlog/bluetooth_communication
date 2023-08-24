import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ListViewScreen extends StatefulWidget {
  final RxList<bool> list;
  ListViewScreen({super.key, required this.list});

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          final item = widget.list[index];
          return ListTile(
            title:Text("seconds - ${index+1}"),
            subtitle: Text("outcome - ${item}"),
          );
        }
    );
  }
}
