// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datamodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DatamodelAdapter extends TypeAdapter<Datamodel> {
  @override
  final int typeId = 0;

  @override
  Datamodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Datamodel(
      name: fields[0] as dynamic,
      age: fields[1] as dynamic,
      place: fields[2] as dynamic,
      imagepath: fields[3] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Datamodel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.place)
      ..writeByte(3)
      ..write(obj.imagepath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatamodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
