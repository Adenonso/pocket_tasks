// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_tasksdatabase.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubTasksdatabaseAdapter extends TypeAdapter<SubTasksdatabase> {
  @override
  final int typeId = 0;

  @override
  SubTasksdatabase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubTasksdatabase(
      note: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SubTasksdatabase obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubTasksdatabaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
