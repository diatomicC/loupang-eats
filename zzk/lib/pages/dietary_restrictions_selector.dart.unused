import 'package:flutter/material.dart';

class DietaryRestrictionsSelector extends StatefulWidget {
  final List<String> dietaryRestrictions;
  final Function(List<String>) onSelectionChanged;

  const DietaryRestrictionsSelector({
    Key? key,
    required this.dietaryRestrictions,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  _DietaryRestrictionsSelectorState createState() =>
      _DietaryRestrictionsSelectorState();
}

class _DietaryRestrictionsSelectorState
    extends State<DietaryRestrictionsSelector> {
  List<bool> _selectedRestrictions = [];

  @override
  void initState() {
    super.initState();
    _selectedRestrictions =
        List.generate(widget.dietaryRestrictions.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.dietaryRestrictions.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          title: Text(widget.dietaryRestrictions[index]),
          value: _selectedRestrictions[index],
          onChanged: (bool? value) {
            setState(() {
              _selectedRestrictions[index] = value ?? false;
            });
            _updateSelectedRestrictions();
          },
        );
      },
    );
  }

  void _updateSelectedRestrictions() {
    List<String> selectedItems = [];
    for (int i = 0; i < _selectedRestrictions.length; i++) {
      if (_selectedRestrictions[i]) {
        selectedItems.add(widget.dietaryRestrictions[i]);
      }
    }
    widget.onSelectionChanged(selectedItems);
  }
}

// Usage example:
class MyHomePage extends StatelessWidget {
  final List<String> dietaryRestrictionList = [
    'Vegetarian',
    'Vegan',
    'Pescatarian',
    'Gluten-free',
    'Lactose-free',
    'Dairy-free',
    'Nut-free',
    'Kosher',
    'Halal',
    'Low-carb',
    'Keto',
    'Paleo',
    'Low-sodium',
    'Low-fat',
    'Sugar-free',
    'Egg-free',
    'Soy-free',
    'Shellfish-free',
    'FODMAP',
    'Diabetic',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dietary Restrictions')),
      body: DietaryRestrictionsSelector(
        dietaryRestrictions: dietaryRestrictionList,
        onSelectionChanged: (selectedRestrictions) {
          // Handle the selected restrictions here
          print('Selected restrictions: $selectedRestrictions');
        },
      ),
    );
  }
}
