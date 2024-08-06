import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:selivery_client/core/class/statusrequst.dart';
import '../../../../controllers/setlocation.dart';
import '../../../../controllers/setlocationgoto.dart';
import '../../../../controllers/setlocationwithdriver.dart';
import '../../../../core/widgets/custom_appBar.dart';

class MapScreen extends StatefulWidget {
  final String? categoryId;
  const MapScreen({super.key, this.categoryId});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final String id="";
  @override
  Widget build(BuildContext context) {
    print("category map screen ${widget.categoryId}");
    SetLocationWithDriverController controllerDriver =
    Get.put(SetLocationWithDriverController())..getdrivers(widget.categoryId);
    SetLocationController setLocationController =
    Get.put(SetLocationController());
    print("kkkkk${setLocationController.lat}");
    SetLocationGoToController setLocationGoToController =
    Get.put(SetLocationGoToController());

    return Scaffold(
      appBar: customAppBar(context),
      body: GetBuilder<SetLocationWithDriverController>(builder:
          (controller){
            return Container(
              child: Column(
                children: [
                  if(controllerDriver.kGooglePlex!=null)
                    Expanded(child:
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        GoogleMap(
                          markers: controllerDriver.newMarker.toSet(),
                          onTap: (latlong){
                            // controllerDriver.addMarkers(latlong);
                          },
                          mapType: MapType.normal,
                          initialCameraPosition: controllerDriver.kGooglePlex!,
                          onMapCreated: (GoogleMapController mapcontroller) {
                            controllerDriver.completercontroller!.complete(mapcontroller);
                          },
                        ),
                        (setLocationController.lat != null &&
                            setLocationController.long !=null
                            && setLocationGoToController.lat2 !=null
                            && setLocationGoToController.long2 != null) ?
                        Positioned(
                          child: Container(),
                        )
                            : Container(
                          child: const Center(child:
                          Text("Please choose your location",style: TextStyle(
                              color: Colors.black,fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),)),
                        ),
                      ],
                    ) ),
                  Container(
                    height: 40,
                    width: 100,
                    color: Colors.orange,
                    child: MaterialButton(
                      onPressed: (){
                        if(controller.id.isNotEmpty) {
                          controller.requestTripDriver(controller.id);
                        }else{
                          Get.defaultDialog(
                              title: 'تنيه',
                              middleText: 'من فضلك قم باختيار سائق');
                        }
                      },
                      child: Text("يلا خطوة",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                    ),),
                ],
              ),
            );
          }),
    );
  }
}
