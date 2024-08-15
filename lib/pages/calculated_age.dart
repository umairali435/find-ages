import 'package:findages/pages/history_scareen.dart';
import 'package:findages/providers/database_provider.dart';
import 'package:findages/providers/date_provider.dart';
import 'package:findages/utils/colors.dart';
import 'package:findages/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class CalculatedAge extends StatelessWidget {
  const CalculatedAge({super.key});

  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<DateProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Calculated Age",
          style: TextStyle(
            color: AppColors.whiteColor,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.primaryColor,
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                children: [
                  Text(
                    "You are",
                    style: GoogleFonts.poppins(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${dateProvider.ageDateDate.year} Years",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Text(
                        " & ${dateProvider.ageDateDate.month} Months",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Old",
                    style: GoogleFonts.poppins(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const Gap(20.0),
                  if (dateProvider.ageDateDate.year >= 2 && dateProvider.ageDateDate.year <= 6)
                    Image.asset(
                      "assets/child.png",
                      color: AppColors.primaryColor,
                    )
                  else if (dateProvider.ageDateDate.year >= 7 && dateProvider.ageDateDate.year <= 17)
                    Image.asset(
                      "assets/boy.png",
                      color: AppColors.primaryColor,
                    )
                  else if (dateProvider.ageDateDate.year >= 18 && dateProvider.ageDateDate.year <= 40)
                    Image.asset(
                      "assets/man.png",
                      color: AppColors.primaryColor,
                    )
                  else if (dateProvider.ageDateDate.year > 40)
                    Image.asset(
                      "assets/person.png",
                      color: AppColors.primaryColor,
                    ),
                  const Gap(20.0),
                ],
              ),
            ),
            const Gap(30.0),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const BottomSheetContent();
                  },
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
                  "Save Age",
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

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({super.key});

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<DateProvider>(context);
    final databaseProvider = Provider.of<DatabaseProvider>(context);
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const CircleAvatar(
                        child: Icon(
                          Icons.close,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(10.0),
                Text(
                  "Save this age for later",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                ),
                const Gap(20.0),
                CustomTextField(
                  controller: databaseProvider.nameController,
                  labelText: "Person Relation",
                  validator: (value) {
                    if (value == null || value == "") {
                      return "please enter person relation";
                    }
                    return null;
                  },
                ),
                const Gap(60.0),
                InkWell(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      databaseProvider.agesModel.age = dateProvider.ageDateDate.year;
                      await databaseProvider.addAgesToDatabase().then((value) => Navigator.of(context).pop());
                    }
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
                      "Save",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
                const Gap(20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
