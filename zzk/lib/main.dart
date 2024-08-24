import 'package:flutter/material.dart';
import 'package:zzk/clicky/clicky_flutter.dart';
import 'package:zzk/importantVariables.dart';
import 'package:zzk/pages/orderPage/order.dart';

import 'clicky/styles.dart';
import 'pages/allergySelector/allergySelector.dart';
import 'pages/uploaderZone/uploaderZonePage.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

Map<String, bool> allergySelections = {};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        // remove splash and highlight color
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String? menu = 'sakura_breeze';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            //! language dropdown
            DropdownButton<String>(
              // make it small vertically. no padding
              isDense: true,

              value: 'English',
              items: <String>['English', 'Japanese', 'Chinese', 'Korean'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  // update language
                });
              },
            ),
            //! text
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Text(
                'Welcome to the Sakura Breeze restaurant! Please select any dietary restrictions or allergies you may have.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Vegan:
            // Excludes: Milk, Eggs, Fish, Shellfish, Gelatin
            // Vegetarian:
            // Excludes: Fish, Shellfish, Gelatin
            // Halal:
            // Excludes: Pork, Alcohol
            // Kosher:
            // Excludes: Pork, Shellfish
            // Gluten-Free:
            // Excludes: Wheat
            // Pescatarian:
            // Excludes: Pork, Beef
            // Dairy-Free:
            // Excludes: Milk
            // Nut-Free:
            // Excludes: Peanuts, Tree nuts
            // Alcohol-Free:
            // Excludes: Alcohol
            // Low-FODMAP:
            // Excludes: Milk, Wheat, Soy
            // Paleo:
            // Excludes: Milk, Soy, Wheat, Corn
            // Keto:
            // Excludes: Wheat, Corn

            //! preset chips, select one
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  presetChip(label: 'None', turnOnIndex: []),
                  presetChip(label: 'Vegan', turnOnIndex: [2, 3, 4, 12, 13]),
                  presetChip(label: 'Vegetarian', turnOnIndex: [4, 5, 12]),
                  presetChip(label: 'Halal', turnOnIndex: [9, 10]),
                  presetChip(label: 'Kosher', turnOnIndex: [9, 5]),
                  presetChip(label: 'Gluten-Free', turnOnIndex: [7]),
                  presetChip(label: 'Pescatarian', turnOnIndex: [9, 10]),
                  presetChip(label: 'Dairy-Free', turnOnIndex: [2]),
                  presetChip(label: 'Nut-Free', turnOnIndex: [0, 1]),
                  presetChip(label: 'Alcohol-Free', turnOnIndex: [11]),
                  presetChip(label: 'Low-FODMAP', turnOnIndex: [2, 7, 6]),
                  presetChip(label: 'Paleo', turnOnIndex: [2, 6, 7, 14]),
                  presetChip(label: 'Keto', turnOnIndex: [7, 14]),
                ],
              ),
            ),

            //! allergy selector
            Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                // border
                border: Border.all(color: Colors.grey),
                // border radius
                borderRadius: BorderRadius.circular(10),
              ),
              child: AllergySelectorWidget(
                onSelectionsChanged: (Map<String, bool> selections) {
                  // Handle the updated selections here
                  print(selections);
                },
                allergySelections: allergySelections,
                // make a callback function to check the selections from outside
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 32, 0, 16),
              child: Text(
                'When you'
                're ready, click the button below to go to the order page.',
              ),
            ),
            Clicky(
              style: ClickyStyle(
                color: Colors.transparent,
              ),
              child: SizedBox(
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // border radius
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // run csv reader and
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderPage()),
                    );
                  },
                  child: Text(
                    'Order!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UploaderZonePage()),
          );
        },
        isExtended: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text('Uploader Zone'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget presetChip({required String label, required List<int> turnOnIndex}) => Container(
        padding: const EdgeInsets.all(2.0),
        child: InkWell(
          onTap: () {
            // turn on the selected allergies
            setState(() {
              for (int i in turnOnIndex) {
                allergySelections[restrictedFoodIngredients[i]] = true;
              }
              // for the rest, turn off
              for (int i = 0; i < restrictedFoodIngredients.length; i++) {
                if (!turnOnIndex.contains(i)) {
                  allergySelections[restrictedFoodIngredients[i]] = false;
                }
              }

              // update the allergyCodesChosen
              allergyCodesChosen = restrictedFoodIngredients.where((allergy) => allergySelections[allergy]!).toList();
              print('allergySelections: ${allergyCodesChosen}');
            });
          },
          child: Clicky(
            child: Chip(
              // change color when proper checkbox is selected
              backgroundColor: turnOnIndex.every((element) => allergySelections[restrictedFoodIngredients[element]] == true)
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white,
              label: Text(
                label,
                style: TextStyle(
                  color: turnOnIndex.every((element) => allergySelections[restrictedFoodIngredients[element]] == true)
                      ? Colors.white
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
              // border radius
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      );
}
