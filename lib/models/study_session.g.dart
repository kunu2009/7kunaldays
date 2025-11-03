// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_session.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudySessionAdapter extends TypeAdapter<StudySession> {
  @override
  final int typeId = 10;

  @override
  StudySession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudySession(
      id: fields[0] as String,
      subject: fields[1] as String,
      topic: fields[2] as String,
      startTime: fields[3] as DateTime,
      endTime: fields[4] as DateTime?,
      durationMinutes: fields[5] as int,
      focusPercentage: fields[6] as int,
      notes: fields[7] as String?,
      mockTestResult: fields[8] as String?,
      reflection: fields[9] as String?,
      type: fields[10] as StudyType,
      isCompleted: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, StudySession obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.subject)
      ..writeByte(2)
      ..write(obj.topic)
      ..writeByte(3)
      ..write(obj.startTime)
      ..writeByte(4)
      ..write(obj.endTime)
      ..writeByte(5)
      ..write(obj.durationMinutes)
      ..writeByte(6)
      ..write(obj.focusPercentage)
      ..writeByte(7)
      ..write(obj.notes)
      ..writeByte(8)
      ..write(obj.mockTestResult)
      ..writeByte(9)
      ..write(obj.reflection)
      ..writeByte(10)
      ..write(obj.type)
      ..writeByte(11)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudySessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SubjectProgressAdapter extends TypeAdapter<SubjectProgress> {
  @override
  final int typeId = 12;

  @override
  SubjectProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectProgress(
      subject: fields[0] as String,
      totalTopics: fields[1] as int,
      completedTopics: fields[2] as int,
      topics: (fields[3] as Map?)?.cast<String, bool>(),
      totalHours: fields[4] as double,
      lastStudied: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, SubjectProgress obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.subject)
      ..writeByte(1)
      ..write(obj.totalTopics)
      ..writeByte(2)
      ..write(obj.completedTopics)
      ..writeByte(3)
      ..write(obj.topics)
      ..writeByte(4)
      ..write(obj.totalHours)
      ..writeByte(5)
      ..write(obj.lastStudied);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ConstitutionTrackerAdapter extends TypeAdapter<ConstitutionTracker> {
  @override
  final int typeId = 13;

  @override
  ConstitutionTracker read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConstitutionTracker(
      articles: (fields[0] as Map?)?.cast<int, ArticleStatus>(),
      totalArticles: fields[1] as int,
      masteredArticles: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ConstitutionTracker obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.articles)
      ..writeByte(1)
      ..write(obj.totalArticles)
      ..writeByte(2)
      ..write(obj.masteredArticles);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConstitutionTrackerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StudyTypeAdapter extends TypeAdapter<StudyType> {
  @override
  final int typeId = 11;

  @override
  StudyType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return StudyType.deepFocus;
      case 1:
        return StudyType.revision;
      case 2:
        return StudyType.mockTest;
      case 3:
        return StudyType.practice;
      case 4:
        return StudyType.constitution;
      default:
        return StudyType.deepFocus;
    }
  }

  @override
  void write(BinaryWriter writer, StudyType obj) {
    switch (obj) {
      case StudyType.deepFocus:
        writer.writeByte(0);
        break;
      case StudyType.revision:
        writer.writeByte(1);
        break;
      case StudyType.mockTest:
        writer.writeByte(2);
        break;
      case StudyType.practice:
        writer.writeByte(3);
        break;
      case StudyType.constitution:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudyTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ArticleStatusAdapter extends TypeAdapter<ArticleStatus> {
  @override
  final int typeId = 14;

  @override
  ArticleStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ArticleStatus.notStarted;
      case 1:
        return ArticleStatus.learning;
      case 2:
        return ArticleStatus.revision;
      case 3:
        return ArticleStatus.mastered;
      default:
        return ArticleStatus.notStarted;
    }
  }

  @override
  void write(BinaryWriter writer, ArticleStatus obj) {
    switch (obj) {
      case ArticleStatus.notStarted:
        writer.writeByte(0);
        break;
      case ArticleStatus.learning:
        writer.writeByte(1);
        break;
      case ArticleStatus.revision:
        writer.writeByte(2);
        break;
      case ArticleStatus.mastered:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
