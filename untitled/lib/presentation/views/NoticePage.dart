import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/presentation/viewmodels/NoticeViewModel.dart';
import 'package:untitled/presentation/views/InfoDetailPage.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({super.key, required this.categoryName, required this.icon});

  final String categoryName;
  final Icon icon;

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  late final NoticeViewModel viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel = Provider.of<NoticeViewModel>(context, listen: false);
      viewModel.loadNotices(widget.categoryName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NoticeViewModel>(context);
    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: false,
        centerTitle: false,
        shape: const Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            widget.icon,
            const SizedBox(width: 10),
            Text(widget.categoryName,
                style: const TextStyle(fontWeight: FontWeight.bold)),
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
                      height: 8,
                      color: Colors.grey[200],
                    ),
                    GestureDetector(
                      child: ListTile(
                        title: Text(notice.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(notice.content, maxLines:2, overflow: TextOverflow.visible,),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => InfoDetailPage(category: widget.categoryName, notice: notice)));
                      },
                    )
                  ],
                );
              },
          ),
    );
  }
}
