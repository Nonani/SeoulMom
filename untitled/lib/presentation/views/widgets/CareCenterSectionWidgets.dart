
import 'package:flutter/cupertino.dart';

class SectionContent extends StatefulWidget {
  const SectionContent({super.key, required this.top, required this.left, required this.child});

  final double top;
  final double left;
  final Widget child;
  @override
  State<SectionContent> createState() => _SectionContentState();
}
class _SectionContentState extends State<SectionContent>{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.only(left: widget.left, top: widget.top),
      child: widget.child
    );
  }

}
