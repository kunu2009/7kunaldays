// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fitness_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FitnessLogAdapter extends TypeAdapter<FitnessLog> {
  @override
  final int typeId = 20;

  @override
  FitnessLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FitnessLog(
      date: fields[0] as String,
      exercises: (fields[1] as List?)?.cast<Exercise>(),
      totalMinutes: fields[2] as int,
      energyLevel: fields[3] as int,
      notes: fields[4] as String?,
      workoutCompleted: fields[5] as bool,
      weight: fields[6] as double?,
      height: fields[7] as double?,
      measurements: fields[8] as BodyMeasurements?,
    );
  }

  @override
  void write(BinaryWriter writer, FitnessLog obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.exercises)
      ..writeByte(2)
      ..write(obj.totalMinutes)
      ..writeByte(3)
      ..write(obj.energyLevel)
      ..writeByte(4)
      ..write(obj.notes)
      ..writeByte(5)
      ..write(obj.workoutCompleted)
      ..writeByte(6)
      ..write(obj.weight)
      ..writeByte(7)
      ..write(obj.height)
      ..writeByte(8)
      ..write(obj.measurements);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FitnessLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExerciseAdapter extends TypeAdapter<Exercise> {
  @override
  final int typeId = 21;

  @override
  Exercise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Exercise(
      name: fields[0] as String,
      type: fields[1] as ExerciseType,
      sets: fields[2] as int,
      reps: fields[3] as int,
      durationMinutes: fields[4] as int,
      completed: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Exercise obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.sets)
      ..writeByte(3)
      ..write(obj.reps)
      ..writeByte(4)
      ..write(obj.durationMinutes)
      ..writeByte(5)
      ..write(obj.completed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BodyMeasurementsAdapter extends TypeAdapter<BodyMeasurements> {
  @override
  final int typeId = 23;

  @override
  BodyMeasurements read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BodyMeasurements(
      date: fields[0] as String,
      chest: fields[1] as double?,
      waist: fields[2] as double?,
      arms: fields[3] as double?,
      shoulders: fields[4] as double?,
      forearms: fields[5] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, BodyMeasurements obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.chest)
      ..writeByte(2)
      ..write(obj.waist)
      ..writeByte(3)
      ..write(obj.arms)
      ..writeByte(4)
      ..write(obj.shoulders)
      ..writeByte(5)
      ..write(obj.forearms);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyMeasurementsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MealPlanAdapter extends TypeAdapter<MealPlan> {
  @override
  final int typeId = 24;

  @override
  MealPlan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealPlan(
      name: fields[0] as String,
      breakfast: (fields[1] as List?)?.cast<String>(),
      lunch: (fields[2] as List?)?.cast<String>(),
      evening: (fields[3] as List?)?.cast<String>(),
      dinner: (fields[4] as List?)?.cast<String>(),
      isBudgetFriendly: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MealPlan obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.breakfast)
      ..writeByte(2)
      ..write(obj.lunch)
      ..writeByte(3)
      ..write(obj.evening)
      ..writeByte(4)
      ..write(obj.dinner)
      ..writeByte(5)
      ..write(obj.isBudgetFriendly);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealPlanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExerciseTypeAdapter extends TypeAdapter<ExerciseType> {
  @override
  final int typeId = 22;

  @override
  ExerciseType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ExerciseType.cardio;
      case 1:
        return ExerciseType.strength;
      case 2:
        return ExerciseType.flexibility;
      case 3:
        return ExerciseType.calisthenics;
      case 4:
        return ExerciseType.stretching;
      default:
        return ExerciseType.cardio;
    }
  }

  @override
  void write(BinaryWriter writer, ExerciseType obj) {
    switch (obj) {
      case ExerciseType.cardio:
        writer.writeByte(0);
        break;
      case ExerciseType.strength:
        writer.writeByte(1);
        break;
      case ExerciseType.flexibility:
        writer.writeByte(2);
        break;
      case ExerciseType.calisthenics:
        writer.writeByte(3);
        break;
      case ExerciseType.stretching:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
