
import 'package:flutter/cupertino.dart';
import '../styles/CareCenterSectionStyles.dart';

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
class SectionSubtitle extends StatefulWidget {
  const SectionSubtitle({super.key, required this.icon, required this.title});
  final String title;
  final IconData icon;
  @override
  State<SectionSubtitle> createState() => _SectionSubtitleState();
}
class _SectionSubtitleState extends State<SectionSubtitle>{
  @override
  Widget build(BuildContext context) {
    return Container(
        padding:  EdgeInsets.only(left: 50, top: 30),
        child: Row(
            children: [
              Icon(widget.icon),
              Text("  ${widget.title}", style: subtitleStyle)
            ])
    );
  }

}
