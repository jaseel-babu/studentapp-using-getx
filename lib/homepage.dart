import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxstudent/views/list.dart';
import 'package:getxstudent/controlls/imagepicking.dart';
import 'package:getxstudent/main.dart';

import 'package:getxstudent/views/searchpage.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import 'controlls/addstudentcontroll.dart';

class HomePage extends StatelessWidget {
  Box studentDetails = Hive.box(boxname);
  Addstudent controller = Get.put(Addstudent());
  bool validate = false;
  var formKey = GlobalKey<FormState>();
  Addstudent add = Addstudent();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController placecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Student Details"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Get.to(() => searchPage());
                },
                icon:const Icon(Icons.search)),
          )
        ],
      ),
      body: SafeArea(child: Detailspage()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
            radius: 30,
            confirm: GetBuilder<Addstudent>(builder: (controller) {
              return TextButton(
                onPressed: () {
                  String name = namecontroller.text;
                  String age = agecontroller.text;
                  String place = placecontroller.text;
                  String image;
                  img64 != "" ? image = img64 : image = "";

                  final isValid = formKey.currentState!.validate();
                  if (!isValid) {
                    return;
                  }
                  formKey.currentState!.save();
                  controller.addstudent(name, age, place, image);
                  namecontroller.clear();
                  agecontroller.clear();
                  placecontroller.clear();
                  img64 = "";
                  Get.back();
                },
                child: const Text("Save"),
              );
            }),
            onConfirm: () async {},
            title: "Add Student",
            content: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: namecontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        hintText: 'Name',
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: agecontroller,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        hintText: 'Age',
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      controller: placecontroller,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        hintText: 'Place',
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                  primary: Colors.grey[300],
                  onPrimary: Colors.black,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  pickImage(ImageSource.camera);
                },
                child: Row(
                  children: const [
                    Icon(Icons.camera),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Camera'),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                  primary: Colors.grey[300],
                  onPrimary: Colors.black,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  pickImage(ImageSource.gallery);
                },
                child: Row(
                  children: const [
                    Icon(Icons.image),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Gallery'),
                  ],
                ),
              )
            ],
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
