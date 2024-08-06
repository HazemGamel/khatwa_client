import 'package:flutter/material.dart';
import 'package:selivery_client/core/rescourcs/app_colors.dart';

import '../../../core/functions/global_function.dart';
import '../../../core/functions/ratingdriver.dart';

class FareScreen extends StatelessWidget {
  final String id;
  final String fare;
  const FareScreen({super.key, required this.id, required this.fare});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: SizedBox(),),
        Center(
          child: Text("المبلغ المطلوب دفعة= ${fare} جنية",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),),
        ),
        Expanded(child: SizedBox(),),
        MaterialButton(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),

          ),
          onPressed: (){
            navigateTo(RatingScreen(id:id));
          },child: const Text("تقييم السائق",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),),),
      ],
    );
  }
}
