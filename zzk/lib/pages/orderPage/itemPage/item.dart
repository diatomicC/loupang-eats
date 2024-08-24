import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zzk/classes/FoodSectionClass.dart';

class ItemPage extends StatefulWidget {
  final FoodItem foodItem;
  final String languageCode;
  final String restaurantId;

  const ItemPage({
    Key? key,
    required this.foodItem,
    required this.languageCode,
    required this.restaurantId,
  }) : super(key: key);

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  void _launchURL(String foodItemName) async {
    final query = Uri.encodeComponent("What is $foodItemName?");
    final url = 'https://www.google.com/search?q=$query';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'foodItem-${widget.foodItem.name}',
          child: Row(
            children: [
              Text(
                widget.foodItem.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () => _launchURL(widget.foodItem.name),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Hero(
            tag: 'foodItem-${widget.foodItem.name}',
            child: Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.asset(
                          'assets/images/${widget.restaurantId}/${widget.foodItem.imageFileName}')
                      .image,
                  onError: (exception, stackTrace) {
                    print('Error loading image: $exception');
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // show name
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.foodItem.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // show description
                    Text(
                      widget.foodItem.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              //divider
              Divider(color: Colors.grey[300], thickness: 1),
              // show price
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '가격',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${widget.foodItem.price.toStringAsFixed(0)}원',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // show button to add to cart
            ],
          ),
        ],
      ),
    );
  }
}
