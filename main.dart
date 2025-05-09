import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: FormPage());

  }
}

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController nameController = TextEditingController();


  // Smart URL detection for Web vs Emulator
  String getBaseUrl() {
    if (kIsWeb) {
      return "http://localhost:3000"; // for web/chrome
    } else {
      return "http://10.0.2.2:3000"; // for Android emulator
    }
  }


  void submitData() async {
    final url = Uri.parse("${getBaseUrl()}/submit");
    var response = await http.post(
      url, // Android emulator: use 10.0.2.2
      headers: {"Content-Type": "application/json"},
      body: '{"name": "${nameController.text}"}',
    );




    if (response.statusCode == 200) {
      print("Data sent successfully");
      nameController.clear();
    } else {
      print("Error: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Simple Form")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
            ElevatedButton(onPressed: submitData, child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
