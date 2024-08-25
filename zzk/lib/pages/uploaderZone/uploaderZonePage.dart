import 'package:flutter/material.dart';

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
          // show image
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.grey,
            child: const Center(
              child: Text('Image'),
            ),
          ),
          // show uploader
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.grey,
            child: const Center(
              child: Text('Uploader'),
            ),
          ),
        ],
      ),
    );
  }
}
