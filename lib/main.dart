import 'package:flutter/material.dart';
import 'result_arguments.dart';
void main() {
  runApp(BMIApp());
}

class BMIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator App',
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
        '/result': (context) => SecondPage(),
      },
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<FirstPage> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'BMI Calculator',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 50, color: Colors.white),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.pink,
            image: DecorationImage(image: AssetImage('assets/images/a.webp'),fit: BoxFit.cover,)),

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: heightController,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(color: Colors.yellowAccent),
                    decoration: InputDecoration(
                        labelText: 'Enter Height in (cm)',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white)),
                  ),
                  SizedBox(height: 40),
                  TextField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.yellowAccent),
                    decoration: InputDecoration(
                        labelText: 'Enter Weight in (kg)',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white)),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      double height = double.parse(heightController.text);
                      double weight = double.parse(weightController.text);

                      double bmi = weight / ((height / 100) * (height / 100));

                      Navigator.pushNamed(
                        context,
                        '/result',
                        arguments: ResultArguments(bmi),
                      );
                    },
                    child: Text(
                      'Calculate BMI',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ResultArguments args =
    ModalRoute.of(context).settings.arguments as ResultArguments;

    String bmiCategory = _getBMICategory(args.bmi);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI Results....',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/a.webp'),fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Your BMI is:',
                style: TextStyle(fontSize: 40, color: Colors.pink),
              ),
              Text(
                args.bmi.toStringAsFixed(2),
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink),
              ),
              SizedBox(height: 20),
              Text(
                'BMI Category:',
                style: TextStyle(fontSize: 24, color: Colors.pink),
              ),
              Text(
                bmiCategory,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink),
              ),
            ],
          ),
        ),
      ),
    );
  }



  String _getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Normal Weight';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }
}