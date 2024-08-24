import 'package:flutter/material.dart';
import 'package:zzk/classes/FoodSectionClass.dart';

class OrderPageBody extends StatefulWidget {
  OrderPageBody({
    Key? key,
    required this.sections,
    required this.language,
  }) : super(key: key);
  final List<FoodSection> sections;
  String language;

  @override
  State<OrderPageBody> createState() => _OrderPageBodyState();
}

class _OrderPageBodyState extends State<OrderPageBody> {
  Map<String, String> languageCodeMap = {
    'English': 'EN',
    'Korean': 'KO',
    'Chinese': 'ZH',
    'Japanese': 'JA',
  };
  String languageCode = 'KO';

  @override
  void initState() {
    super.initState();
    // bind language to language code
    languageCode = languageCodeMap[widget.language] ?? 'KO';
    print(widget.language);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          /** 
         * SECTION 1: Language Dropdown
         */
          Container(
            alignment: Alignment.centerLeft,
            // color: Colors.blue,
            // height: 200,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            // dropdown menu to choose language. This is now to be used to filter the food items
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              // add border
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Language: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: widget.language,
                    items: <String>['English', 'Korean', 'Chinese', 'Japanese']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      // change language
                      setState(() {
                        widget.language = value!;
                        languageCode = languageCodeMap[widget.language] ?? 'KO';
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          // simple divider
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          /**
           * SECTION 2: Food Items
           */

          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.sections.length,
            itemBuilder: (BuildContext context, int index) {
              return FoodSectionWidget(
                section: widget.sections[index],
                language: widget.language,
              );
            },
          ),
        ],
      ),
    );
  }
}

class FoodSectionWidget extends StatefulWidget {
  final Key? key;
  FoodSection section;
  final String language;

  FoodSectionWidget({required this.section, required this.language, this.key});

  @override
  _FoodSectionWidgetState createState() => _FoodSectionWidgetState();
}

class _FoodSectionWidgetState extends State<FoodSectionWidget> {
  String language = '';
  String languageCode = '';
  Map<String, String> languageCodeMap = {
    'English': 'EN',
    'Korean': 'KO',
    'Chinese': 'ZH',
    'Japanese': 'JA',
  };
  @override
  initState() {
    super.initState();
    // bind language to language code
    languageCode = languageCodeMap[widget.language] ?? 'KO';
    print(widget.language);
    print(languageCode);
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.section.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.section.items.length,
          itemBuilder: (BuildContext context, int index) {
            // return FoodItemWidget(
            //   item: widget.section.items[index],
            //   language: widget.language,
            // );

            // filter the food items based on the language
            // return Text('Language: $languageCode');

            if (widget.section.items[index].language == languageCode) {
              return FoodItemWidget(
                item: widget.section.items[index],
                language: widget.language,
              );
            } else {
              return Container(
                child: Text('?'),
              );
            }
          },
        ),
      ],
    );
  }
}

class FoodItemWidget extends StatefulWidget {
  final FoodItem item;
  final String language;

  FoodItemWidget({required this.item, required this.language});

  @override
  _FoodItemWidgetState createState() => _FoodItemWidgetState();
}

class _FoodItemWidgetState extends State<FoodItemWidget> {
  // filter the food items based on the language

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://via.placeholder.com/200'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.item.description,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Price: ${widget.item.price.toStringAsFixed(2)} 원',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
