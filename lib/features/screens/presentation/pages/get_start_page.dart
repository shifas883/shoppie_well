
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppie_well/core/utils/common_button.dart';

import 'navigation_screen.dart';


class GetStartPage extends StatelessWidget {
  const GetStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('asset/startt.png',fit: BoxFit.fill,),
          Positioned(
            bottom: 20,
            child: Align(
              child: Column(
                children: [
                  Text('You want\nAuthentic, here\nyou go!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 34.sp),),
                  Text('Find it here, buy it now!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp),),
                  SizedBox(height: 50.h),
                  Container(
                    width: 385.w,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ConfirmButton(text: "Get Started", onTap: (){
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => DashboardScreen()),
                      );
                    }),
                  )

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
