import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxstudent/controlls/addstudentcontroll.dart';
import 'package:getxstudent/controlls/imagepicking.dart';
import 'package:getxstudent/model/datamodel.dart';
import 'package:hive/hive.dart';
import '../main.dart';

class Studentdetail extends StatelessWidget {
  Datamodel data;
  dynamic index;
  Studentdetail({Key? key, required this.data, required this.index})
      : super(key: key);
  Box studentDetails = Hive.box(boxname);
  Addstudent controller = Get.put(Addstudent());
  bool validate = false;
  Addstudent add = Addstudent();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController placecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
        actions: [
          IconButton(
            onPressed: () {
              Datamodel edit = studentDetails.get(index);

              Get.defaultDialog(
                radius: 30,
                confirm: GetBuilder<Addstudent>(
                  builder: (controller) {
                    return TextButton(
                      onPressed: () {
                        String name = namecontroller.text;
                        String age = agecontroller.text;
                        String place = placecontroller.text;
                        String image;
                        img64 != "" ? image = img64 : image = "";
                        // controller.edit(name, age, place, image, index);
                        edit.save();
                        controller.update();
                        Get.back();
                      },
                      child: const Text("Save"),
                    );
                  },
                ),
                onConfirm: () async {},
                title: "Edit Details",
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: namecontroller,
                        onChanged: (value) {
                          edit.name = value;
                        },
                        decoration: InputDecoration(
                          hintText: data.name,
                          errorText: validate ? "Value Can't Be Empty " : null,
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: agecontroller,
                        onChanged: (value) {
                          edit.age = value;
                        },
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          hintText: data.age,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: placecontroller,
                        onChanged: (value) {
                          edit.place = value;
                        },
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          hintText: data.place,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<Addstudent>(
          builder: (controller) {
            return ListView(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2,
                  child: data.imagepath == "" || data.imagepath == " "
                      ? Image.asset('assets/download.png')
                      : Image.memory(
                          base64Decode(data.imagepath),
                        ),
                ),
                ListTile(
                  title: Text(
                    "NAME: " + data.name,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  title: Text(
                    "AGE: " + data.age,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  title: Text(
                    "PLACE: " + data.place,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
