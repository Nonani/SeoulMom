import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:provider/provider.dart';
import 'package:untitled/presentation/viewmodels/CareCenterViewModel.dart';

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
  List<Marker> markerData = [];
  List<CustomOverlay> overlayData = [];
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
          : KakaoMap(
              onMapCreated: (_) {
                viewModel.careCenterList.forEach((careCenter) {
                  markerData.add(
                    Marker(
                        width: 30,
                        height: 60,
                        markerId: careCenter.name,
                        latLng: careCenter.care_center_detail.location,
                        infoWindowRemovable: false,
                        infoWindowFirstShow: true),
                  );
                  overlayData.add(
                    CustomOverlay(
                        customOverlayId: careCenter.name,
                        latLng: careCenter.care_center_detail.location,
                        content: '<a style="background-color:white;text-decoration:none;color: inherit;" href=${careCenter.care_center_detail.detail_url}>홈페이지</a>',
                        xAnchor: 0.5,
                        yAnchor: 2.7,
                        zIndex: 5,
                    )
                  );
                  markerDetail[careCenter.name] = careCenter;
                });
                setState(() {});
              },
              markers: markerData,
              customOverlays: overlayData,
              onMarkerTap: (markerId, latLng, zoomLevel) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(markerDetail[markerId]!.name),
                            Text("가격: ${markerDetail[markerId]?.care_center_detail.price}원"),
                            Text("운영 시간"),
                            Text("평일: ${markerDetail[markerId]?.care_center_detail.open} - ${markerDetail[markerId]?.care_center_detail.close}"),
                            Text("토요일: ${markerDetail[markerId]?.care_center_detail.open_sat} - ${markerDetail[markerId]?.care_center_detail.close_sat}"),
                          ],
                        )
                    )
                ));
              },
              center: LatLng(37.560870, 127.014002),
            ),
    );
  }
}
