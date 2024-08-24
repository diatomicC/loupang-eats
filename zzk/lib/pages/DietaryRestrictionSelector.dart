import 'package:flutter/material.dart';

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

class DietaryRestrictionSelector extends StatefulWidget {
  final List<String> dietaryRestrictionList;
  final Function(Map<String, bool>) onSelectionsChanged;

/* list need to be manually set in the parent page / or here
the two  key parameters are the dietary rectrion list for the list of selections we need
this.dietaryRestrictionList: string list/array
this.onSelectionsChanged: what to do if the selections are changed for the list
  preferrably call set state
*/
  const DietaryRestrictionSelector({
    Key? key,
    required this.dietaryRestrictionList,
    required this.onSelectionsChanged,
  }) : super(key: key);

  @override
  _DietaryRestrictionSelectorState createState() =>
      _DietaryRestrictionSelectorState();
}

class _DietaryRestrictionSelectorState
    extends State<DietaryRestrictionSelector> {
  late Map<String, bool> _selections;

/* starting default values for all preference set to false */
  @override
  void initState() {
    super.initState();
    _selections = {for (var item in widget.dietaryRestrictionList) item: false};
  }

/* handle checkbox state change */
  void _onCheckboxChanged(String restriction, bool? value) {
    setState(() {
      _selections[restriction] = value ?? false;
    });
    widget.onSelectionsChanged(_selections);
  }

/* map the list of preferences from dietaryRestrictionsList and handle the displayed component structure */
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.dietaryRestrictionList.length,
      itemBuilder: (context, index) {
        final restriction = widget.dietaryRestrictionList[index];
        return CheckboxListTile(
          title: Text(restriction),
          value: _selections[restriction],
          onChanged: (bool? value) => _onCheckboxChanged(restriction, value),
        );
      },
    );
  }
}
