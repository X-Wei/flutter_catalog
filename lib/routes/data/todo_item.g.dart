// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoItemAdapter extends TypeAdapter<TodoItem> {
  @override
  TodoItem read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoItem(
      id: fields[0] as int,
      content: fields[1] as String,
      isDone: fields[2] as bool,
      createdAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TodoItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.isDone)
      ..writeByte(3)
      ..write(obj.createdAt);
  }
}
