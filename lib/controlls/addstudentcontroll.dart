import 'package:get/get.dart';
import 'package:getxstudent/controlls/imagepicking.dart';
import 'package:getxstudent/main.dart';
import 'package:getxstudent/model/datamodel.dart';
import 'package:hive/hive.dart';

class Addstudent extends GetxController {
  Box studentDetails = Hive.box(boxname);
  void addstudent(String name, String age, String place, String imagepath) {
    Datamodel data =
        Datamodel(name: name, age: age, place: place, imagepath: img64);
    studentDetails.add(data);
    update();
  }

  void delete(Datamodel data) {
    data.delete();
    update();
  }

  int count = 0;
  void countfun() {
    count++;
  }

  void search() {
    update();
  }
}
