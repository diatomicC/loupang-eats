import 'package:flutter/material.dart';
import 'package:zzk/classes/FoodSectionClass.dart';

class OrderPageBody extends StatefulWidget {
  const OrderPageBody({Key? key, required this.section}) : super(key: key);
  final FoodSection section;

  @override
  State<OrderPageBody> createState() => _OrderPageBodyState();
}

class _OrderPageBodyState extends State<OrderPageBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: _buildFoodSection(
      widget.section,
    ));
  }
}

Widget _buildFoodSection(FoodSection section) {
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
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: section.items.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildFoodItem(section.items[index]);
        },
      ),
    ],
  );
}

Widget _buildFoodItem(FoodItem item) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      child: Column(
        children: [
          //placeholder image
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
                  'Price: ${item.price.toStringAsFixed(2)} 원',
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
