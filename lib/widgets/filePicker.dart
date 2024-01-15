import 'dart:io';

import 'package:car_wash/widgets/cardButton.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerWidget extends StatefulWidget {
  const FilePickerWidget({super.key, required this.onFilePicked, required this.filesList});

  final Function(List<PlatformFile>) onFilePicked;
  final List<PlatformFile> filesList;
  @override
  _FilePickerWidget createState() => _FilePickerWidget();
}

class _FilePickerWidget extends State<FilePickerWidget> {
  List<PlatformFile> _paths = [];
  final bool _multiPick = true;

  @override
  void initState() {
    super.initState();
    _paths = widget.filesList;
  }

  void _pickFiles() async {
    try {
      FilePickerResult? filesResult = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: _multiPick,
        // allowedExtensions: FileType.image,
        // allowedExtensions: _extension?.split(',').map((e) => e.trim()).toList(),
      );
      _paths = _paths + filesResult!.files;
    } on Exception catch (e) {
      print(e);
    }
    if (!mounted) {
      return;
    }
    setState(() {});
    widget.onFilePicked(_paths);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Wrap(
          spacing: 22,
          runSpacing: 10,
          children: [
            // show images
            ..._paths.map((e) => cards(e.path)),
            cardButton(onPressed: () {
              _pickFiles();
            }),
          ],
        ));
  }

  Widget cards(path) {
    return SizedBox(
      width: 156,
      height: 135,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(File(path)),
                  fit: BoxFit.cover,
                ),
              ),
              child: IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _paths.removeWhere((element) => element.path == path);
                  });
                  // Add your delete functionality here
                },
              ))
          // Image.file(File(path!), width: 150, height: 125, fit: BoxFit.fill),
          ),
    );
  }
}
