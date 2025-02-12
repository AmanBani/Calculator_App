import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _output = '0';
  String _input = '';
  double _num1 = 0;
  String _operand = '';

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _output = '0';
        _input = '';
        _num1 = 0;
        _operand = '';
      } else if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == 'x' ||
          buttonText == '/') {
        _num1 = double.parse(_output);
        _operand = buttonText;
        _input = '';
        _output = '0';
      } else if (buttonText == '=') {
        double num2 = double.parse(_output);
        switch (_operand) {
          case '+':
            _output = (_num1 + num2).toString();
            break;
          case '-':
            _output = (_num1 - num2).toString();
            break;
          case 'x':
            _output = (_num1 * num2).toString();
            break;
          case '/':
            _output = (_num1 / num2).toString();
            break;
        }
        _num1 = 0;
        _operand = '';
        _input = '';
      } else {
        _input += buttonText;
        _output = _input;
      }
    });
  }

  Widget _buildButton(String buttonText, Color textColor, Color buttonColor,
      {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                buttonColor, // ✅ FIXED: Changed "primary" to "backgroundColor"
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(24),
            elevation: 5,
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 24, color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Modern Calculator',
          style: TextStyle(
              color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          CustomTextField(text: _output),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.grey[900]!, Colors.grey[800]!],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton('C', Colors.black, Colors.redAccent),
                    _buildButton('+/-', Colors.black, Colors.orangeAccent),
                    _buildButton('%', Colors.black, Colors.orangeAccent),
                    _buildButton('/', Colors.black, Colors.orangeAccent),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildButton('7', Colors.white, Colors.grey[700]!),
                    _buildButton('8', Colors.white, Colors.grey[700]!),
                    _buildButton('9', Colors.white, Colors.grey[700]!),
                    _buildButton('x', Colors.black, Colors.orangeAccent),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildButton('4', Colors.white, Colors.grey[700]!),
                    _buildButton('5', Colors.white, Colors.grey[700]!),
                    _buildButton('6', Colors.white, Colors.grey[700]!),
                    _buildButton('-', Colors.black, Colors.orangeAccent),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildButton('1', Colors.white, Colors.grey[700]!),
                    _buildButton('2', Colors.white, Colors.grey[700]!),
                    _buildButton('3', Colors.white, Colors.grey[700]!),
                    _buildButton('+', Colors.black, Colors.orangeAccent),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildButton('0', Colors.white, Colors.grey[700]!,
                        flex: 2), // ✅ FIXED: "0" button spans 2 columns
                    _buildButton('.', Colors.white, Colors.grey[700]!),
                    _buildButton('=', Colors.black, Colors.greenAccent),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
