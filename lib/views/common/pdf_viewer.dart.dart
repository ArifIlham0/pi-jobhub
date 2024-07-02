import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:jobhub/views/common/exports.dart';

class PDFViewerPage extends StatelessWidget {
  final String url;

  PDFViewerPage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ReusableText(
          text: "CV Kamu",
          style: appstyle(
            16,
            Color(kDark.value),
            FontWeight.bold,
          ),
        ),
      ),
      body: PDFView(
        filePath: url,
      ),
    );
  }
}
