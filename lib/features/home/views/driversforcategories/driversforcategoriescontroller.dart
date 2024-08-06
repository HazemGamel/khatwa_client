
import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/class/statusrequst.dart';
import '../../../../core/functions/handlingdata.dart';
import '../../../../dataforcrud/deliverycategoriesdata.dart';
import '../../../../dataforcrud/driverscategorydata.dart';


class DriversCategoriesController extends GetxController{
  StatusRequest  statusRequest = StatusRequest.none;

  DriversCategoriesData driversCategoryData = DriversCategoriesData(Get.find());

  List drivers = [];

  getDriversCategories(categoryId,lat,long)async{
    statusRequest = StatusRequest.loading;
    update();
    var response = await driversCategoryData.getDriversCategoryData(categoryId,lat,long);
    statusRequest = handlingData(response);
    print(response);
    if(StatusRequest.success == statusRequest){
      drivers.addAll(response['drivers']);
    }else{
    }
    update();
  }


  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }
}