import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zzk/classes/FoodSectionClass.dart';

List messagesList({required String englishMenuListAsString}) {
  return [
    {
      "role": "system",
      "content": [
        {
          "text":
              "You are an expert in nutrition. You will be provided a list of foods, and your job is to mark the corresponding ingredient in a careful manner so that it can be used for people with allergies. Strictly follow the format given in the below example. Answer only with JSON without any explanations.\n\nAllergies mapped with numbers:\n1. Peanuts\n2. Tree nuts\n3. Milk (dairy)\n4. Eggs\n5. Fish\n6. Shellfish (shrimp, crab, lobster)\n7. Soy\n8. Wheat (gluten)\n9. Sesame\n10. Pork\n11. Beef\n12. Alcohol\n13. Gelatin\n14. Sulfites\n15. Corn\n\nExample Input:\nChocolate Ice Cream, Grilled Salmon with Fried Eggs\n\nExample Output:\n```\n{\n  \"Chocolate Ice Cream\": \"3\",\n  \"Grilled Salmon with Fried Eggs\": \"4,5,9\"\n}\n```\n\n\nJobs to do:",
          "type": "text"
        }
      ]
    },
    {
      "role": "user",
      "content": [
        {"text": englishMenuListAsString, "type": "text"}
      ]
    }
  ];
}

class ChatGptFutureWidget extends StatefulWidget {
  final String apiUrl;
  final String apiKey;
  final Menu menu;

  ChatGptFutureWidget({
    required this.apiUrl,
    required this.apiKey,
    required this.menu,
  });

  @override
  _ChatGptFutureWidgetState createState() => _ChatGptFutureWidgetState();
}

class _ChatGptFutureWidgetState extends State<ChatGptFutureWidget> {
  late Future<String> _responseFuture;

  @override
  void initState() {
    super.initState();
    _responseFuture = _fetchChatGptResponseAsString(widget.apiUrl, widget.apiKey, widget.menu);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _responseFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          /**
           * !parsed JSON
           */
          Object parsedJson = jsonDecode(snapshot.data?.replaceAll('```', '') ?? '{}');
          print(parsedJson);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SelectableText(
                jsonEncode(parsedJson),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          );
        } else {
          return Text('Unexpected error');
        }
      },
    );
  }
}

Future<String> _fetchChatGptResponseAsString(
  String apiUrl,
  String apiKey,
  Menu menu,
) async {
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${apiKey}',
    },
    body: jsonEncode({
      'model': 'gpt-4o-mini',
      "messages": messagesList(
        // filter only English items from the menu
        englishMenuListAsString: menu.sections
            .map((section) => section.items.where((item) => item.language == 'EN').map((item) => item.name).join(', '))
            .join(', '),
      ),
      'stream': false, // We're not using stream here
    }),
  );

  if (response.statusCode == 200) {
    // Decode the entire JSON response
    final decodedJson = jsonDecode(response.body);
    if (decodedJson['choices'] != null && decodedJson['choices'].isNotEmpty) {
      final content = decodedJson['choices'][0]['message']['content'];
      return content ?? 'No content';
    } else {
      return 'No valid response from the API';
    }
  } else {
    throw Exception('Failed to connect to the API');
  }
}

// call fetchChatGptResponseAsString function. This is just a parser
Future<Object> fetchChatGptResponseAsJSON(
  String apiUrl,
  String apiKey,
  Menu menu,
) async {
  // call the fetchChatGptResponseAsString function
  final response = await _fetchChatGptResponseAsString(apiUrl, apiKey, menu);
  // parse the response as JSON
  return jsonDecode(response);
}
