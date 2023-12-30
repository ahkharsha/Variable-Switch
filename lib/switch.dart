import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CustomSwitchScreen extends StatefulWidget {
  @override
  _CustomSwitchScreenState createState() => _CustomSwitchScreenState();
}

class _CustomSwitchScreenState extends State<CustomSwitchScreen> {
  bool _value = false;
  int _size = 50;
  Color _activeColor = Colors.green;
  Color _inactiveColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vairable Switch'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _value = !_value;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: _size * 2.0,
              height: _size * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_size * 0.8),
                color: _value ? _activeColor : _inactiveColor,
              ),
              child: Padding(
                padding: EdgeInsets.all(_size * 0.1),
                child: Align(
                  alignment:
                      _value ? Alignment.centerRight : Alignment.centerLeft,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: _size * 0.4,
                    height: _size * 0.4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Active Color:'),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  _pickColor(true);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _activeColor,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              Text('Inactive Color:'),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  _pickColor(false);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _inactiveColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Size:'),
              SizedBox(width: 10),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        _size -= 5;
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      _showSizeDialog();
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        children: [
                          Text('$_size'),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _size += 5;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _pickColor(bool isActiveColor) {
    Color currentColor = isActiveColor ? _activeColor : _inactiveColor;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text(isActiveColor ? 'Pick Active Color' : 'Pick Inactive Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (Color color) {
                setState(() {
                  if (isActiveColor) {
                    _activeColor = color;
                  } else {
                    _inactiveColor = color;
                  }
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSizeDialog() async {
    int newSize = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Size'),
          content: TextFormField(
            keyboardType: TextInputType.number,
            initialValue: _size.toString(),
            decoration: InputDecoration(labelText: 'Size'),
            onChanged: (value) {
              setState(() {
                _size = int.tryParse(value) ?? _size;
              });
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.of(context).pop(_size);
              },
            ),
          ],
        );
      },
    );
    setState(() {
      _size = newSize;
    });
  }
}
