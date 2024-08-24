import 'package:flutter/material.dart';

class OrderingScreen extends StatelessWidget {
  final List<FoodSection> foodSections = [
    FoodSection(
      'Appetizers',
      [
        FoodItem('Garlic Bread', 5.99, 'Crispy bread with garlic butter', 'https://example.com/garlic_bread.jpg'),
        FoodItem('Mozzarella Sticks', 7.99, 'Crispy outside, gooey inside', 'https://example.com/mozzarella_sticks.jpg'),
      ],
    ),
    FoodSection(
      'Main Course',
      [
        FoodItem('Margherita Pizza', 12.99, 'Classic tomato and mozzarella', 'https://example.com/margherita_pizza.jpg'),
        FoodItem('Chicken Alfredo', 14.99, 'Creamy pasta with grilled chicken', 'https://example.com/chicken_alfredo.jpg'),
      ],
    ),
    // Add more sections as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 240.0,
            floating: false,
            titleSpacing: 30,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: Container(
                child: Stack(
                  children: [
                    Text('Our Menu'),
                    Container(
                      color: Colors.white.withOpacity(0.5),
                    )
                  ],
                ),
                // decoration: BoxDecoration(
                //   color: Colors.white.withOpacity(0.5),
                //   borderRadius: BorderRadius.circular(8),
                // ),
              ),
              background: Image.network(
                // sample image
                'https://www.eatright.org/-/media/images/eatright-landing-pages/foodgroupslp_804x482.jpg?as=0&w=967&rev=d0d1ce321d944bbe82024fff81c938e7&hash=E6474C8EFC5BE5F0DA9C32D4A797D10D',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index >= foodSections.length) return null;
                return _buildFoodSection(foodSections[index]);
              },
              childCount: foodSections.length,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index >= foodSections.length) return null;
                return _buildFoodSection(foodSections[index]);
              },
              childCount: foodSections.length,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index >= foodSections.length) return null;
                return _buildFoodSection(foodSections[index]);
              },
              childCount: foodSections.length,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index >= foodSections.length) return null;
                return _buildFoodSection(foodSections[index]);
              },
              childCount: foodSections.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodSection(FoodSection section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            section.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: section.items.length,
          itemBuilder: (context, index) {
            return _buildFoodItem(section.items[index]);
          },
        ),
      ],
    );
  }

  Widget _buildFoodItem(FoodItem item) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
            // backgroundImage: NetworkImage(item.imageUrl),
            ),
        title: Text(item.name),
        subtitle: Text(item.description),
        trailing: Text(
          '\$${item.price.toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class FoodSection {
  final String name;
  final List<FoodItem> items;

  FoodSection(this.name, this.items);
}

class FoodItem {
  final String name;
  final double price;
  final String description;
  final String imageUrl;

  FoodItem(this.name, this.price, this.description, this.imageUrl);
}
