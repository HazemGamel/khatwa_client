import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:selivery_client/controllers/mainviewcontroller.dart';
import 'package:selivery_client/core/class/statusrequst.dart';
import 'package:selivery_client/core/functions/global_function.dart';
import 'package:selivery_client/core/widgets/custom_loading_widget.dart';
import 'package:selivery_client/features/home/views/delicerycategories/deliverycategoriesview.dart';
import 'package:selivery_client/features/home/views/main_view.dart';
import '../../../core/contants/api.dart';
import 'advises.dart';
import 'order_car_view/category_get_location_from_user_view.dart';
import 'rental_sale_car_view/order_car_view.dart';
import '../../../core/rescourcs/app_colors.dart';
import '../../../core/widgets/custom_appBar.dart';
import '../widgets/category_items.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<String> imageUrls = [
    'assets/banner1.png',
    'assets/banner2.jpg',
    'assets/banner3.jpg',
    'assets/banner4.jpg',
    'assets/logo2.jpeg',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MainViewController controller = Get.put(MainViewController());

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final childAspectRatio = (screenWidth / 1.2) / (screenHeight / 3);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: customAppBarForSearch(context),
      body: GetBuilder<MainViewController>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loading) {
            return CustomLoadingWidget();
          }
          return Column(
            children: [
              SizedBox(height: 5),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (controller.banners.isNotEmpty)
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 220.0,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                            viewportFraction: 1,
                          ),
                          items: controller.banners.map((imageUrl) {
                            return Builder(
                              builder: (BuildContext context) {
                                return controller.statusRequest == StatusRequest.loading
                                    ? CustomLoadingWidget()
                                    : Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                  ),
                                  child: Image.network(
                                    "${baseUri}images/${imageUrl['image']}",
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        )
                      else
                        Container(),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 25,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      GridView.builder(
                        shrinkWrap: true, // Add this line
                        physics: NeverScrollableScrollPhysics(), // Add this line
                        itemCount: controller.categories.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: childAspectRatio,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              //send category id
                              print(controller.categories[index]['_id']);
                              navigateTo(GetLocationFromUserView(
                                categoryId:controller.categories[index]['_id'] ,
                              ));
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 70,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      "${baseUri}images/${controller.categories[index]['image']}",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${controller.categories[index]['name']}",
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Delivery",
                          style: TextStyle(
                            fontSize: 25,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      InkWell(
                        onTap: (){
                          //nav to delivery categories
                          navigateTo(DeliveryCategories(
                            lat: controller.position!.latitude,
                            long: controller.position!.longitude,
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 70,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    "assets/deliveryboy.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Text(
                                "Delivery",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),

                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget CategoryItem() {
  return Column(
    children: [
      Container(
        height: 70,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset("assets/banner1.png", fit: BoxFit.fill),
        ),
      ),
      Text(
        "Orange Motocycle",
        style: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    ],
  );
}
