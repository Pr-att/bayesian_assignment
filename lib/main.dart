import 'package:bayesian_assignment/provider/comments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AddComment>(
          create: (context) => AddComment(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bayesian Assignment',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Material(
              color: Colors.transparent,
              elevation: 5,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Add Comments',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                      Image.network(
                        'https://www.tuscaloosanews.com/gcdn/authoring/2016/09/08/NTTN/ghows-DA-1e4ed5e9-'
                        'e740-49ec-8c33-6ee1b427ea3d-00a10bf6.jpeg?width=660&height=510&fit=crop&format'
                        '=pjpg&auto=webp',
                        fit: BoxFit.contain,
                        width: 350,
                        height: 150,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                child: Consumer<AddComment>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      itemCount: value.kTask.length,
                      itemBuilder: (context, index) => value.kTask[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, String s) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(s),
      duration: const Duration(seconds: 3),
    ),
  );
}

class NewComment extends StatelessWidget {
  final String comment;
  const NewComment({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListTile(
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black26,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        leading: CircleAvatar(
          backgroundImage: Image.network(
            'https://www.google.com/s2/favicons?sz=64&domain_url=yahoo.com',
            fit: BoxFit.contain,
          ).image,
        ),
        title: Text(comment),
        trailing: const Icon(Icons.check),
      ),
    );
  }
}
