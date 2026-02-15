// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'idea_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IdeaModelAdapter extends TypeAdapter<IdeaModel> {
  @override
  final int typeId = 0;

  @override
  IdeaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IdeaModel(
      title: fields[0] as String,
      tagline: fields[1] as String,
      description: fields[2] as String,
      score: fields[3] as int,
      votes: fields[4] as int,
      isFavorite: fields[5] as bool,
      badge: fields[7] as String,
      gradientColors: (fields[6] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, IdeaModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.tagline)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.score)
      ..writeByte(4)
      ..write(obj.votes)
      ..writeByte(5)
      ..write(obj.isFavorite)
      ..writeByte(6)
      ..write(obj.gradientColors)
      ..writeByte(7)
      ..write(obj.badge);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdeaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
