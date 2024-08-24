import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:zzk/classes/FoodSectionClass.dart';
import 'package:zzk/pages/order.dart';

Future<List<FoodSection>> loadFoodSections(String assetPath) async {
  try {
    // Load the CSV file
    final csvData = await rootBundle.loadString(assetPath);
    // Convert CSV to List<List<dynamic>>
    List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(csvData);

    Map<String, List<FoodItem>> sections = {};

    // Skip the header and start parsing rows
    for (final row in rowsAsListOfValues.skip(1)) {
      String sectionName = row[2].toString(); // Convert to String if not already
      FoodItem item = FoodItem(
        id: row[0].toString(),
        language: row[1].toString(),
        category: row[2].toString(),
        name: row[3].toString(),
        imageFileName: row[4].toString(),
        description: row[5].toString(),
        price: double.parse(row[6].toString()),
        restrictions: row[7].toString(),
        ingredients: row[8].toString(),
      );

      sections.putIfAbsent(sectionName, () => []).add(item);
    }

    // Convert the map into a list of FoodSection
    return sections.entries.map((entry) => FoodSection(entry.key, entry.value)).toList();
  } catch (e) {
    print('An error occurred while loading or parsing the CSV: $e');
    return [];
  }
}

Future<List<FoodSection>> read() async {
  String filePath = 'assets/food_menu2.csv'; // Ensure the path matches the location of your CSV file
  List<FoodSection> sections = await loadFoodSections(filePath);
  for (var section in sections) {
    print('Section: ${section.name}');
    for (var item in section.items) {
      print('Item: ${item.name}, Price: ${item.price}, Description: ${item.description}, Image: ${item.imageFileName}');
    }
  }
// return sections after 0.5 seconds
  await Future.delayed(const Duration(milliseconds: 500));
  return sections;
}
