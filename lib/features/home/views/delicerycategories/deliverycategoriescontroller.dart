import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/class/statusrequst.dart';
import '../../../../core/functions/handlingdata.dart';
import '../../../../dataforcrud/deliverycategoriesdata.dart';


class DeliveryCategoriesController extends GetxController{
  StatusRequest  statusRequest = StatusRequest.none;

  DeliveryCategoriesData deliveryCategoriesData = DeliveryCategoriesData(Get.find());

  List categories = [];

  getDeliveryCategories()async{
    statusRequest = StatusRequest.loading;
    update();
    var response = await deliveryCategoriesData.getDeliveryCategoryData();
    statusRequest = handlingData(response);
    print(response);
    if(StatusRequest.success == statusRequest){
      categories.addAll(response['categories']);
    }else{
    }
    update();
  }



  @override
  void onInit() {
    // TODO: implement onInit

    getDeliveryCategories();

    super.onInit();
  }
}