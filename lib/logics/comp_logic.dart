class CompLogic {
  CompLogic._();
  static DateTime calculateDateDifference(DateTime startDate, DateTime endDate) {
    if (startDate.isAfter(endDate)) {
      throw ArgumentError('Start date should be before end date');
    }
    int years = endDate.year - startDate.year;
    int months = endDate.month - startDate.month;
    int days = endDate.day - startDate.day;

    if (days < 0) {
      months--;
      final previousMonthDate = DateTime(endDate.year, endDate.month - 1, startDate.day);
      days = DateTime(endDate.year, endDate.month, 0).day - previousMonthDate.day + endDate.day;
    }

    if (months < 0) {
      years--;
      months += 12;
    }
    return DateTime(years, months, days);
  }
}
