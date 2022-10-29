import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:marketplace/utils/colors.dart';

class PickedImages extends StatefulWidget {
  final double height;

  final String? initialvalue;
  final String? Function(String? value)? validator;

  const PickedImages({this.height = 250, this.validator, this.initialvalue});
  @override
  _PickedImagesState createState() => _PickedImagesState();
}

class _PickedImagesState extends State<PickedImages> {
  late String pathimage;
  File? file;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: widget.initialvalue,
      validator: widget.validator,
      builder: (FormFieldState<String> state) {
        return Column(
          children: [
            InkWell(
                onTap: () async {
                  const List<String> format = ['jpg', 'jpeg', 'png'];
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(
                          allowedExtensions: format,
                          type: FileType.custom,
                          allowMultiple: false);

                  if (result != null) {
                    setState(() {
                      file = File(result.files.single.path!);
                      pathimage = file!.path;
                      state.didChange(pathimage);
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('imagen invalida')),
                    );
                  }
                },
                child: Container(
                    child: file == null
                        ? Container(
                            alignment: Alignment.center,
                            height: widget.height,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(color: grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text('subir una imagen del producto'),
                          )
                        : Container(
                            height: widget.height,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(color: grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.file(file!)))),
            SizedBox(height: 10),
            state.hasError
                ? Text(
                    state.errorText!,
                    style: TextStyle(color: Colors.red),
                  )
                : Container()
          ],
        );
      },
    );
  }
}
