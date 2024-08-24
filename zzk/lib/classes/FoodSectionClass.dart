class FoodSection {
  final String name;
  final List<FoodItem> items;

  FoodSection(this.name, this.items);
}

class FoodItem {
  final String id;
  final String language;
  final String category;
  final String name;
  final String imageFileName;
  final String description;
  final double price;
  final String restrictions;
  final String ingredients;

  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.restrictions,
    required this.ingredients,
    required this.imageFileName,
    required this.language,
    required this.category,
  });
}
