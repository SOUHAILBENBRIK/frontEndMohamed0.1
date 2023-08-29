import 'package:flutter/material.dart';
import 'package:pdf_editor/view/pick_file_main_page.dart';
import 'package:pdf_editor/view/show_image_page.dart';

import '../view/show_pdf_file_page.dart';
import '../view/show_pdf_file_page2.dart';

class AppRoute {
  static String pickFileMainPage = "/mainPage";
  static String choosePdfFile = "/choosePdfFile";
  static String choosePdfFile2 = "/choosePdfFile2";
  static String showImage = "/showImagePage";

  static final Map<String, Widget Function(BuildContext context)> appRoute = {
    pickFileMainPage: (context) => const PickFilePage(),
    choosePdfFile: (context) => ShowPdfFilePage(),
    //choosePdfFile2: (context) => ShowPdfFilePage2(),
    showImage: (context) => ShowImagePage(),

  };
}
