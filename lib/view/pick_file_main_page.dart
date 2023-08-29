import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:pdf_editor/core/app_const.dart';
import 'package:pdf_editor/core/app_route.dart';
import 'package:screenshot/screenshot.dart';

class PickFilePage extends StatelessWidget {
  const PickFilePage({super.key});



  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      body: pdfMethod(context),
    );
  }

  SizedBox pdfMethod(BuildContext context) {
    return SizedBox(
      height: AppConst.getHeight(context),
      width: AppConst.getWidth(context),
      child: Center(
        child: ElevatedButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  dialogTitle: 'Please select pdf file:',
                  allowedExtensions: ['pdf']);

              if (result != null) {
                File file = File(result.files.single.path!);
                /*await for (var page
                    in Printing.raster(await file.readAsBytes())) {
                  final Uint8List image = await page.toPng();*/

                Navigator.pushNamed(context, AppRoute.choosePdfFile,
                    arguments: file);
                /*break;
                }*/
              } else {
                print("error");
              }
            },
            child: Text("Pick File")),
      ),
    );
  }

  void openFile(String file) {
    //OpenFile.open(file);
  }
}
