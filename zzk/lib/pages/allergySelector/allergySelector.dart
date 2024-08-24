import 'package:flutter/material.dart';

class AllergySelectorWidget extends StatefulWidget {
  const AllergySelectorWidget({super.key});

  @override
  State<AllergySelectorWidget> createState() => _AllergySelectorWidgetState();
}

class _AllergySelectorWidgetState extends State<AllergySelectorWidget> {
  @override
  Widget build(BuildContext context) {
    // give user list of allergies and let them select using checkboxes
    return ListView(
      shrinkWrap: true,
      children: [
        CheckboxListTile(
          title: const Text('Peanuts'),
          value: false,
          onChanged: (bool? value) {},
        ),
        CheckboxListTile(
          title: const Text('Gluten'),
          value: false,
          onChanged: (bool? value) {},
        ),
        CheckboxListTile(
          title: const Text('Dairy'),
          value: false,
          onChanged: (bool? value) {},
        ),
        CheckboxListTile(
          title: const Text('Soy'),
          value: false,
          onChanged: (bool? value) {},
        ),
        CheckboxListTile(
          title: const Text('Shellfish'),
          value: false,
          onChanged: (bool? value) {},
        ),
        CheckboxListTile(
          title: const Text('Eggs'),
          value: false,
          onChanged: (bool? value) {},
        ),
        CheckboxListTile(
          title: const Text('Fish'),
          value: false,
          onChanged: (bool? value) {},
        ),
        CheckboxListTile(
          title: const Text('Tree Nuts'),
          value: false,
          onChanged: (bool? value) {},
        ),
        CheckboxListTile(
          title: const Text('Wheat'),
          value: false,
          onChanged: (bool? value) {},
        ),
        CheckboxListTile(
          title: const Text('Sesame'),
          value: false,
          onChanged: (bool? value) {},
        ),
        CheckboxListTile(
          title: const Text('Sulfites'),
          value: false,
          onChanged: (bool? value) {},
        ),
        CheckboxListTile(
          title: const Text('Celery'),
          value: false,
          onChanged: (bool? value) {},
        ),
        CheckboxListTile(
          title: const Text('Mustard'),
          value: false,
          onChanged: (bool? value) {},
        ),
        CheckboxListTile(
          title: const Text('Lupin'),
          value: false,
          onChanged: (bool? value) {},
        ),
        CheckboxListTile(
          title: const Text('Molluscs'),
          value: false,
          onChanged: (bool? value) {},
        ),
      ],
    );
  }
}
