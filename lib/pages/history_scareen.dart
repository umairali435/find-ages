import 'package:findages/providers/database_provider.dart';
import 'package:findages/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final databaseProvider = Provider.of<DatabaseProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Ages History",
          style: TextStyle(
            color: AppColors.whiteColor,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: ListView.builder(
        itemCount: databaseProvider.allAges.length,
        itemBuilder: (context, index) {
          final allAges = databaseProvider.allAges[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: allAges.age! >= 2 && allAges.age! <= 6
                  ? Image.asset(
                      "assets/child.png",
                      color: AppColors.primaryColor,
                    )
                  : (allAges.age! >= 7 && allAges.age! <= 17)
                      ? Image.asset(
                          "assets/boy.png",
                          color: AppColors.primaryColor,
                        )
                      : (allAges.age! >= 18 && allAges.age! <= 40)
                          ? Image.asset(
                              "assets/man.png",
                              color: AppColors.primaryColor,
                            )
                          : (allAges.age! > 40)
                              ? Image.asset(
                                  "assets/person.png",
                                  color: AppColors.primaryColor,
                                )
                              : Container(),
              title: Text(
                databaseProvider.allAges[index].name ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              subtitle: Text(
                allAges.age.toString(),
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
