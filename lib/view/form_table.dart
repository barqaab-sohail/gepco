import 'package:flutter/material.dart';
import 'dart:io';

class FormTable extends StatefulWidget {
  const FormTable({super.key});

  @override
  State<FormTable> createState() => _FormTableState();
}

class _FormTableState extends State<FormTable> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        width: 2.0,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(5),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text('GEPCO Data Upload Form',
            style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: textEditingController,
                style: const TextStyle(),
                decoration: InputDecoration(label: Text('Name of Feeder')),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: textEditingController,
                style: const TextStyle(),
                decoration: InputDecoration(label: Text('GPS Locations')),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                decoration: const InputDecoration(label: Text('Type')),
                items: <String>['', 'HT', 'LT'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  print(value);
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: textEditingController,
                style: const TextStyle(),
                decoration:
                    InputDecoration(label: Text('Steel Structure with Tag No')),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: textEditingController,
                style: const TextStyle(),
                decoration:
                    InputDecoration(label: Text('Round Steel with Tag No')),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: textEditingController,
                style: const TextStyle(),
                decoration: InputDecoration(label: Text('Material Used')),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: textEditingController,
                style: const TextStyle(),
                decoration: InputDecoration(label: Text('Earth Value Before')),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: textEditingController,
                style: const TextStyle(),
                decoration: InputDecoration(label: Text('Earth Value After')),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => {print('button pressed')},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text('Convert'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
