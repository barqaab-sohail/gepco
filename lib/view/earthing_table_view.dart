import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';

class EarthingTableView extends StatefulWidget {
  const EarthingTableView({super.key});

  @override
  State<EarthingTableView> createState() => _EarthingTableViewState();
}

class _EarthingTableViewState extends State<EarthingTableView> {
  final TextEditingController textEditingController = TextEditingController();
  File? _image;
  final _picker = ImagePicker();

  Position? _position;

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _position = position;
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  // Implementing the image picker
  pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {});
    }
  }

  Future uploadImage() async {
    try {
      var request = http.MultipartRequest("POST",
          Uri.parse("http://localhost/gepco_app/public/api/gepco/save"));
      var pic = await http.MultipartFile.fromPath('image', _image!.path);
      request.files.add(pic);

      var response = await request.send();

      print(await response.stream.bytesToString());
    } catch (e) {
      print('Error details: ${e.toString()}');
    }
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _position != null
                    ? Text('Current Location: ' + _position.toString())
                    : Text('No Location Data'),
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
                    //Uint8List bytes = await _image!.readAsBytes();
                    //print(bytes);
                    _getCurrentLocation();
                    //uploadImage();
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
