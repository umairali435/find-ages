import 'package:flutter/material.dart';

class DateProvider extends ChangeNotifier {
  DateTime _initialDate = DateTime(1995, 8, 8);
  DateTime get initialDate => _initialDate;
  set initialDate(DateTime date) {
    _initialDate = date;
    notifyListeners();
  }

  DateTime _ageDateDate = DateTime.now();
  DateTime get ageDateDate => _ageDateDate;
  set ageDateDate(DateTime date) {
    _ageDateDate = date;
    notifyListeners();
  }
}
