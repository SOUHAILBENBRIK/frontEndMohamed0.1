/*import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf_editor/core/app_const.dart';
import 'package:pdf_editor/core/app_route.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ShowPdfFilePage2 extends StatefulWidget {
  const ShowPdfFilePage2({super.key});

  @override
  State<ShowPdfFilePage2> createState() => _ShowPdfFilePage2State();
}

class _ShowPdfFilePage2State extends State<ShowPdfFilePage2> {
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  bool hasChange = false;
  double dx = 0;
  double dy = 0;
  Uint8List? bytes;

  final GlobalKey globalKey = GlobalKey();
  void addText(
      {required double dx,
      required double dy,
      required File file,
      int index = 0}) async {
    //Load the existing PDF document.
    final PdfDocument document =
        PdfDocument(inputBytes: file.readAsBytesSync());
//Get the existing PDF page.
    final PdfPage page = document.pages[0];
//Draw text in the PDF page.
    print("dx : $dx , DY : $dy");
    print("height : ${page.size.height} && width : ${page.size.width}");

    page.graphics.drawString(
        '$index', PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfSolidBrush(PdfColor(0, 0, 255)),
        bounds: Rect.fromLTWH(600, 200, 150, 100));
//Save the document.
    file.writeAsBytes(await document.save());
    Navigator.pushReplacementNamed(context, AppRoute.choosePdfFile2,
        arguments: file);
//Dispose the document.
    document.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final File file = ModalRoute.of(context)!.settings.arguments as File;

    return Scaffold(
      body: pdfMethod(file),
    );
  }

  Widget pdfMethod(File file) {
    return SfPdfViewer.file(
      file,
      controller: _pdfViewerController,
      onTap: (pdf) {
        setState(() {
          dx = pdf.pagePosition.dx+_pdfViewerController.scrollOffset.dx;
          dy = pdf.pagePosition.dy+_pdfViewerController.scrollOffset.dy;
        });
        addText(dx: dy, dy: dx, file: file, index: 1);
      },
      scrollDirection: PdfScrollDirection.horizontal,
      canShowScrollHead: true,
      canShowScrollStatus: true,
      enableDoubleTapZooming: false,
      maxZoomLevel: 2,
      initialZoomLevel: 2,
      onZoomLevelChanged: (details) {
        setState(() {
          if (hasChange && details.newZoomLevel != 2) {
            _pdfViewerController.zoomLevel = 2;
          }
        });
      },
    );
  }
}
*/