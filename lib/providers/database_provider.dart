import 'package:findages/data/database.dart';
import 'package:findages/models/all_ages_model.dart';
import 'package:flutter/material.dart';

class DatabaseProvider extends ChangeNotifier {
  AgeDatabase appDatabase = AgeDatabase();
  AllAgesModel agesModel = AllAgesModel();
  TextEditingController nameController = TextEditingController();
  DatabaseProvider() {
    getAllAges();
  }
  Future addAgesToDatabase() async {
    AllAgesModel allAgesModel = AllAgesModel()
      ..age = agesModel.age
      ..name = nameController.text;
    await appDatabase.addAgeData(allAgesModel).then((value) {
      agesModel = AllAgesModel();
    });
    nameController.clear();
    await getAllAges();
  }

  List<AllAgesModel> allAges = [];
  Future getAllAges() async {
    List<AllAgesModel> allAgesData = await appDatabase.allAgesModels();
    allAges = allAgesData;
    notifyListeners();
  }
}
