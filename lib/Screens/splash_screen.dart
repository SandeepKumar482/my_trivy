
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Util/app_color.dart';



class SplashScrn extends StatelessWidget {
  const SplashScrn({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: AppColor.bg),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/Logo.png'),
              const SizedBox(
                height: 5,
              ),
              Text(
                'My Trivy',
                style: TextStyle(
                  color: AppColor.offWhite,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Seek Kar, Pick Kar, Earn Kar!',
                style: TextStyle(
                  color: AppColor.offWhite,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SpinKitFadingCube(
                duration: const Duration(milliseconds: 500),
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color:
                          index.isEven ? AppColor.primary : AppColor.offWhite,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
