import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _panelController = PanelController();
  List<String> value = [];
  List<S2Choice<String>> frameworks = [
    S2Choice<String>(value: "1", title: 'Ionic'),
    S2Choice<String>(value: "2", title: 'Flutter'),
    S2Choice<String>(value: "3", title: 'React Native'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ElevatedButton(
          onPressed: () {
            _panelController.open();
          },
          child: Text("Scroll to top"),
        )
      ),
      body:Column(
        children: [
          SmartSelect<String>.multiple(
            title: 'Days',
            selectedValue: value,
            onChange: (selected) => setState(() => value = selected.value),
            choiceItems: frameworks,
            choiceType: S2ChoiceType.chips,
            choiceStyle: S2ChoiceStyle(
              outlined: true,
            ),
            choiceActiveStyle: S2ChoiceStyle(
              raised: true,
            ),
            modalType: S2ModalType.bottomSheet,
            tileBuilder: (context, state) {
              return S2Tile.fromState(
                state,
                isTwoLine: true,
                leading: Container(
                  width: 40,
                  alignment: Alignment.center,
                  child: const Icon(Icons.calendar_today),
                ),
              );
            },
          ),
          ElevatedButton(onPressed: (){
            print(value);
          }, child: Text("Print value")),
        ],
      )
    );
  }
}