import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxstudent/controlls/addstudentcontroll.dart';
import 'package:getxstudent/main.dart';
import 'package:getxstudent/model/datamodel.dart';
import 'package:getxstudent/views/studentdata.dart';
import 'package:hive/hive.dart';

class searchPage extends StatelessWidget {
  searchPage({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();
  Box studentDetails = Hive.box(boxname);
  String search = "";
  String namematched = "";
  List dummy = [];
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            GetBuilder<Addstudent>(
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) { 
                      search = value;
                      controller.search();
                    },
                    decoration: const InputDecoration(
                      hintText: "Search Here..",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                  ),
                );
              },
            ),
            GetBuilder<Addstudent>(
              builder: (controller) {
                var keys;
                search == ""
                    ? keys = []
                    : keys = studentDetails.keys.cast().toList();
                return keys != []
                    ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: keys.length,
                          itemBuilder: (context, index) {
                            Datamodel names = studentDetails.get(keys[index]);

                            return names.name == search
                                ? ListTile(
                                    onTap: () {
                                      Get.to(
                                        () => Studentdetail(
                                          index: keys[index],
                                          data: names,
                                        ),
                                      );
                                    },
                                    title: names.name == null
                                        ? const SizedBox()
                                        : Text(names.name),
                                    leading: names.imagepath == "" ||
                                            names.imagepath == " "
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Image.asset(
                                                'assets/download.png'))
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Image.memory(
                                              base64Decode(names.imagepath),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                    trailing: GetBuilder<Addstudent>(
                                      builder: (controller) => IconButton(
                                        icon: const Icon(
                                          Icons.delete_sharp,
                                        ),
                                        onPressed: () {
                                          controller.delete(names);
                                        },
                                      ),
                                    ),
                                  )
                                : const SizedBox();
                          },
                        ),
                      )
                    : const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
