import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HealthNoticeDetailPage extends StatefulWidget {
  const HealthNoticeDetailPage({super.key, required this.sequence});
  final String sequence;
  @override
  State<StatefulWidget> createState() => _HealthNoticeDetailPageState();
}
class _HealthNoticeDetailPageState extends State<HealthNoticeDetailPage>{
  late InAppWebViewController webViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
          onWebViewCreated: (controller){
            webViewController = controller;
            webViewController.postUrl(
                url: WebUri("https://www.childcare.go.kr/?menuno=329"),
                postData: Uint8List.fromList(utf8.encode("pageType=VIEW&seq=${widget.sequence}")));
            setState(() {});
          },
        ),
    );
  }

}