import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'setlocation.dart';
import 'setlocationgoto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/class/statusrequst.dart';
import '../core/functions/global_function.dart';
import '../core/functions/handlingdata.dart';
import 'package:http/http.dart' as http;

import '../dataforcrud/nearestdrivers.dart';
import '../dataforcrud/requesttrip.dart';
import '../features/home/views/driverprofile.dart';

class SetLocationWithDriverController extends GetxController {
  late SharedPreferences sharedPreferences;

  RequestTripData requestTripData = RequestTripData(Get.find());

  NearestDriversData nearestDriversData = NearestDriversData(Get.find());
  SetLocationGoToController setLocationGoToController = Get.find();
  StatusRequest statusRequest = StatusRequest.loading;
  SetLocationController setLocationController = Get.find();
  double? lat;
  double? long;

  Position? position;
  Completer<GoogleMapController>? completercontroller;
  CameraPosition? kGooglePlex;

 Set<Marker> newMarker = {};
 String id ="";
  addMarkers(LatLng latLng, Uint8List markerIcon) {
    newMarker.clear();
    newMarker.add(
      Marker(
        markerId: const MarkerId("1"),
        position: latLng,
        icon: BitmapDescriptor.fromBytes(markerIcon),
        onTap: () {
          id=driverid!;
          navigateTo(DriverProfile(
            name: drivername!,
            phone: phone!,
          ));
        },
      ),
    );
  }

  Map<String, dynamic>? locations;
  Map<String, dynamic>? locations2;
  List drivers=[];
  String? drivername;
  String? phone;
  String? driverid;
  String?  driverimage;
  String? driverimagecar; // Change the type to Uint8List?
  String? drivercarmodel;
  String? cartype;
  Uint8List? driverImageBytes;
  getdrivers(categoryid) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await nearestDriversData.postData(
        setLocationController.lat,
        setLocationController.long,
        categoryid
    );
    print(response);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      print(response['drivers']);
      drivers = response['drivers'] ?? [];
      response['drivers'].map((e){
        newMarker.add(Marker(
          markerId:  MarkerId("1"),
          position: LatLng(response['drivers'][0]['location']['latitude'],
              response['drivers'][0]['location']['longitude']),
          icon: BitmapDescriptor.fromBytes(driverImageBytes!),
          onTap: () {
            navigateTo(DriverProfile(
              name: drivername!,
              phone: phone!,
            ));
          },
        ));
      });
      if (drivers.isEmpty) {
        return Get.defaultDialog(
            title: 'تنيه', middleText: 'لا يوجد سائق متاحين الان');
      }

      drivername = response['drivers'][0]['driver']['name'];
      phone = response['drivers'][0]['driver']['phone'];
      driverid = response['drivers'][0]['driver']['_id'];
      driverimage = response['drivers'][0]['driver']['image'];
      driverimagecar = response['drivers'][0]['driver']['vehicle']['images'][0];
      cartype = response['drivers'][0]['driver']['vehicle']['model'];

      // Load image from assets
      driverImageBytes = await loadImageFromAssets('assets/redcircle.png');
      if (driverImageBytes != null) {
        addMarkers(
          LatLng(response['drivers'][0]['location']['latitude'],
              response['drivers'][0]['location']['longitude']),
          driverImageBytes!,
        );
      }

    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
  }


  getCurrentLocation() async {
    position = await Geolocator.getCurrentPosition();
    kGooglePlex = CameraPosition(
      target: LatLng(setLocationController.lat!, setLocationController.long!),
      zoom: 14.4746,
    );
    statusRequest = StatusRequest.none;
    update();
  }

  requestTripDriver(id) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await requestTripData.postData(
        id,
        setLocationController.lat,
        setLocationController.long,
        setLocationGoToController.lat2,
        setLocationGoToController.long2);
    statusRequest = handlingData(response);
    if (setLocationController.lat == null ||
        setLocationController.long == null ||
        setLocationGoToController.lat2 == null ||
        setLocationGoToController.long2 == null) {
      return Get.defaultDialog(
          title: 'تنيه',
          middleText: 'من فضلك حدد مكان الذهاب ومكان الاقلاع');
    }

    if (StatusRequest.success == statusRequest) {


      if (drivers.isEmpty) {
        return Get.defaultDialog(
            title: 'تنيه', middleText: "لا يمكنك طلب رحله . لا يوجد سائقين");
      }
      return Get.defaultDialog(
          title: 'تنيه', middleText: "تم الطلب بنجاح");

    } else {

      statusRequest = StatusRequest.failure;
    }
    update();
  }

  @override
  void onInit() async {
     getCurrentLocation();
    // getdrivers();
    completercontroller = Completer<GoogleMapController>();
    sharedPreferences = await SharedPreferences.getInstance();
    if (setLocationController.lat == null ||
        setLocationController.long == null ||
        setLocationGoToController.lat2 == null ||
        setLocationGoToController.long2 == null) {
      return Get.defaultDialog(
          title: 'تنيه', middleText: 'من فضلك حدد مكان الذهاب ومكان الاقلاع');
    }
    super.onInit();
  }


  Future<Uint8List?> loadImageFromAssets(String assetPath) async {
    try {
      ByteData data = await rootBundle.load(assetPath);
      List<int> compressedImage = await FlutterImageCompress.compressWithList(
        data.buffer.asUint8List(),
        minHeight: 70,
        minWidth: 70,
      );
      return Uint8List.fromList(compressedImage);
    } catch (error) {
      print('Error loading image from assets: $error');
      return null;
    }
  }
}
