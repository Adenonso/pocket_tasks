// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskdatabase.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskdatabaseAdapter extends TypeAdapter<Taskdatabase> {
  @override
  final int typeId = 1;

  @override
  Taskdatabase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Taskdatabase(
      title: fields[0] as String? ?? '',
      noteContents: (fields[2] as List).cast<SubTasksdatabase>(),
      createdAt: fields[4] as DateTime?,
      isCompleted: fields[3] as bool?,
      myNotes: fields[1] as String? ?? '',
    );
  }

  @override
  void write(BinaryWriter writer, Taskdatabase obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.myNotes)
      ..writeByte(2)
      ..write(obj.noteContents)
      ..writeByte(3)
      ..write(obj.isCompleted)
      ..writeByte(4)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskdatabaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
