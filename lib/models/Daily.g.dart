part of 'Daily.dart';

class DailyAdapter extends TypeAdapter<Daily> {
  @override
  final int typeId = 0;

  @override
  Daily read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Daily(
      fields[0] as String,
      fields[1] as int,
      fields[2] as bool,
      (fields[3] as List)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Daily obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.drinked)
      ..writeByte(2)
      ..write(obj.didReached)
      ..writeByte(3)
      ..write(obj.activities);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
