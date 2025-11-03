// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confidence_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConfidenceSessionAdapter extends TypeAdapter<ConfidenceSession> {
  @override
  final int typeId = 30;

  @override
  ConfidenceSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConfidenceSession(
      id: fields[0] as String,
      timestamp: fields[1] as DateTime,
      type: fields[2] as ConfidenceType,
      durationMinutes: fields[3] as int,
      recordingPath: fields[4] as String?,
      notes: fields[5] as String?,
      selfRating: fields[6] as int,
      completed: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ConfidenceSession obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.durationMinutes)
      ..writeByte(4)
      ..write(obj.recordingPath)
      ..writeByte(5)
      ..write(obj.notes)
      ..writeByte(6)
      ..write(obj.selfRating)
      ..writeByte(7)
      ..write(obj.completed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfidenceSessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CharismaChallengeAdapter extends TypeAdapter<CharismaChallenge> {
  @override
  final int typeId = 32;

  @override
  CharismaChallenge read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharismaChallenge(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      date: fields[3] as String,
      completed: fields[4] as bool,
      reflection: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CharismaChallenge obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.completed)
      ..writeByte(5)
      ..write(obj.reflection);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharismaChallengeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GroomingRoutineAdapter extends TypeAdapter<GroomingRoutine> {
  @override
  final int typeId = 33;

  @override
  GroomingRoutine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroomingRoutine(
      date: fields[0] as String,
      tasks: (fields[1] as Map?)?.cast<String, bool>(),
    );
  }

  @override
  void write(BinaryWriter writer, GroomingRoutine obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.tasks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroomingRoutineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ConfidenceTypeAdapter extends TypeAdapter<ConfidenceType> {
  @override
  final int typeId = 31;

  @override
  ConfidenceType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ConfidenceType.mirrorTalk;
      case 1:
        return ConfidenceType.readingAloud;
      case 2:
        return ConfidenceType.postureCheck;
      case 3:
        return ConfidenceType.socialWarmup;
      case 4:
        return ConfidenceType.publicSpeaking;
      default:
        return ConfidenceType.mirrorTalk;
    }
  }

  @override
  void write(BinaryWriter writer, ConfidenceType obj) {
    switch (obj) {
      case ConfidenceType.mirrorTalk:
        writer.writeByte(0);
        break;
      case ConfidenceType.readingAloud:
        writer.writeByte(1);
        break;
      case ConfidenceType.postureCheck:
        writer.writeByte(2);
        break;
      case ConfidenceType.socialWarmup:
        writer.writeByte(3);
        break;
      case ConfidenceType.publicSpeaking:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfidenceTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
