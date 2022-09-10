import 'package:hive_example/model/data_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Boxes {
  static Box<DataModel> getData() {
    return Hive.box<DataModel>('data');
  }
}
