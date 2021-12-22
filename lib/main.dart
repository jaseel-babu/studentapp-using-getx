import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxstudent/homepage.dart';
import 'package:getxstudent/model/datamodel.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

String boxname = "studentdetails";
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DatamodelAdapter());
  await Hive.openBox(boxname);

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home:const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
