import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreviewDoc extends StatefulWidget {
  PreviewDoc({Key key, this.linkToDoc}) : super(key: key);
  final String linkToDoc;
  @override
  _PreviewDocState createState() => _PreviewDocState();
}

class _PreviewDocState extends State<PreviewDoc> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.all(0),
      buttonPadding: EdgeInsets.all(0),
      content: Container(
        height: Get.height / 2,
        width: Get.width * .9,
        child: FutureBuilder<PDFDocument>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return PDFViewer(document: snapshot.data);
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return Container();
          },
          future: PDFDocument.fromURL(widget.linkToDoc),
        ),
      ),
      actions: [
        TextButton(onPressed: () {}, child: Text('Partager')),
        TextButton(onPressed: () {}, child: Text('Telecharger')),
      ],
    );
  }
}
