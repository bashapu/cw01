import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter - Counter and Image Toggle'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final String _imageUrl_1 = 'https://i.natgeofe.com/n/49f1c59b-095d-47a6-b72c-92bc6740a37c/tpc18-outdoor-gallery-1693450-12040196_03_square.jpg';
  final String _imageUrl_2 = 'https://i.natgeofe.com/n/8a4cd21e-3906-4c9d-8838-b13ef85f4b6e/tpc18-outdoor-gallery-1002418-12000351_01_square.jpg';
  bool _imageFlag = true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggleImage() {
    setState(() {
      _imageFlag = !_imageFlag;
    });
  }

  void _resetApp() {
    setState(() {
      _counter = 0;
      _imageFlag = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: Text('Increment')
            ),
            Padding(padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center (
                    child: Image.network(
                      _imageFlag ? _imageUrl_1 : _imageUrl_2,
                      height: 200,
                      width: 200,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _toggleImage,
                      child: Text('Toggle Image'),
                    ),
                    ElevatedButton(
                      onPressed: _resetApp,
                      child: Text('Reset'),
                    ),
                  ],
                ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
