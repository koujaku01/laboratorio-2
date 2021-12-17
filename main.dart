import 'package:flutter/material.dart';

void main() => runApp(MyConvert());

class MyConvert extends StatefulWidget {
  const MyConvert({Key? key}) : super(key: key);

  @override
  _MyConvertState createState() => _MyConvertState();
}

class _MyConvertState extends State<MyConvert> {
  double? _numberFrom;

  @override
  void initState() {
    _numberFrom = 0;
    super.initState();
  }

  final List<String> _measures = [
    'Metros',
    'Kilometros',
    'Gramos',
    'Kilogramos',
    'Pies',
    'Millas',
    'Libras (lbs)',
    'Onzas',
  ];

  final Map<String, int> _measuresMap = {
    'Metros': 0,
    'Kilometros': 1,
    'Gramos': 2,
    'Kilogramos': 3,
    'Pies': 4,
    'Millas': 5,
    'Libras (lbs)': 6,
    'Onzas': 7,
  };

  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };

  void convert(double value, String from, String to) {
    int? nFrom = _measuresMap[from];
    int? nTo = _measuresMap[to];
    var multiplier = _formulas[nFrom.toString()][nTo];
    double result = value * multiplier;
    if (result == 0) {
      _resultMessage = 'This conversion cannot be performed';
    } else {
      _resultMessage =
          '${_numberFrom.toString()} $_startMeasure are ${result.toString()} $_convertedMeasure';
    }
    setState(() {
      _resultMessage = _resultMessage;
    });
  }
  

  
  
  String? _resultMessage;
  String? _startMeasure;
  String? _convertedMeasure;

  final TextStyle inputStyle = TextStyle(
    fontSize: 20,
    color: Colors.red[900],
  );

  final TextStyle labelStyle = TextStyle(
    fontSize: 24,
    color: Colors.green[700],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Convertidor de Medidas' ,
      home: Scaffold(                                                   
        appBar: AppBar  (
          title: Text ('Convertidor de Medidas'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Spacer(),
              Text(
                'Valor',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 30,
                  color: Colors.red,

                ),
                
              ),
              Spacer(),
              TextField(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                  color: Colors.black,

                ),
                decoration: InputDecoration(
                  hintText: "Inserte la medida que desea convertir",
                ),
                onChanged: (text) {
                  var rv = double.tryParse(text);
                  if (rv != null) {
                    setState(() {
                      _numberFrom = rv;
                    });
                  }
                },
              ),
              Spacer(),
              Text(
                'From',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 30,
                  color: Colors.grey,

                ),
              ),
              DropdownButton(
                isExpanded: true,
                style: inputStyle,
                items: _measures.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _startMeasure = value as String?;
                  });
                },
                value: _startMeasure,
              ),
              Spacer(),
              Text(
                'To',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 30,
                  color: Colors.blue,

                ),
              ),
              Spacer(),
              DropdownButton(
                isExpanded: true,
                style: inputStyle,
                items: _measures.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: inputStyle,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _convertedMeasure = value as String?;
                  });
                },
                value: _convertedMeasure,
              ),
              Spacer(
                flex: 2,
              ),
              ElevatedButton(
                child: Text(
                  'Convertir',
                  style: inputStyle,
                ),
                onPressed: () {
                  if (_startMeasure!.isEmpty ||
                      _convertedMeasure!.isEmpty ||
                      _numberFrom == 0) {
                    return;
                  } else {
                    convert(_numberFrom!, _startMeasure!, _convertedMeasure!);
                  }
                },
              ),
              Spacer(
                flex: 2,
              ),
              Text(
                _resultMessage == null ? '' : _resultMessage.toString(),
                style: labelStyle,
              ),
              Spacer(
                flex: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}