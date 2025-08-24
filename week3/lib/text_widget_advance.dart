import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: TextWidgetAdvance(),
    ),
  );
}

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: '${json['name']['first']} ${json['name']['last']}',
      email: json['email'],
    );
  }
}

Future<User> fetchUser() async {
  final response = await http.get(Uri.parse("https://randomuser.me/api/"));
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final List<dynamic> results = json['results'];
    return User.fromJson(results[0] as Map<String, dynamic>);
  } else {
    throw Exception("Failed to load user");
  }
}

class TextWidgetAdvance extends StatefulWidget {
  const TextWidgetAdvance({super.key});

  @override
  State<TextWidgetAdvance> createState() => _AdvanceTextExample();
}

class _AdvanceTextExample extends State<TextWidgetAdvance> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Info"),
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
      ),
      body: Center(
        child: FutureBuilder<User>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              debugPrint(snapshot.error.toString());
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Name: ${snapshot.data!.name}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Email: ${snapshot.data!.email}",
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }
            return const Text('No user data.');
          },
        ),
      ),
    );
  }
}
