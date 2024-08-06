
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:selivery_client/core/rescourcs/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'chats.dart';

import '../../../controllers/tracking.dart';
import '../../../core/functions/global_function.dart';

class Tracking extends StatefulWidget {
  final String id;
  final String devicetoken;
  final String drivername;
  final String driverphone;
  final double pick1;
  final double pick2;
  final double des1;
  final double des2;
  const Tracking({super.key, required this.id, required this.devicetoken, required this.drivername, required this.driverphone, required this.pick1, required this.pick2, required this.des1, required this.des2,});

  @override
  State<Tracking> createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {


  @override
  Widget build(BuildContext context) {
    print("id ${widget.id}");
    TrackingController trackingController=
    Get.put(TrackingController()..initalSocket(widget.id,
        widget.pick1,widget.pick2));
    return Scaffold(
      appBar: AppBar(
        title: Text("تتبع مسار السائق",style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold),),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      body: GetBuilder<TrackingController>(builder:
          (controller)=>
          Container(
            child: Column(
              children: [
                if(trackingController.kGooglePlex!=null)
                  Expanded(
                    flex: 4,
                      child:
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      GetBuilder<TrackingController>(builder:
                          (controller)=>
                          GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(widget.pick1,
                                  widget.pick2),
                              zoom: 15,
                            ),
                            myLocationEnabled: true,
                            tiltGesturesEnabled: true,
                            compassEnabled: true,
                            scrollGesturesEnabled: true,
                            zoomGesturesEnabled: true,
                            mapType: MapType.normal,
                            onMapCreated:controller.onMapCreated,
                            markers: Set<Marker>.of(controller.markers.values),
                            polylines: Set<Polyline>.of(controller.polylines.values),
                          ),),

                    ],
                  ) ),
                Expanded(
                    flex:2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                       // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text("اسم السائق :",style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                              ),),
                              Text("${widget.drivername}",style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                              ),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text("رقم السائق :",style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                  ),),
                                  Text("${widget.driverphone}",
                                    style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                  ),),
                                ],
                              ),
                              IconButton(onPressed: ()async{
                                await  launchUrl(Uri.parse("tel:+2${widget.driverphone}"));

                              },
                                  icon: Icon(Icons.call,
                                    color: Colors.green,size: 30,))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("دردشة مع السائق",style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                              )),
                              IconButton(onPressed: (){
                                navigateTo(ChatScreen(
                                    devicetoken: widget.devicetoken,
                                    driverid:widget.id));
                              },
                                  icon: Icon(Icons.chat_bubble,
                                    color: Colors.amberAccent,size: 30,)),
                            ],
                          ),

                        ],
                      ),
                    )),
              ],
            ),
          ),),
    );
  }
}
