import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf_editor/core/app_const.dart';
import 'package:pdf_editor/core/app_route.dart';
import 'package:pdf_editor/model/reserve.dart';

class ShowImagePage extends StatefulWidget {
  const ShowImagePage({super.key});

  @override
  State<ShowImagePage> createState() => _ShowImagePageState();
}

class _ShowImagePageState extends State<ShowImagePage> {
  @override
  Widget build(BuildContext context) {
    final List<Reserve> list = (ModalRoute.of(context)!.settings.arguments
        as Map)['list'] as List<Reserve>;
    final File file =
        (ModalRoute.of(context)!.settings.arguments as Map)['pdf'] as File;
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoute.choosePdfFile,
                arguments: file);
          },
        )),
        body: list.isNotEmpty
            ? ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return element(list[index]);
                })
            : Center(
                child: Text(
                  "empty list",
                  style: TextStyle(fontSize: 25),
                ),
              ));
  }

  Widget element(Reserve element) {
    return Container(
      child: Column(children: [
        Center(
          child: Text("reserve ${element.number}"),
        ),
        Image.memory(
          element.image,
          width: AppConst.getWidth(context),
          height: AppConst.getHeight(context) * 0.4,
          fit: BoxFit.cover,
          scale: 1,
        ),
        Text(element.description)
      ]),
    );
  }
}
