import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert'; // For jsonEncode and jsonDecode
import 'package:google_generative_ai/google_generative_ai.dart';

class chatpage extends StatefulWidget {
  chatpage({super.key});

  @override
  State<chatpage> createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  void send(String x1) async {
    final apiKey = "";

    try {
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);

      // Pass the user's input (x1) to the API
      final content = [Content.text(x1)];
      final response = await model.generateContent(content);

      setState(() {
        x += response
            .text!; // Ensure response.text is correct based on your API's structure
      });
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  String x = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 12, 0, 175),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 100,
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(30),
                  child: ClipOval(
                    child: Image.asset(
                      "AssetImages/profile.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "Ask John Davis",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  width: double.infinity,
                  height: 300,
                  color: Color.fromARGB(255, 0, 0, 0),
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      // This makes the text scrollable within the container
                      child: Text(
                        x,
                        style: TextStyle(
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: TextField(
                    onChanged: (val) {
                      x = val;
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () => send(x),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
