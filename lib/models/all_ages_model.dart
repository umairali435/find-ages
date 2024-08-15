import 'package:isar/isar.dart';

part 'all_ages_model.g.dart';

@collection
class AllAgesModel {
  Id id = Isar.autoIncrement;
  String? name;
  int? age;
}
