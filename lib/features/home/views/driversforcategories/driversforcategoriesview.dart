import 'package:flutter/material.dart';
import 'package:selivery_client/core/class/statusrequst.dart';
import 'package:selivery_client/features/home/views/driversforcategories/driversforcategoriescontroller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/contants/api.dart';


class DriversForCategories extends StatelessWidget {
  final String id;
  final double lat;
  final double long;
  const DriversForCategories({super.key, required this.id, required this.lat, required this.long});

  @override
  Widget build(BuildContext context) {
    DriversCategoriesController driversCategoriesController=
    Get.put(DriversCategoriesController()
      ..getDriversCategories(id, lat, long));
    return Scaffold(
      appBar: AppBar(
        title: Text("Drivers"),
        centerTitle: true,
      ),
      body: GetBuilder<DriversCategoriesController>(
        builder: (controller){
          if(controller.statusRequest==StatusRequest.loading){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }else if(controller.drivers.isEmpty){
            return Center(
              child: Text("لا يوجد سائقين متاحين الان ",style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),),
            );
          }
          return SafeArea(
            child: ListView.separated(
                itemBuilder: (context,index){
                  return Card(
                    color: Colors.amberAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("اسم الدليفري :",style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text("${controller.drivers[index]['name']}",style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),),
                            ],
                          ),
                          Row(
                            children: [
                              Text("صورة المركبة :",style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),),
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey[100]
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child:Image.network(
                                    "${baseUri}images/${controller.drivers[index]['vehicle']['images'][0]}",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text("رقم الدليفري :",style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),),
                                  Text("${controller.drivers[index]['phone']} ",style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ],
                              ),
                              IconButton(onPressed: ()async{
                                await  launchUrl(Uri.parse("tel:+2${controller.drivers[index]['phone']}"));

                              },
                                  icon: Icon(Icons.call,color: Colors.green,size: 30,))
                            ],
                          ),

                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context,index){
                  return Container();
                },
                itemCount: controller.drivers.length),
          );
        },
      ),
    );
  }
}


Widget ListItem(){
  return Card(
    color: Colors.amberAccent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
             children: [
               Text("اسم الدليفري :",style: TextStyle(
                 fontSize: 25,
                 color: Colors.black,
                 fontWeight: FontWeight.bold
               ),),
               Text("Hazem Gamel",style: TextStyle(
                 fontSize: 25,
                 color: Colors.white,
                 fontWeight: FontWeight.bold
               ),),
             ],
           ),
           Row(
             children: [
               Text("صورة المركبة :",style: TextStyle(
                 fontSize: 25,
                 color: Colors.black,
                 fontWeight: FontWeight.bold
               ),),
               Container(
                 height: 100,
                 width: 100,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20),
                   color: Colors.grey[100]
                 ),
                 child: ClipRRect(
                   borderRadius: BorderRadius.circular(20),
                   child: Image.asset(
                     "assets/logo.png",
                     fit: BoxFit.fill,
                   ),
                 ),
               ),

             ],
           ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("رقم الدليفري :",style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),),
                  Text("0112345678 ",style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),),
                ],
              ),
              IconButton(onPressed: (){},
                  icon: Icon(Icons.call,color: Colors.green,size: 30,))
            ],
          ),

        ],
      ),
    ),
  );
}