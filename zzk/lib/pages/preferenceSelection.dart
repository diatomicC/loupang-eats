import 'package:flutter/material.dart';
import 'package:zzk/pages/DietaryRestrictionsSelector.dart'; // Make sure to import the correct path

class PreferenceSelectionPage extends StatefulWidget {
  final List<String> dietaryRestrictionList;

  const PreferenceSelectionPage({
    Key? key,
    required this.dietaryRestrictionList,
  }) : super(key: key);

  @override
  _PreferenceSelectionPageState createState() =>
      _PreferenceSelectionPageState();
}

class _PreferenceSelectionPageState extends State<PreferenceSelectionPage> {
  late Map<String, bool> _selectedRestrictions;

  @override
  void initState() {
    super.initState();
    _selectedRestrictions = {
      for (var item in widget.dietaryRestrictionList) item: false
    };
  }

  void _handleSelectionsChanged(Map<String, bool> selections) {
    setState(() {
      _selectedRestrictions = selections;
    });
  }

  void _savePreferences() {
    // TODO: Implement saving preferences to storage or sending to a server
    print('Saved preferences: $_selectedRestrictions');
    Navigator.pop(context, _selectedRestrictions);
  }

  String _getSelectedPreferencesText() {
    List<String> selectedItems = _selectedRestrictions.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    return selectedItems.isEmpty
        ? 'No preferences selected'
        : 'Selected: ${selectedItems.join(', ')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dietary Preferences'),
      ),
      body: Column(
        children: [
          Expanded(
            child: DietaryRestrictionSelector(
              dietaryRestrictionList: widget.dietaryRestrictionList,
              onSelectionsChanged: _handleSelectionsChanged,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _getSelectedPreferencesText(),
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ElevatedButton(
              onPressed: _savePreferences,
              child: Text('Save Preferences'),
            ),
          ),
        ],
      ),
    );
  }
}
