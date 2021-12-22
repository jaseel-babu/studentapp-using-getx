import 'package:hive_flutter/hive_flutter.dart';
part 'datamodel.g.dart';

@HiveType(typeId: 0)
class Datamodel extends HiveObject {
  @HiveField(0)
  dynamic name;
  @HiveField(1)
  dynamic age;
  @HiveField(2)
  dynamic place;
  @HiveField(3)
  dynamic imagepath;

  Datamodel(
      {required this.name,
      required this.age,
      required this.place,
      required this.imagepath});
}
