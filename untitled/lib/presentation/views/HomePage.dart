import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _panelController = PanelController();
  List<String?> selectedItems = [];
  List<MultiSelectItem<String>> _items = [
    MultiSelectItem<String>('1', '육아'),
    MultiSelectItem<String>('2', '출산'),
    MultiSelectItem<String>('3', '출산'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: ElevatedButton(
          onPressed: () {
            _showMultiSelect(context);
          },
          child: Text("Scroll to top"),
        )),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  print(selectedItems);
                },
                child: Text("Print value")),
          ],
        ));
  }

  void _showMultiSelect(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: false, // required for min/max child size
      context: context,
      builder: (ctx) {
        return Wrap(children: [
          MultiSelectChipField(
            items: _items,
            initialValue: selectedItems,

            onTap: (values) {
              selectedItems = values;
            },
            chipWidth: 50,
            textStyle: TextStyle(fontSize: 16),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Print value"))
        ]);
      },
    );
    setState(() {
    });
  }
}
