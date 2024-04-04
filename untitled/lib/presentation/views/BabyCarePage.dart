import 'package:flutter/material.dart';

class BabyCarePage extends StatefulWidget {
  const BabyCarePage(
      {super.key, required this.categoryName, required this.icon});

  final String categoryName;
  final Icon icon;

  @override
  State<BabyCarePage> createState() => _BabyCarePageState();
}

class _BabyCarePageState extends State<BabyCarePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        shape: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.icon,
            const SizedBox(width: 10),
            Text('${widget.categoryName}',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Container(),
    );
  }
}
