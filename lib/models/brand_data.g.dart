// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContentIdeaAdapter extends TypeAdapter<ContentIdea> {
  @override
  final int typeId = 40;

  @override
  ContentIdea read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContentIdea(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      pillar: fields[3] as ContentPillar,
      platform: fields[4] as ContentPlatform,
      createdAt: fields[5] as DateTime,
      status: fields[6] as ContentStatus,
      caption: fields[7] as String?,
      tags: (fields[8] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ContentIdea obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.pillar)
      ..writeByte(4)
      ..write(obj.platform)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.caption)
      ..writeByte(8)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContentIdeaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BrandMetricsAdapter extends TypeAdapter<BrandMetrics> {
  @override
  final int typeId = 44;

  @override
  BrandMetrics read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BrandMetrics(
      date: fields[0] as String,
      instagramFollowers: fields[1] as int,
      youtubeSubscribers: fields[2] as int,
      totalViews: fields[3] as int,
      engagement: fields[4] as int,
      revenue: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, BrandMetrics obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.instagramFollowers)
      ..writeByte(2)
      ..write(obj.youtubeSubscribers)
      ..writeByte(3)
      ..write(obj.totalViews)
      ..writeByte(4)
      ..write(obj.engagement)
      ..writeByte(5)
      ..write(obj.revenue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrandMetricsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeeklyContentScheduleAdapter extends TypeAdapter<WeeklyContentSchedule> {
  @override
  final int typeId = 45;

  @override
  WeeklyContentSchedule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeeklyContentSchedule(
      weekStart: fields[0] as String,
      schedule: (fields[1] as Map?)?.cast<String, ContentTask>(),
    );
  }

  @override
  void write(BinaryWriter writer, WeeklyContentSchedule obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.weekStart)
      ..writeByte(1)
      ..write(obj.schedule);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeeklyContentScheduleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ContentTaskAdapter extends TypeAdapter<ContentTask> {
  @override
  final int typeId = 46;

  @override
  ContentTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContentTask(
      day: fields[0] as String,
      type: fields[1] as String,
      topic: fields[2] as String,
      platform: fields[3] as ContentPlatform,
      completed: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ContentTask obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.topic)
      ..writeByte(3)
      ..write(obj.platform)
      ..writeByte(4)
      ..write(obj.completed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContentTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ContentPillarAdapter extends TypeAdapter<ContentPillar> {
  @override
  final int typeId = 41;

  @override
  ContentPillar read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ContentPillar.selfImprovement;
      case 1:
        return ContentPillar.disciplineFocus;
      case 2:
        return ContentPillar.fitnessAesthetics;
      case 3:
        return ContentPillar.academicMindset;
      case 4:
        return ContentPillar.lifestylePhilosophy;
      default:
        return ContentPillar.selfImprovement;
    }
  }

  @override
  void write(BinaryWriter writer, ContentPillar obj) {
    switch (obj) {
      case ContentPillar.selfImprovement:
        writer.writeByte(0);
        break;
      case ContentPillar.disciplineFocus:
        writer.writeByte(1);
        break;
      case ContentPillar.fitnessAesthetics:
        writer.writeByte(2);
        break;
      case ContentPillar.academicMindset:
        writer.writeByte(3);
        break;
      case ContentPillar.lifestylePhilosophy:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContentPillarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ContentPlatformAdapter extends TypeAdapter<ContentPlatform> {
  @override
  final int typeId = 42;

  @override
  ContentPlatform read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ContentPlatform.instagram;
      case 1:
        return ContentPlatform.youtube;
      case 2:
        return ContentPlatform.twitter;
      case 3:
        return ContentPlatform.threads;
      case 4:
        return ContentPlatform.notion;
      case 5:
        return ContentPlatform.blog;
      default:
        return ContentPlatform.instagram;
    }
  }

  @override
  void write(BinaryWriter writer, ContentPlatform obj) {
    switch (obj) {
      case ContentPlatform.instagram:
        writer.writeByte(0);
        break;
      case ContentPlatform.youtube:
        writer.writeByte(1);
        break;
      case ContentPlatform.twitter:
        writer.writeByte(2);
        break;
      case ContentPlatform.threads:
        writer.writeByte(3);
        break;
      case ContentPlatform.notion:
        writer.writeByte(4);
        break;
      case ContentPlatform.blog:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContentPlatformAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ContentStatusAdapter extends TypeAdapter<ContentStatus> {
  @override
  final int typeId = 43;

  @override
  ContentStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ContentStatus.idea;
      case 1:
        return ContentStatus.planned;
      case 2:
        return ContentStatus.inProgress;
      case 3:
        return ContentStatus.completed;
      case 4:
        return ContentStatus.published;
      default:
        return ContentStatus.idea;
    }
  }

  @override
  void write(BinaryWriter writer, ContentStatus obj) {
    switch (obj) {
      case ContentStatus.idea:
        writer.writeByte(0);
        break;
      case ContentStatus.planned:
        writer.writeByte(1);
        break;
      case ContentStatus.inProgress:
        writer.writeByte(2);
        break;
      case ContentStatus.completed:
        writer.writeByte(3);
        break;
      case ContentStatus.published:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContentStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
