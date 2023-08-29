import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:pdf_editor/core/app_const.dart';
import 'package:pdf_editor/core/app_route.dart';
import 'package:pdf_editor/model/reserve.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ShowPdfFilePage extends StatefulWidget {
  const ShowPdfFilePage({super.key});

  @override
  State<ShowPdfFilePage> createState() => _ShowPdfFilePageState();
}

class _ShowPdfFilePageState extends State<ShowPdfFilePage> {
  late PdfViewerController _pdfViewerController;
  late TextEditingController numberController;
  late TextEditingController descriptionController;

  final GlobalKey globalKey00 = GlobalKey();
  List<Reserve> list = [];

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    numberController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    numberController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  bool hasChange = false;
  double dx = 0;
  double dy = 0;
  Uint8List? bytes;

  Future<Uint8List?> convertToImage(GlobalKey key) async {
    final boundary =
        key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    final image = await boundary?.toImage(pixelRatio: 10);
    final byteData = await image?.toByteData(format: ui.ImageByteFormat.png);
    final imageBytes = byteData?.buffer.asUint8List();

    if (imageBytes != null) {
      return imageBytes;
    }
    return null;
  }

  Future<void> _showAlertDialog(double dx, double dy, File file) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: AppConst.getHeight(context) * 0.5,
            width: AppConst.getWidth(context) * 0.9,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                inputWidget(
                    controller: numberController,
                    text: "number",
                    type: TextInputType.number),
                SizedBox(
                  height: 10,
                ),
                inputWidget(
                    controller: descriptionController,
                    text: "description",
                    type: TextInputType.text),
                Spacer(),
                ElevatedButton(
                    onPressed: () async {
                      list.add(Reserve(
                          description: descriptionController.text,
                          number: numberController.text,
                          image: (await convertToImage(globalKey00))!));
                      descriptionController.clear();
                      numberController.clear();
                      //bytes=Uint8List.fromList([]);

                      setState(() {
                        hasChange = false;
                      });
                      Navigator.pop(context);
                    },
                    child: Text("add")),
              ],
            ),
          ),
        );
      },
    );
  }
// --- Button Widget --- //

  /*void addText(
      {required double dx,
      required double dy,
      required File file,
      int index = 0}) async {
    //Load the existing PDF document.
    final PdfDocument document =
        PdfDocument(inputBytes: file.readAsBytesSync());
    final PdfPage page = document.pages[0];
    page.graphics
      ..rotateTransform(-90)
      ..drawString('$index', PdfStandardFont(PdfFontFamily.helvetica, 12),
          brush: PdfSolidBrush(PdfColor(255, 0, 0)),
          bounds: Rect.fromPoints(Offset(dx, dy), Offset(dx + 30, dy + 30)));
    file.writeAsBytes(await document.save());
    Navigator.pushReplacementNamed(context, AppRoute.choosePdfFile,
        arguments: file);
//Dispose the document.
    document.dispose();
  }*/
  /*void saveImagePdf(File file) async {
    final pdf = pw.Document();
    final Uint8List imageBytes = (await convertToImage(globalKey00))!;
    final pdfImage = pw.MemoryImage(imageBytes);
    //final exisitingPdf = pw.MemoryImage(await file.readAsBytes());
    

     /*pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(exisitingPdf),
          );
        },
      ),
    );*/
    // Add image to PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(pdfImage),
          );
        },
      ),
    );
    final output = await pdf.save();
    setState(() {
      file.writeAsBytes(output);
    });
  }*/
  Widget inputWidget(
      {required TextEditingController controller,
      required String text,
      required TextInputType type}) {
    return SizedBox(
      width: AppConst.getWidth(context) * 0.7,
      child: TextField(
        onChanged: (val) {
          setState(() {});
        },
        keyboardType: type,
        controller: controller,
        decoration: InputDecoration(
            labelText: text,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final File file = ModalRoute.of(context)!.settings.arguments as File;

    return Scaffold(
        body: Stack(
      children: [
        RepaintBoundary(
          key: globalKey00,
          child: Stack(
            children: [
              SfPdfViewerTheme(
                data: SfPdfViewerThemeData(
                  backgroundColor: Colors.white,
                ),
                child: SfPdfViewer.file(
                  file,
                  onTap: (pdf) {
                    setState(() {
                      dx = pdf.position.dx;
                      dy = pdf.position.dy;
                    });
                    setState(() {
                      hasChange = true;
                    });
                    _showAlertDialog(dx, dy, file);
                  },
                  controller: _pdfViewerController,
                  scrollDirection: PdfScrollDirection.horizontal,
                  //canShowScrollHead: true,
                  //canShowScrollStatus: true,
                  //enableDoubleTapZooming: false,
                  //maxZoomLevel: 2,
                  initialZoomLevel: 3,
                  onZoomLevelChanged: (details) {
                    setState(() {
                      if (hasChange && details.newZoomLevel != 3) {
                        _pdfViewerController.zoomLevel = 3;
                      }
                    });
                  },
                ),
              ),
              Visibility(
                  visible: hasChange,
                  child: Positioned(
                    top: dy,
                    left: dx,
                    child: numberIcon(numberController.text),
                  )),
              Visibility(
                visible: !hasChange,
                child: Positioned(
                  top: 30,
                  left: AppConst.getWidth(context) * 0.8,
                  child: IconButton(
                      color: Colors.purple,
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, AppRoute.showImage,
                            arguments: {"list": list, "pdf": file});
                      },
                      icon: Icon(
                        Icons.list,
                      )),
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}

Widget numberIcon(String index) {
  return Container(
    height: 20,
    width: 20,
    decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(100))),
    child: Center(
      child: Text(
        index,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
