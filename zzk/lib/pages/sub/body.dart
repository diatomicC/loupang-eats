import 'package:flutter/material.dart';
import '../../classes/FoodSectionClass.dart';

class SectionWidget extends StatefulWidget {
  final FoodSection section;
  final String languageCode;

  SectionWidget({required this.section, required this.languageCode});

  @override
  _SectionWidgetState createState() => _SectionWidgetState();
}

class _SectionWidgetState extends State<SectionWidget> {
  bool isGridMode = true;
  String selectedCurrency = 'KRW';

  final Map<String, double> exchangeRates = {
    'KRW': 1.0,
    'USD': 0.00075,
    'HKD': 0.0059,
    'CNY': 0.0052,
    'JPY': 0.11,
    'SGD': 0.001,
    'EUR': 0.00069,
    'GBP': 0.00059,
    'AUD': 0.0011,
    'CAD': 0.001,
    'CHF': 0.00067,
    'NZD': 0.0012,
    'THB': 0.025,
    'MYR': 0.0034,
    'PHP': 0.041,
  };

  @override
  Widget build(BuildContext context) {
    List<FoodItem> filteredItems = widget.section.items
        .where((item) => item.language == widget.languageCode)
        .toList();

    if (filteredItems.isEmpty) {
      return Container();
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.section.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  DropdownButton<String>(
                    value: selectedCurrency,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCurrency = newValue!;
                      });
                    },
                    items: exchangeRates.keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  IconButton(
                    icon: Icon(isGridMode ? Icons.list : Icons.grid_view),
                    onPressed: () {
                      setState(() {
                        isGridMode = !isGridMode;
                      });
                    },
                  ),
                ],
              ),
            ],
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
                  return ItemGridWidget(
                    item: filteredItems[index],
                    languageCode: widget.languageCode,
                    exchangeRate: exchangeRates[selectedCurrency]!,
                    currencyCode: selectedCurrency,
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
                    languageCode: widget.languageCode,
                    exchangeRate: exchangeRates[selectedCurrency]!,
                    currencyCode: selectedCurrency,
                  );
                },
              ),
      ],
    );
  }
}

class ItemGridWidget extends StatelessWidget {
  final FoodItem item;
  final String languageCode;
  final double exchangeRate;
  final String currencyCode;

  ItemGridWidget({
    required this.item,
    required this.languageCode,
    required this.exchangeRate,
    required this.currencyCode,
  });

  @override
  Widget build(BuildContext context) {
    double convertedPrice = item.price * exchangeRate;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 170,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://via.placeholder.com/200'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '${convertedPrice.toStringAsFixed(2)} $currencyCode',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemListWidget extends StatelessWidget {
  final FoodItem item;
  final String languageCode;
  final double exchangeRate;
  final String currencyCode;

  ItemListWidget({
    required this.item,
    required this.languageCode,
    required this.exchangeRate,
    required this.currencyCode,
  });

  @override
  Widget build(BuildContext context) {
    double convertedPrice = item.price * exchangeRate;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          leading: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://via.placeholder.com/200'),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.grey),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  item.description,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Price: ${convertedPrice.toStringAsFixed(2)} $currencyCode',
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