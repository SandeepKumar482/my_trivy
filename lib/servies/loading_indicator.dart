import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_trivy/Util/app_color.dart';

loadingIndicator(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColor.bg.withOpacity(0.5),
          title: Text(
            'Please Wait !!!',
            style: TextStyle(color: AppColor.pwhtie),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
        );
      });
}
