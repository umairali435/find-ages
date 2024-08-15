import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:findages/logics/comp_logic.dart';
import 'package:findages/pages/calculated_age.dart';
import 'package:findages/pages/drawer_screen.dart';
import 'package:findages/pages/history_scareen.dart';
import 'package:findages/providers/database_provider.dart';
import 'package:findages/providers/date_provider.dart';
import 'package:findages/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<DateProvider>(context);
    final databaseProvider = Provider.of<DatabaseProvider>(context);
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text(
          "Find Ages",
          style: TextStyle(
            color: AppColors.whiteColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HistoryScreen(),
                ),
              );
            },
            icon: const Icon(LucideIcons.history),
          ),
        ],
        iconTheme: const IconThemeData(
          color: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                "Select Your birth date to calculate your age",
                textAlign: TextAlign.center,
                style: GoogleFonts.cabin(
                  fontWeight: FontWeight.w900,
                  fontSize: 35.0,
                  letterSpacing: 2.0,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const Gap(30.0),
            CustomCalender(
              value: dateProvider.initialDate,
              onValueChanged: (dates) {
                dateProvider.initialDate = dates[0];
              },
            ),
            const Gap(30.0),
            InkWell(
              onTap: () {
                DateTime ageDate = CompLogic.calculateDateDifference(
                  dateProvider.initialDate,
                  DateTime.now(),
                );
                dateProvider.ageDateDate = ageDate;
                databaseProvider.agesModel.age = ageDate.year;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CalculatedAge(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(
                    5.0,
                  ),
                  border: Border.all(
                    color: AppColors.primaryColor,
                  ),
                ),
                child: const Text(
                  "Calculate",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCalender extends StatelessWidget {
  final DateTime value;
  final Function(List<DateTime>)? onValueChanged;
  const CustomCalender({super.key, required this.value, this.onValueChanged});

  @override
  Widget build(BuildContext context) {
    return CalendarDatePicker2(
      config: CalendarDatePicker2Config(
        selectedRangeHighlightColor: AppColors.primaryColor,
        selectedDayHighlightColor: AppColors.primaryColor,
        firstDate: DateTime(1970),
        lastDate: DateTime.now(),
      ),
      value: [value],
      onValueChanged: onValueChanged,
    );
  }
}
