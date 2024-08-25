import 'package:flutter/material.dart';
import 'package:zzk/clicky/clicky_flutter.dart';
import '../../../classes/FoodSectionClass.dart';
import '../../../clicky/styles.dart';
import '../itemPage/item.dart';

class SectionWidget extends StatefulWidget {
  final FoodSection section;
  final String languageCode;
  final String restaurantId;
  final bool isGridMode;

  SectionWidget({
    required this.section,
    required this.languageCode,
    required this.restaurantId,
    required this.isGridMode,
  });

  @override
  _SectionWidgetState createState() => _SectionWidgetState();
}

class _SectionWidgetState extends State<SectionWidget> {
  String selectedCurrency = 'KRW';

  final Map<String, double> exchangeRates = {
    'KRW': 1.0,
    'USD': 0.00075,
    'EUR': 0.00069,
    'JPY': 0.11,
    'CNY': 0.0052,
  };

  @override
  Widget build(BuildContext context) {
    List<FoodItem> filteredItems = widget.section.items
        .where((item) => item.language == widget.languageCode)
        .toList();

    if (filteredItems.isEmpty) {
      return Container();
    }

    filteredItems.sort((a, b) => a.id.compareTo(b.id));

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
              DropdownButton<String>(
                value: selectedCurrency,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedCurrency = newValue;
                    });
                  }
                },
                items: exchangeRates.keys
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        widget.isGridMode
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
                      restaurantId: widget.restaurantId,
                      item: filteredItems[index],
                      languageCode: widget.languageCode,
                      exchangeRate: exchangeRates[selectedCurrency]!,
                      currencyCode: selectedCurrency,
                      receivedImage: Image.asset(
                        'assets/images/${widget.restaurantId}/${filteredItems[index].imageFileName}',
                        fit: BoxFit.cover,
                      ),
                    ),
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
                    restaurantId: widget.restaurantId,
                    exchangeRate: exchangeRates[selectedCurrency]!,
                    currencyCode: selectedCurrency,
                    receievedImage: Image.asset(
                      'assets/images/${widget.restaurantId}/${filteredItems[index].imageFileName}',
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
  final double exchangeRate;
  final String currencyCode;

  ItemGridWidget({
    required this.item,
    required this.languageCode,
    required this.restaurantId,
    required this.exchangeRate,
    required this.currencyCode,
    this.receivedImage,
  });

  @override
  Widget build(BuildContext context) {
    double convertedPrice = item.price * exchangeRate;
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
              exchangeRate: exchangeRate,
              currencyCode: currencyCode,
            ),
          ),
        );
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
                tag: 'restaurantId: $restaurantId, foodItemId: ${item.id}',
                child: receivedImage ?? Text('No Image'),
                transitionOnUserGestures: true,
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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

class ItemListWidget extends StatelessWidget {
  final FoodItem item;
  final String languageCode;
  final String restaurantId;
  final Image? receievedImage;
  final double exchangeRate;
  final String currencyCode;

  ItemListWidget({
    required this.item,
    required this.languageCode,
    required this.restaurantId,
    required this.exchangeRate,
    required this.currencyCode,
    this.receievedImage,
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
            height: 170,
            child: Hero(
              tag: 'restaurantId: $restaurantId, foodItemId: ${item.id}',
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
