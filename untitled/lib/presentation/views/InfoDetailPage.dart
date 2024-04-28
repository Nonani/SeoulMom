import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/Notice.dart';

class InfoDetailPage extends StatelessWidget{
  const InfoDetailPage({super.key, required this.category, required, required this.notice});

  final String category;
  final Notice notice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Container(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 6),
            child: Text("$category 상세")
        )
      ),
      body : Container(
        child : Column (
          crossAxisAlignment: CrossAxisAlignment.center,
            children : [
              Container(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: Text(notice.title,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      )
                  )
              ),
              const Divider(indent: 20, endIndent: 20),
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text(notice.content,
                    style: const TextStyle(
                        fontSize: 13
                    )
                )
              ),
              const Divider(indent: 20, endIndent: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: notice.detail_url == '.'? const SizedBox.shrink()
                    : GestureDetector(
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("링크: "),
                            Icon(Icons.link),
                          ],
                        ),
                        onTap: () async {
                          final url = Uri.parse(notice.detail_url);
                          if (await canLaunchUrl(url)) {
                            launchUrl(url, mode: LaunchMode.externalApplication);
                          }
                        },
                    )
              )
            ])
      )
    );
  }
  
}