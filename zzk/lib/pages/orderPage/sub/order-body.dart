import 'package:flutter/material.dart';
import 'package:zzk/clicky/clicky_flutter.dart';
import 'package:zzk/importantVariables.dart';
import '../../../classes/FoodSectionClass.dart';
import '../../../clicky/styles.dart';
import '../itemPage/item.dart';

class SectionWidget extends StatelessWidget {
  final FoodSection section;
  final String languageCode;
  final String restaurantId;

  final bool isGridMode;

  SectionWidget({required this.section, required this.languageCode, required this.restaurantId, required this.isGridMode});

  @override
  Widget build(BuildContext context) {
    List<FoodItem> filteredItems = section.items.where((item) => item.language == languageCode).toList();

    //  if the filteredItems list is empty, return an empty container
    if (filteredItems.isEmpty) {
      return Container(); // Don't show empty sections
    }

    // sort the items by their id
    filteredItems.sort((a, b) => a.id.compareTo(b.id));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            section.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        isGridMode
            ? GridView.builder(
                padding: EdgeInsets.all(8),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
                itemCount: filteredItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return Clicky(
                    style: ClickyStyle(
                      color: Colors.transparent,
                      shrinkScale: ShrinkScale.byRatio(0.04),
                    ),
                    child: ItemGridWidget(
                        restaurantId: restaurantId,
                        item: filteredItems[index],
                        languageCode: languageCode,
                        receivedImage: Image.asset(
                          'assets/images/${restaurantId}/${filteredItems[index].imageFileName}',
                          fit: BoxFit.cover,
                        )),
                  );
                },
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemListWidget(
                    item: filteredItems[index],
                    languageCode: languageCode,
                    restaurantId: restaurantId,
                    receievedImage: Image.asset(
                      'assets/images/${restaurantId}/${filteredItems[index].imageFileName}',
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
      ],
    );
  }
}

class ItemGridWidget extends StatelessWidget {
  final FoodItem item;
  final String restaurantId;
  final String languageCode;
  final Image? receivedImage;

  final allergyCodeMap = {
    '1': 'Eggs',
    '2': 'Fish',
    '3': 'Milk',
    '4': 'Peanuts',
    '5': 'Shellfish',
    '6': 'Soy',
    '7': 'Tree Nuts',
    '8': 'Wheat',
    '9': 'Gluten',
    '10': 'Pork',
    '11': 'Beef',
    '12': 'Chicken',
    '13': 'Duck',
    '14': 'Seafood',
    '15': 'Vegetarian',
  };

