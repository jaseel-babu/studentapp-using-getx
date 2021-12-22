import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
String img64 = "";
Future pickImage(ImageSource Source) async {
  var image = await ImagePicker().pickImage(source: Source);
  if (image == null) return;
  final bytes = File(image.path).readAsBytesSync();
  img64 = base64Encode(bytes);
}
