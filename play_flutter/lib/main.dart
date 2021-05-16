import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              RandomDogCard(),
              SizedBox(height: 20.0),
              RandomDogCard(),
              SizedBox(height: 20.0),
              RandomDogCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class RandomDogCard extends StatefulWidget {
  RandomDogCard({Key? key}) : super(key: key);

  @override
  RandomDogCardState createState() => RandomDogCardState();
}

class RandomDogCardState extends State<RandomDogCard> {
  TextEditingController controller = TextEditingController();
  bool isEditing = false;
  String dogUrl = "";

  @override
  initState() {
    super.initState();
    http
        .get(Uri.parse('https://dog.ceo/api/breeds/image/random'))
        .then((http.Response response) {
      setState(() {
        dogUrl = jsonDecode(response.body)["message"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          dogUrl.isEmpty
              ? Text("Loading Image")
              : GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsPage(imageUrl: dogUrl)),
                    );
                  },
                  child: Image(
                    image: NetworkImage(dogUrl),
                  )),
          SizedBox(height: 10.0),
          !isEditing
              ? Text(
                  controller.text.isEmpty ? "Add Comment" : controller.text,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                  ),
                )
              : TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: controller.text.isEmpty
                        ? 'Add comment'
                        : 'Update comment',
                  ),
                ),
          TextButton(
            onPressed: () {
              setState(() => isEditing = !isEditing);
            },
            child: Text(isEditing ? "Save Comment" : "Edit Comment"),
          ),
        ],
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final String imageUrl;

  const DetailsPage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      minimum: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Back"),
          ),
          Text("Welcome to the details page"),
          Image(
            image: NetworkImage(imageUrl),
          ),
          Text(
              "Lorem ipsum stuff Lorem ipsum stuffLorem ipsum stuffLorem ipsum stuffLorem ipsum stuffLorem ipsum stuffLorem ipsum stuffLorem ipsum stuffLorem ipsum stuffLorem ipsum stuffLorem ipsum stuff"),
        ],
      ),
    ));
  }
}
