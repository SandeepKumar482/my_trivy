// import 'package:flutter/material.dart';
// import 'package:my_trivy/AppColors.dart';

import 'package:flutter/material.dart';

const kInputDecoration = InputDecoration(
  filled: true,
  fillColor: Color(0xff46BDA5),
  // labelText: '  Email  ',
  labelStyle:
      TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
  // focusColor: AppColor.offWhite,

  contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Colors.grey, width: 3.5),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Colors.grey, width: 3.5),
  ),
  focusedBorder: OutlineInputBorder(
    gapPadding: 0.0,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Colors.white, width: 3.5),
  ),
);
const kButtonstyle = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(Color(0xff46BDA5)),
    elevation: MaterialStatePropertyAll(10.0),
    shadowColor: MaterialStatePropertyAll(Colors.grey),
    minimumSize: MaterialStatePropertyAll(Size(500, 45.0)));
const kButtonTextStyle = TextStyle(
    color: Color(0xffffffff), fontSize: 16, fontWeight: FontWeight.bold);