  ItemGridWidget({required this.item, required this.languageCode, required this.restaurantId, this.receivedImage});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemPage(
                      foodItem: item,
                      languageCode: languageCode,
                      restaurantId: restaurantId,
                      receivedImage: receivedImage,
                    )));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              width: double.infinity,
              child: Hero(
                tag: 'restaurantId: ${restaurantId}, foodItemId: ${item.id}',
                child: receivedImage ?? Text('No Image'),
                transitionOnUserGestures: true,
                // make the animation curve linear
                createRectTween: (begin, end) {
                  return RectTween(
                    begin: begin,
                    end: end,
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          item.name,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        // warning icon is shown if the item contains any allergens.
                        // use sakuraBreezeAllergy to get the allergen codes of the item
                        // use allergyCodesChosen to get the allergen codes that a user chose to filter

                        if (sakuraBreezeAlergy[item.id.toString()] != null &&
                            allergyCodeMap.keys.any((key) => allergyCodesChosen.contains(key)))
                          Icon(
                            Icons.warning,
                            color: Colors.red,
                          ),
                      ],
                    ),
                    Expanded(
                      child: Text(
                        item.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // show hashtags if there are any allergies that a user chose to filter
            // we can use variable List<String> allergyCodesChosen and Object sakura_breeze_allergy

            buildHashTags(item, allergyCodesChosen),

            // show price
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  '${item.price.toStringAsFixed(0)}원',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    // text spacing
                    letterSpacing: -0.5,
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

Map<String, String> sakuraBreezeAlergy = {
  "1": "3, 6",
  "2": "3, 6",
  "3": "3, 10, 11",
  "4": "3",
  "5": "3, 4",
  "6": "3, 6",
  "7": "3, 10, 11",
  "8": "3",
  "9": "3",
  "10": "3, 8, 10",
  "11": "3, 10, 11",
  "12": "10",
  "13": "3, 5, 8",
  "14": "3, 8",
  "15": "6, 14",
  "16": "6, 14",
  "17": "6, 14",
  "18": "3",
  "19": "14",
  "20": "14",
  "21": "9",
  "22": "6, 14",
  "23": "3, 9",
  "24": "3, 4, 7, 8, 9, 11",
  "25": "3, 7, 8, 9",
  "26": "3, 7, 8",
  "27": "3, 7, 8",
  "28": "3, 7, 8",
  "29": "3, 7, 8",
  "30": "14",
  "31": "14",
  "32": "14",
  "33": "10, 11",
  "34": "10, 11",
  "35": "8, 15",
  "36": "3, 5, 7, 8",
  "37": "3, 5, 7, 8",
  "38": "3, 5, 7, 8",
  "39": "11",
  "40": "3, 5, 7, 8",
  "41": "5, 7, 8",
  "42": "5",
  "43": "11, 7, 8",
  "44": "5, 7, 8",
  "45": "3, 6, 7",
  "46": "3, 6, 7",
  "47": "3, 5, 6, 7",
  "48": "11, 7, 8",
  "49": "11, 7, 8",
  "50": "3, 7, 8",
  "51": "4",
  "52": "4, 5",
  "53": "4, 6",
  "54": "4, 6, 7",
  "55": "4, 10, 11, 7",
  "56": "4, 11, 7, 8",
  "57": "4, 11, 7, 8",
  "58": "8, 15",
  "59": "3, 6, 7, 8",
  "60": "3, 6, 7, 8",
  "61": "5, 7, 8",
  "62": "5, 7, 8",
  "63": "5, 7, 8",
  "64": "3, 4, 5, 7, 8"
};
List<String> allergyNames = [
  'Peanuts',
  'Tree nuts',
  'Milk',
  'Eggs',
  'Fish',
  'Shellfish',
  'Soy',
  'Wheat',
  'Sesame',
  'Pork',
  'Beef',
  'Alcohol',
  'Gelatin',
  'Sulfites',
  'Corn'
];

Widget hashTags(String itemId, List<dynamic> allergyCodesChosen) {
  List<String> itemAllergyCodes = sakuraBreezeAlergy[itemId]?.split(', ') ?? [];
  Set<String> commonAllergies = {};

  for (String itemAllergyCode in itemAllergyCodes) {
    for (var chosenAllergy in allergyCodesChosen) {
      int index = int.parse(itemAllergyCode) - 1;
      if (index >= 0 && index < allergyNames.length) {
        if (chosenAllergy is int && itemAllergyCode == chosenAllergy.toString()) {
          commonAllergies.add(allergyNames[index]);
        } else if (chosenAllergy is String && allergyNames[index].toLowerCase() == chosenAllergy.toLowerCase()) {
          commonAllergies.add(allergyNames[index]);
        }
      }
    }
  }

  return Text(
    commonAllergies.map((allergy) => '#$allergy').join(' '),
    style: TextStyle(
      fontSize: 14,
      color: Colors.red,
      fontWeight: FontWeight.bold,
    ),
  );
}

// Example usage:
// Assuming you have a FoodItem class with an id property
Widget buildHashTags(FoodItem item, List<dynamic> allergyCodesChosen) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: hashTags(item.id.toString(), allergyCodesChosen),
  );
}

class ItemListWidget extends StatelessWidget {
  final FoodItem item;
  final String languageCode;
  final String restaurantId;
  final Image? receievedImage;

  ItemListWidget({required this.item, required this.languageCode, required this.restaurantId, this.receievedImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        // no border radius
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: ListTile(
          // make the leading fit full size
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          leading: Container(
            height: 170,
            child: Hero(
              tag: 'restaurantId: ${restaurantId}, foodItemId: ${item.id}',
              child: receievedImage ?? Text('No Image'),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  item.description,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Price: ${item.price.toStringAsFixed(2)} 원',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
