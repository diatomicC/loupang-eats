import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:zzk/classes/FoodSectionClass.dart';

Future<Menu> loadFoodSectionsAndInfo(String restaurantId) async {
  try {
    // Load the CSV file
    String assetPath = 'assets/$restaurantId.csv';
    final csvData = await rootBundle.loadString(assetPath);
    final sections = <String, List<FoodItem>>{};
    // Convert CSV to List<List<dynamic>>. Ignore the first row (header)
    List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(csvData);

    // Skip the header and last row. Last row will contain additional information.
    final rows = rowsAsListOfValues.sublist(1, rowsAsListOfValues.length - 1);

    // retrieve the last row for additional information
    final additionalInfo = rowsAsListOfValues.last;
    String restaurantName = additionalInfo[0].toString();

    // now remove the last row from the list
    rowsAsListOfValues.removeLast();

    for (final row in rows) {
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
    return Menu(
      sections.entries.map((entry) => FoodSection(entry.key, entry.value)).toList(),
      restaurantId,
      restaurantName,
    );
  } catch (e) {
    // print('An error occurred while loading or parsing the CSV: $e');
    return Future.error('An error occurred while loading or parsing the CSV: $e');
  }
}

Future<Menu> read({required String restaurantId}) async {
  Menu menu = await loadFoodSectionsAndInfo(restaurantId);

  List<FoodSection> sections = menu.sections;

  for (var section in sections) {
    // print('Section: ${section.name}');
    for (var item in section.items) {
      // print('Item: ${item.name}, Price: ${item.price}, Description: ${item.description}, Image: ${item.imageFileName}');
    }
  }
// return sections after 0.5 seconds
  await Future.delayed(const Duration(milliseconds: 500));
  return menu;
}
