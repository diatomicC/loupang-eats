import 'package:flutter/material.dart';
import 'package:zzk/clicky/styles.dart';
import 'package:zzk/importantVariables.dart';

import '../../clicky/clicky_flutter.dart';

List<String> restrictedFoodIngredients = [
  'Peanuts',
  'Tree nuts (almonds, walnuts, cashews)',
  'Milk (dairy)',
  'Eggs',
  'Fish',
  'Shellfish (shrimp, crab, lobster)',
  'Soy',
  'Wheat (gluten)',
  'Sesame',
  'Pork',
  'Beef',
  'Alcohol',
  'Gelatin',
  'Sulfites',
  'Corn'
];

class AllergySelectorWidget extends StatefulWidget {
  final Function(Map<String, bool>) onSelectionsChanged;
  final Map<String, bool> allergySelections;

  const AllergySelectorWidget({
    Key? key,
    required this.onSelectionsChanged,
    required this.allergySelections,
  }) : super(key: key);

  @override
  State<AllergySelectorWidget> createState() => _AllergySelectorWidgetState();
}

class _AllergySelectorWidgetState extends State<AllergySelectorWidget> {
  @override
  void initState() {
    super.initState();
    // put all list items to false
    restrictedFoodIngredients.forEach((allergy) {
      if (!widget.allergySelections.containsKey(allergy)) {
        widget.allergySelections[allergy] = false;
      }
    });
  }

  @override
  void didUpdateWidget(AllergySelectorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.allergySelections != oldWidget.allergySelections) {
      setState(() {
        widget.allergySelections.forEach((key, value) {
          if (!restrictedFoodIngredients.contains(key)) {
            widget.allergySelections.remove(key);
          }
        });
      });
    }
  }

  void _onCheckboxChanged(String allergy, bool? value) {
    setState(() {
      widget.allergySelections[allergy] = value!;
    });
    widget.onSelectionsChanged(widget.allergySelections);
    // allergyCodesChosen is List<String> with allergies identified by its index
    allergyCodesChosen = restrictedFoodIngredients.where((allergy) => widget.allergySelections[allergy]!).toList();
    print('allergySelections: ${allergyCodesChosen}');
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.allergySelections.length,
      separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.grey[300], height: 4),
      itemBuilder: (BuildContext context, int index) {
        String allergy = widget.allergySelections.keys.elementAt(index);
        return Clicky(
          style: ClickyStyle(
            color: Color.fromARGB(18, 0, 0, 0),
          ),
          child: CheckboxListTile(
            visualDensity: VisualDensity.compact,
            contentPadding: EdgeInsets.symmetric(horizontal: 8),
            dense: true,
            title: Text(allergy, style: TextStyle(fontSize: 17)),
            value: widget.allergySelections[allergy] ?? false,
            onChanged: (bool? value) => _onCheckboxChanged(allergy, value),
          ),
        );
      },
    );
  }
}
