import 'package:findages/models/all_ages_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class AgeDatabase {
  late Future<Isar> db;
  AgeDatabase() {
    db = openDB();
  }

  Future<Isar> openDB({String? directory}) async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [AllAgesModelSchema],
        inspector: true,
        directory: directory ?? dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }

  Future addAgeData(AllAgesModel allAgesModel) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.allAgesModels.put(allAgesModel);
    });
  }

  Future<List<AllAgesModel>> allAgesModels() async {
    final isar = await db;
    return isar.allAgesModels.where().findAll();
  }
}
