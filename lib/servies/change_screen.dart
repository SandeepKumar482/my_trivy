import 'package:flutter/material.dart';

changeScreen(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

changeReplace(BuildContext context, Widget screen) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => screen));
}