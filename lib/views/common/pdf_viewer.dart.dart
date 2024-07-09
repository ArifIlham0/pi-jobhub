import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:jobhub/views/common/exports.dart';

class PDFViewerPage extends StatelessWidget {
  final String url;

  PDFViewerPage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kBlack2.value),
      appBar: AppBar(
        backgroundColor: Color(kBlack2.value),
        centerTitle: true,
        leading: IconButton(
          color: Color(kWhite.value),
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: PDFView(
        filePath: url,
      ),
    );
  }
}
