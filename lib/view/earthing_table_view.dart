import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class EarthingTableView extends StatefulWidget {
  const EarthingTableView({super.key});

  @override
  State<EarthingTableView> createState() => _EarthingTableViewState();
}

class _EarthingTableViewState extends State<EarthingTableView> {
  final TextEditingController textEditingController = TextEditingController();
  File? _image;
  final _picker = ImagePicker();
  // Implementing the image picker
  pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {});
    }
  }

  Future uploadImage() async {
    var request = http.MultipartRequest("POST",
        Uri.parse("http://192.168.1.10/gepco_backend/public/api/gepco/save"));
    var pic = await http.MultipartFile.fromPath('image', _image!.path);
    request.files.add(pic);

    var response = await request.send();

    print(await response.stream.bytesToString());
  }

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
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  decoration: InputDecoration(
                      label: Text('Steel Structure with Tag No')),
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
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: _image == null
                      ? const Text('Please select an image')
                      : Image.file(_image!),
                ),
                FloatingActionButton(
                  onPressed: () {
                    pickImage();
                  },
                  child: const Icon(Icons.camera_alt),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    print('button pressed for uplaod');
                    Uint8List bytes = await _image!.readAsBytes();
                    //print(bytes);

                    uploadImage();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    // minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
