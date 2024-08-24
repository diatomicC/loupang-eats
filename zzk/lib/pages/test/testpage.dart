import 'package:flutter/material.dart';
import 'package:zzk/logic/allergyGenerator.dart';

import '../../classes/FoodSectionClass.dart';

class TestPage extends StatefulWidget {
  final Menu menu;

  TestPage({required this.menu});
  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Page'),
      ),
      body: ChatGptFutureWidget(
        apiUrl: 'https://api.openai.com/v1/chat/completions',
        apiKey: 'sk-proj-4ZrRXzz155k9-CrCsad9suLaMpeHLF-5scZpKUtUFc9mpwAPDJ0lyMTf1rT3Bl' +
            'bkFJ7AM3B6AfFupbvDjxLTf8LAqs1cEyrLsoCoTvE_8XuQiyobCf4yL3c3bn4A',
        menu: widget.menu,
      ),
    );
  }
}
