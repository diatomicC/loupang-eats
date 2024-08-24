import 'package:flutter/material.dart';

class AllergySelectorWidget extends StatefulWidget {
  final Function(Map<String, bool>) onSelectionsChanged;

  const AllergySelectorWidget({Key? key, required this.onSelectionsChanged})
      : super(key: key);

  @override
  State<AllergySelectorWidget> createState() => _AllergySelectorWidgetState();
}

class _AllergySelectorWidgetState extends State<AllergySelectorWidget> {
  final Map<String, bool> _selections = {
    'Peanuts': false,
    'Gluten': false,
    'Dairy': false,
    'Soy': false,
    'Shellfish': false,
    'Eggs': false,
    'Fish': false,
    'Tree Nuts': false,
    'Wheat': false,
    'Sesame': false,
    'Sulfites': false,
    'Celery': false,
    'Mustard': false,
    'Lupin': false,
    'Molluscs': false,
  };

  void _onCheckboxChanged(String allergy, bool? value) {
    setState(() {
      _selections[allergy] = value ?? false;
    });
    widget.onSelectionsChanged(_selections);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: _selections.keys
          .map((allergy) => CheckboxListTile(
                title: Text(allergy),
                value: _selections[allergy],
                onChanged: (bool? value) => _onCheckboxChanged(allergy, value),
              ))
          .toList(),
    );
  }
}
