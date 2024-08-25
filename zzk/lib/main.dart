import 'package:flutter/material.dart';
import 'package:zzk/classes/FoodSectionClass.dart';
import 'package:zzk/logic/csvReader.dart';
import 'package:zzk/pages/uploaderZone/uploaderZonePage.dart';

import 'pages/home/homePage.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String? selectedRestaurantId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HackSeoul2024'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: loadPresetRestaurant(),
              builder: (context, AsyncSnapshot<List<Menu>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // Initialize selectedRestaurantId if it's null
                  selectedRestaurantId ??= snapshot.data!.first.restaurantId;

                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Choose a restaurant: '),
                          DropdownButton<String>(
                            isDense: true,
                            value: selectedRestaurantId,
                            items: snapshot.data!.map<DropdownMenuItem<String>>((Menu value) {
                              return DropdownMenuItem<String>(
                                value: value.restaurantId,
                                child: Text(value.restaurantName),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedRestaurantId = newValue;
                              });
                            },
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (selectedRestaurantId != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(
                                  restaurantId: selectedRestaurantId!,
                                  title: snapshot.data!
                                      .firstWhere((menu) => menu.restaurantId == selectedRestaurantId)
                                      .restaurantName,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('Ordering Page'),
                      ),
                    ],
                  );
                } else {
                  return const Text('Loading restaurant...');
                }
              },
            ),
          ),
          Container(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UploaderZonePage()),
              );
            },
            child: const Text('Go to Restaurant Home Page'),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 112, 15, 0)),
        useMaterial3: true,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        // remove splash and highlight color
      ),
      // home: const StartPage(),
      home: const MyHomePage(
        restaurantId: 'rustic_hearth',
        title: 'Rustic Hearth',
      ),
    );
  }
}
