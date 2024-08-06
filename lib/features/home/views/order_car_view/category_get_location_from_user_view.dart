import 'package:flutter/material.dart';
import '../../../../controllers/setlocation.dart';
import '../../../../controllers/setlocationgoto.dart';
import '../../../../core/rescourcs/app_colors.dart';
import '../../../../core/widgets/custom_appBar.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../setlocationwithoutdestionation.dart';
import 'toSet_location_view.dart';
import 'package:get/get.dart';
import '../../../../core/functions/global_function.dart';
import '../../../../core/widgets/custom_sized_box.dart';
import '../../../../core/widgets/responsive_text.dart';

class GetLocationFromUserView extends StatefulWidget {
  final String? categoryId;
  const GetLocationFromUserView({super.key, this.categoryId});

  @override
  State<GetLocationFromUserView> createState() =>
      _GetLocationFromUserViewState();
}

class _GetLocationFromUserViewState extends State<GetLocationFromUserView> {
  SetLocationGoToController setLocationGoToController =
      Get.put(SetLocationGoToController());
  SetLocationController setLocationController =
      Get.put(SetLocationController());
  @override
  Widget build(BuildContext context) {
    print(widget.categoryId);
    return Scaffold(
      appBar: customAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10,),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/logo2.jpeg',
              height: screenSize(context).height * .2,
              fit: BoxFit.fill,
            ),
          ),
          const CustomSizedBox(value: .02),
          InkWell(
            onTap: () => navigateTo( ToSetLocation(
              categoryId: widget.categoryId,
            )),
            child: Container(
              width: screenSize(context).width,
              padding: const EdgeInsets.symmetric(vertical: 30),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text( ' لكي تقوم بعمل رحلة مع خطوة يمكنك تحدد مكانك ومكان ذهابك وثم تقوم باختيار سائق وثم عمل الرحلة أضغط هنا لعمل الرحلة',
              style: TextStyle(fontSize: 20,color: Colors.white),),
            ),
          ),
          const CustomSizedBox(value: .02),
          // InkWell(
          //   onTap: () => navigateTo(const ToSetLocationWithoutDestination()),
          //   child: Container(
          //     width: screenSize(context).width,
          //     padding: const EdgeInsets.symmetric(vertical: 30),
          //     margin: const EdgeInsets.symmetric(horizontal: 10),
          //     decoration: BoxDecoration(
          //       color: const Color(0xff0F534D),
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         CustomAssetsImage(path: 'assets/Here.png'),
          //         const SizedBox(width: 4),
          //         const ResponsiveText(
          //           text: 'التواصل مع السائق مباشرة',
          //           scaleFactor: .05,
          //           color: AppColors.white,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

        ],
      ),
    );
  }
}
