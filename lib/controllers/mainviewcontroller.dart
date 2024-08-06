import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../dataforcrud/carwithoutdriver.dart';

import '../core/class/statusrequst.dart';
import '../core/functions/handlingdata.dart';
import '../dataforcrud/manviewdata.dart';

class MainViewController extends GetxController{
  StatusRequest  statusRequest = StatusRequest.none;

  MainViewData mainViewData = MainViewData(Get.find());

  List banners = [];
  List categories = [];

  getBanners()async{
    statusRequest = StatusRequest.loading;
    update();
    var response = await mainViewData.getData();
    statusRequest = handlingData(response);
    print(response);
    if(StatusRequest.success == statusRequest){
      banners.addAll(response['ads']);
    }else{
    }
    update();
  }
  getCategories()async{
    statusRequest = StatusRequest.loading;
    update();
    var response = await mainViewData.getCategoryData();
    statusRequest = handlingData(response);
    print(response);
    if(StatusRequest.success == statusRequest){
      categories.addAll(response['categories']);
    }else{
    }
    update();
  }

  // current lo
  Position? position;
  Completer<GoogleMapController>? completercontroller;
  CameraPosition? kGooglePlex;
  getCurrentLocation() async {
    position = await Geolocator.getCurrentPosition();
    kGooglePlex = CameraPosition(
      target: LatLng(position!.latitude, position!.longitude),
      zoom: 14.4746,
    );
    statusRequest = StatusRequest.none;
    update();
  }

@override
  void onInit() {
    // TODO: implement onInit
  getCurrentLocation();
  getBanners();
  getCategories();
    super.onInit();
  }
}