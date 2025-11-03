// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamification_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProgressAdapter extends TypeAdapter<UserProgress> {
  @override
  final int typeId = 50;

  @override
  UserProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProgress(
      totalXP: fields[0] as int,
      level: fields[1] as int,
      pillarProgress: (fields[2] as Map?)?.cast<Pillar, PillarProgress>(),
      achievements: (fields[3] as List?)?.cast<Achievement>(),
      streaks: (fields[4] as Map?)?.cast<String, int>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserProgress obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.totalXP)
      ..writeByte(1)
      ..write(obj.level)
      ..writeByte(2)
      ..write(obj.pillarProgress)
      ..writeByte(3)
      ..write(obj.achievements)
      ..writeByte(4)
      ..write(obj.streaks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PillarProgressAdapter extends TypeAdapter<PillarProgress> {
  @override
  final int typeId = 52;

  @override
  PillarProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PillarProgress(
      pillar: fields[0] as Pillar,
      xp: fields[1] as int,
      level: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PillarProgress obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.pillar)
      ..writeByte(1)
      ..write(obj.xp)
      ..writeByte(2)
      ..write(obj.level);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PillarProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AchievementAdapter extends TypeAdapter<Achievement> {
  @override
  final int typeId = 53;

  @override
  Achievement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Achievement(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      iconEmoji: fields[3] as String,
      unlockedAt: fields[4] as DateTime,
      relatedPillar: fields[5] as Pillar,
    );
  }

  @override
  void write(BinaryWriter writer, Achievement obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.iconEmoji)
      ..writeByte(4)
      ..write(obj.unlockedAt)
      ..writeByte(5)
      ..write(obj.relatedPillar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AchievementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PillarAdapter extends TypeAdapter<Pillar> {
  @override
  final int typeId = 51;

  @override
  Pillar read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Pillar.discipline;
      case 1:
        return Pillar.academics;
      case 2:
        return Pillar.fitness;
      case 3:
        return Pillar.confidence;
      case 4:
        return Pillar.brand;
      case 5:
        return Pillar.energy;
      default:
        return Pillar.discipline;
    }
  }

  @override
  void write(BinaryWriter writer, Pillar obj) {
    switch (obj) {
      case Pillar.discipline:
        writer.writeByte(0);
        break;
      case Pillar.academics:
        writer.writeByte(1);
        break;
      case Pillar.fitness:
        writer.writeByte(2);
        break;
      case Pillar.confidence:
        writer.writeByte(3);
        break;
      case Pillar.brand:
        writer.writeByte(4);
        break;
      case Pillar.energy:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PillarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
