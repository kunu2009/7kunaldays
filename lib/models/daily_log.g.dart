// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyLogAdapter extends TypeAdapter<DailyLog> {
  @override
  final int typeId = 0;

  @override
  DailyLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyLog(
      date: fields[0] as String,
      mood: fields[1] as String,
      sleepHours: fields[2] as double,
      theme: fields[3] as String,
      morningChecklist: (fields[4] as Map?)?.cast<String, bool>(),
      collegeChecklist: (fields[5] as Map?)?.cast<String, bool>(),
      eveningChecklist: (fields[6] as Map?)?.cast<String, bool>(),
      nightChecklist: (fields[7] as Map?)?.cast<String, bool>(),
      metrics: fields[19] as Metrics?,
      mentalRatings: fields[20] as MentalRatings?,
    )
      ..morningWins = fields[8] as String?
      ..collegeInteractions = fields[9] as String?
      ..eveningIdeas = fields[10] as String?
      ..oneGreatThing = fields[11] as String?
      ..oneImprovement = fields[12] as String?
      ..gratitude = fields[13] as String?
      ..topThreeWins = (fields[14] as List?)?.cast<String>()
      ..whatSlowedDown = fields[15] as String?
      ..howToImprove = fields[16] as String?
      ..lessonOfTheDay = fields[17] as String?
      ..thoughtsAndIdeas = fields[18] as String?
      ..sevenKActions = (fields[21] as List).cast<SevenKAction>()
      ..constitutionProgress = fields[22] as int
      ..nutritionLog = (fields[23] as List).cast<NutritionEntry>()
      ..waterIntake = fields[24] as double
      ..timeslept = fields[25] as String?
      ..phoneUseAfter11PM = fields[26] as bool
      ..journalDone = fields[27] as bool
      ..nextDayPrioritySet = fields[28] as bool
      ..exported = fields[29] as bool;
  }

  @override
  void write(BinaryWriter writer, DailyLog obj) {
    writer
      ..writeByte(30)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.mood)
      ..writeByte(2)
      ..write(obj.sleepHours)
      ..writeByte(3)
      ..write(obj.theme)
      ..writeByte(4)
      ..write(obj.morningChecklist)
      ..writeByte(5)
      ..write(obj.collegeChecklist)
      ..writeByte(6)
      ..write(obj.eveningChecklist)
      ..writeByte(7)
      ..write(obj.nightChecklist)
      ..writeByte(8)
      ..write(obj.morningWins)
      ..writeByte(9)
      ..write(obj.collegeInteractions)
      ..writeByte(10)
      ..write(obj.eveningIdeas)
      ..writeByte(11)
      ..write(obj.oneGreatThing)
      ..writeByte(12)
      ..write(obj.oneImprovement)
      ..writeByte(13)
      ..write(obj.gratitude)
      ..writeByte(14)
      ..write(obj.topThreeWins)
      ..writeByte(15)
      ..write(obj.whatSlowedDown)
      ..writeByte(16)
      ..write(obj.howToImprove)
      ..writeByte(17)
      ..write(obj.lessonOfTheDay)
      ..writeByte(18)
      ..write(obj.thoughtsAndIdeas)
      ..writeByte(19)
      ..write(obj.metrics)
      ..writeByte(20)
      ..write(obj.mentalRatings)
      ..writeByte(21)
      ..write(obj.sevenKActions)
      ..writeByte(22)
      ..write(obj.constitutionProgress)
      ..writeByte(23)
      ..write(obj.nutritionLog)
      ..writeByte(24)
      ..write(obj.waterIntake)
      ..writeByte(25)
      ..write(obj.timeslept)
      ..writeByte(26)
      ..write(obj.phoneUseAfter11PM)
      ..writeByte(27)
      ..write(obj.journalDone)
      ..writeByte(28)
      ..write(obj.nextDayPrioritySet)
      ..writeByte(29)
      ..write(obj.exported);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MetricsAdapter extends TypeAdapter<Metrics> {
  @override
  final int typeId = 1;

  @override
  Metrics read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Metrics(
      studyHours: fields[0] as double,
      fitnessMinutes: fields[1] as int,
      screenTime: fields[2] as double,
      steps: fields[3] as int,
      weight: fields[4] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Metrics obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.studyHours)
      ..writeByte(1)
      ..write(obj.fitnessMinutes)
      ..writeByte(2)
      ..write(obj.screenTime)
      ..writeByte(3)
      ..write(obj.steps)
      ..writeByte(4)
      ..write(obj.weight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MetricsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MentalRatingsAdapter extends TypeAdapter<MentalRatings> {
  @override
  final int typeId = 2;

  @override
  MentalRatings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MentalRatings(
      focus: fields[0] as int,
      energy: fields[1] as int,
      mood: fields[2] as int,
      confidence: fields[3] as int,
      selfControl: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MentalRatings obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.focus)
      ..writeByte(1)
      ..write(obj.energy)
      ..writeByte(2)
      ..write(obj.mood)
      ..writeByte(3)
      ..write(obj.confidence)
      ..writeByte(4)
      ..write(obj.selfControl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MentalRatingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SevenKActionAdapter extends TypeAdapter<SevenKAction> {
  @override
  final int typeId = 3;

  @override
  SevenKAction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SevenKAction(
      action: fields[0] as String,
      timestamp: fields[1] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, SevenKAction obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.action)
      ..writeByte(1)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SevenKActionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
