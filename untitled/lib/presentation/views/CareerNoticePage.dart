import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:untitled/presentation/viewmodels/CareerNoticeViewModel.dart';
import 'package:untitled/presentation/viewmodels/NoticeViewModel.dart';
import 'package:url_launcher/url_launcher.dart';

class CareerNoticePage extends StatefulWidget {
  const CareerNoticePage(
      {super.key, required this.categoryName, required this.icon});

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
            : ListView.builder(
                itemCount: viewModel.notices.length,
                itemBuilder: (context, index) {
                  final notice = viewModel.notices[index];
                  return Column(
                    children: [
                      Container(
                        height: 10,
                        color: Colors.grey[200],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex:10,
                                  child: Text(
                                    notice.title,
                                    style: const TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                (notice.applyClose
                                    ?.difference(DateTime.now())
                                    .inDays ??
                                    0) ==
                                    0
                                    ? const Text('D-Day',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12))
                                    : Text(
                                  'D-${notice.applyClose?.difference(DateTime.now()).inDays.toString()}',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              notice.center ?? '',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '마감일: ${notice.applyClose?.toString().substring(0, 10) ?? ''}',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                            const SizedBox(height: 10),
                            const Divider(
                                height: 1, thickness: 1, color: Colors.grey),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("가격: ${notice.price}원"),

                                Text("모집인원: ${notice.capacity}명"),

                                TextButton(
                                  onPressed: () {
                                    launch(notice.detailUrl!);
                                  },
                                  child: const Text('상세보기'),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }));
  }
}
