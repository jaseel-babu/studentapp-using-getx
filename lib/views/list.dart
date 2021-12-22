import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxstudent/controlls/addstudentcontroll.dart';
import 'package:getxstudent/main.dart';
import 'package:getxstudent/model/datamodel.dart';
import 'package:getxstudent/views/studentdata.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Detailspage extends StatelessWidget {
  Detailspage({Key? key}) : super(key: key);
  Box studentDetails = Hive.box(boxname);
  Addstudent controller = Get.put(Addstudent());
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: GetBuilder<Addstudent>(
              builder: (controller) {
                var keys = studentDetails.keys.cast().toList();

                return keys.isEmpty
                    ? const Center(
                        child: Text('Add Student Details'),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListView.separated(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: keys.length,
                          itemBuilder: (context, index) {
                            Datamodel names = studentDetails.get(keys[index]);
                            return ListTile(
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
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.asset('assets/download.png'))
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
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
                            );
                          },
                        ),
                      );
              },
            ),
          ),
        ),
      ],
    );
  }
}
