import 'package:flutter/material.dart';
import 'package:zzk/classes/FoodSectionClass.dart';
import 'package:zzk/importantVariables.dart';
import 'package:zzk/logic/allergyGenerator.dart';
import 'package:zzk/logic/csvReader.dart';

class UploaderZonePage extends StatefulWidget {
  const UploaderZonePage({super.key});

  @override
  State<UploaderZonePage> createState() => _UploaderZonePageState();
}

class _UploaderZonePageState extends State<UploaderZonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uploader Zone'),
      ),
      body: Column(
        children: [
          // show list of restaurant ids (totalId)
          totalId.isEmpty
              ? const Text('No restaurant ids')
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: totalId.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(totalId[index]),
                      trailing: TextButton(
                        onPressed: () async {
                          Menu menu2 = await read(restaurantId: totalId[index]);
                          await read(restaurantId: totalId[index]);
                          // run allergy generator
                          Object result = await fetchChatGptResponseAsJSON(
                            'https://api.openai.com/v1/chat/completions',
                            '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',
                            menu2,
                          ).then((value) => {
                                print(value),
                              });
                        },
                        child: Text('run allergy generator'),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
