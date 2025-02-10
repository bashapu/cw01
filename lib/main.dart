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

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  int _counter = 0;
  final String _imageUrl_1 = 'https://i.natgeofe.com/n/49f1c59b-095d-47a6-b72c-92bc6740a37c/tpc18-outdoor-gallery-1693450-12040196_03_square.jpg';
  final String _imageUrl_2 = 'https://i.natgeofe.com/n/8a4cd21e-3906-4c9d-8838-b13ef85f4b6e/tpc18-outdoor-gallery-1002418-12000351_01_square.jpg';
  bool _imageFlag = true;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggleImage() {
    setState(() {
      _imageFlag = !_imageFlag;
    });
    if (_controller.isCompleted || _controller.isDismissed) {
      _controller.forward(from: 0.0);
    }
  }

  void _resetApp() async {
    bool resetConfirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Reset"),
          content: Text("Are you sure you want to reset?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text("Reset"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    ) ?? false;

    if (resetConfirmed) {
      setState(() {
        _counter = 0;
        _imageFlag = true;
        _controller.reset();
        _controller.value = 1.0;
      });
    }
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
          crossAxisAlignment: CrossAxisAlignment.center,
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
            SizedBox(height: 40),
            FadeTransition(
              opacity: _animation,
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
                  child: Text('Reset',
                    style: TextStyle(
                      color: Colors.red
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}
