import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Daily.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class Daily{
  @HiveField(0)
  String date;
  @HiveField(1)
  int drinked;
  @HiveField(2)
  bool didReached;
  @HiveField(3)
  List activities;

  Daily(this.date,this.drinked,this.didReached,this.activities);
  
  Map<String,dynamic> toMap(){
    var map = <String,dynamic>{
      'date':date,
      'drinked':drinked,
      'didReached':didReached,
      'activities':activities
    };
    return map;
  }

  Daily.fromMap(Map<String,dynamic> map){
    date = map['date'];
    drinked = map['drinked'];
    didReached = map['didReached'];
    activities = map['activities'];
  }
}
