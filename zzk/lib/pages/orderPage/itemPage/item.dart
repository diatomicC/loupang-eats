import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zzk/classes/FoodSectionClass.dart';

final Map<String, Map<String, String>> i18n_langCode = {
  'price': {
    'EN': 'Price',
    'KO': '가격',
    'CN': '价格',
    'JA': '価格',
  },
  'description': {
    'EN': 'Description',
    'KO': '설명',
    'CN': '描述',
    'JA': '説明',
  },
};

class ItemPage extends StatelessWidget {
  final FoodItem foodItem;
  final String languageCode;
  final String restaurantId;
  final Image? receivedImage;
  final double exchangeRate;
  final String currencyCode;

  const ItemPage({
    Key? key,
    required this.foodItem,
    required this.languageCode,
    required this.restaurantId,
    required this.exchangeRate,
    required this.currencyCode,
    this.receivedImage,
  }) : super(key: key);

  void _launchURL(String foodItemName) async {
    final query = Uri.encodeComponent("What is $foodItemName?");
    final url = 'https://www.google.com/search?q=$query';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String getI18nLabel(String key) {
    return i18n_langCode[key]?[languageCode] ??
        i18n_langCode[key]?['EN'] ??
        key;
  }

  String getConvertedPrice() {
    double convertedPrice = foodItem.price * exchangeRate;
    return '${convertedPrice.toStringAsFixed(2)} $currencyCode';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                foodItem.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () => _launchURL(foodItem.name),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Hero(
              tag: 'restaurantId: $restaurantId, foodItemId: ${foodItem.id}',
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          foodItem.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          foodItem.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey[300], thickness: 1),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getI18nLabel('price'),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          getConvertedPrice(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.titleLarge,
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
            )
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
  final double exchangeRate;
  final String currencyCode;
  final Image? receivedImage;

  ItemListWidget({
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: InkWell(
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
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            leading: Container(
              height: 170,
              child: Hero(
                tag: 'restaurantId: $restaurantId, foodItemId: ${item.id}',
                child: receivedImage ?? Text('No Image'),
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
      ),
    );
  }
}
