import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = TextEditingController();
  final List<bool> _selection = [true, false, false];
  void updateSelection(int selectedIndex) {
    setState(() {
      for (int i = 0; i < _selection.length; i++) {
        _selection[i] = selectedIndex == i;
      }
    });
  }

  double? tip;

  void calculateTip() {
    final totalAmount = double.parse(controller.text);

    final tipSelection = _selection.indexWhere((element) => element);

    final tipPercentage = [.1, .15, .20][tipSelection];

    setState(() {
      tip = (totalAmount * tipPercentage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (tip != null)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "$tip",
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              const Text("Total amount"),
              SizedBox(
                width: 70,
                child: TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: controller,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: "\$100.00",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: ToggleButtons(
                  isSelected: _selection,
                  onPressed: updateSelection,
                  children: const [
                    Text("10%"),
                    Text("15%"),
                    Text("20%"),
                  ],
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  primary: Colors.white,
                ),
                onPressed: calculateTip,
                child: const Text("Calculate Tip"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
