import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:untitled/presentation/viewmodels/CareCenterViewModel.dart';
import 'package:untitled/presentation/views/styles/CareCenterSectionStyles.dart';
import 'package:untitled/presentation/views/widgets/CareCenterSectionWidgets.dart';

import '../../domain/entities/CareCenter.dart';

class CareCenterPage extends StatefulWidget {
  const CareCenterPage(
      {super.key, required this.categoryName, required this.icon});

  final String categoryName;
  final Icon icon;

  @override
  State<CareCenterPage> createState() => _CareCenterPageState();
}

class _CareCenterPageState extends State<CareCenterPage> {
  late final CareCenterViewModel viewModel;
  late KakaoMapController mapController;

  String currentMarker = "";
  List<Marker> markerData = [];
  Map<String, CareCenter> markerDetail = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel = Provider.of<CareCenterViewModel>(context, listen: false);
      viewModel.loadCareCenterList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CareCenterViewModel>(context);

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
            : Stack(children: [
                PopScope(
                  canPop: false,
                  onPopInvoked: (didPop) async {
                    if (!didPop) {
                      if (await mapController.webViewController.canGoBack()) {
                        mapController.webViewController.goBack();
                      } else {
                        if (context.mounted) Navigator.pop(context);
                        return;
                      }
                    }
                  },
                  child: KakaoMap(
                    onMapCreated: (controller) {
                      mapController = controller;
                      for (CareCenter careCenter in viewModel.careCenterList) {
                        markerData.add(
                          Marker(
                              width: 30,
                              height: 60,
                              markerId: careCenter.name,
                              latLng: careCenter.care_center_detail.location,
                              infoWindowRemovable: false,
                              infoWindowFirstShow: true),
                        );
                        markerDetail[careCenter.name] = careCenter;
                      }
                      mapController.setLevel(8);
                      setState(() {});
                    },
                    markers: markerData,
                    onMarkerTap: (markerId, latLng, zoomLevel) {
                      setState(() {
                        currentMarker = markerId;
                      });
                    },
                    center: LatLng(37.566720, 126.978229),
                  ),
                ),
                getSlidingUpPanel()
              ]));
  }

  Widget getSlidingUpPanel() {
    return SlidingUpPanel(
      minHeight: 110,
      panel: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0), // 왼쪽 위 모서리 둥글게
              topRight: Radius.circular(24.0), // 오른쪽 위 모서리 둥글게
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionContent(
                  top: 25,
                  left: 0,
                  child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 25),
                      alignment: Alignment.center,
                      child: Text(markerDetail[currentMarker]?.name ?? "",
                        style: titleStyle,
                        textAlign: TextAlign.center
                      )
                  )
              ),
              const SectionSubtitle(
                    icon: Icons.paid_outlined,
                    title: "돌봄비"
              ),
              SectionContent(
                top: 10,
                left: 82,
                child: Text("${markerDetail[currentMarker]?.care_center_detail.price ?? ""} ₩", style: contentStyle),
              ),
              const SectionSubtitle(
                icon: Icons.access_time_outlined,
                title: "운영 시간"
              ),
              SectionContent(
                  top: 10,
                  left: 82,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                      "평일: ${markerDetail[currentMarker]?.care_center_detail.open ?? ""} - ${markerDetail[currentMarker]?.care_center_detail.close ?? ""}",
                      style: contentStyle,
                    ),
                    Text(
                      "토요일: ${markerDetail[currentMarker]?.care_center_detail.open_sat ?? ""} - ${markerDetail[currentMarker]?.care_center_detail.close_sat ?? ""}",
                      style: contentStyle,
                    )
                  ])
              ),
              const SectionSubtitle(
                      icon: Icons.language,
                      title:  "홈페이지"
              ),
              SectionContent(
                  top: 10,
                  left: 82,
                  child: GestureDetector(
                    child: Text(markerDetail[currentMarker]?.care_center_detail.detail_url ?? "", style: contentStyle),
                    onTap: (){
                      mapController.webViewController.loadRequest(
                          Uri.parse(markerDetail[currentMarker]?.care_center_detail.detail_url ?? "")
                      );
                    },
                  )
              )
            ],
          )
      ),
    );
  }
}
