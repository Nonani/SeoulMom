import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/presentation/viewmodels/CareerNoticeViewModel.dart';
import 'package:untitled/presentation/viewmodels/NoticeViewModel.dart';
import 'package:url_launcher/url_launcher.dart';

class CareerNoticePage extends StatefulWidget {
  const CareerNoticePage({super.key, required this.categoryName, required this.icon});

  final String categoryName;
  final Icon icon;

  @override
  State<CareerNoticePage> createState() => _CareerNoticePageState();
}

class _CareerNoticePageState extends State<CareerNoticePage> {
  late final CareerNoticeViewModel viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel = Provider.of<CareerNoticeViewModel>(context, listen: false);
      viewModel.loadNotices();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CareerNoticeViewModel>(context);
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
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container()
    );
  }
}
