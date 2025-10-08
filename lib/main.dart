import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LengthConverter(),
    );
  }
}

class LengthConverter extends StatefulWidget {
  const LengthConverter({super.key});

  @override
  _LengthConverterState createState() => _LengthConverterState();
}

class _LengthConverterState extends State<LengthConverter> {
  final TextEditingController inputController = TextEditingController(text: "0");

  String fromUnit = 'cm';
  String toUnit = 'inch';
  double result = 0.0;

  final List<String> units = ['cm', 'inch', 'meter', 'foot'];

  final Map<String, double> conversionToMeter = {
    'cm': 0.01,
    'inch': 0.0254,
    'meter': 1.0,
    'foot': 0.3048,
  };

  void convert() {
    double inputValue = double.tryParse(inputController.text) ?? 0;

    double valueInMeters = inputValue * (conversionToMeter[fromUnit] ?? 1);
    double convertedValue = valueInMeters / (conversionToMeter[toUnit] ?? 1);

    setState(() {
      result = convertedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      body: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Length Converter',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),

                TextField(
                  controller: inputController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<String>(
                      value: fromUnit,
                      items: units
                          .map((unit) => DropdownMenuItem(
                                value: unit,
                                child: Text(unit),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          fromUnit = value!;
                        });
                      },
                    ),
                    const SizedBox(width: 20),
                    DropdownButton<String>(
                      value: toUnit,
                      items: units
                          .map((unit) => DropdownMenuItem(
                                value: unit,
                                child: Text(unit),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          toUnit = value!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Text(
                  result.toStringAsFixed(4),
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 12),

                ElevatedButton(
                  onPressed: convert,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: const Text(
                    'Convert',
                    style: TextStyle(fontSize: 16, color: Colors.white),
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
