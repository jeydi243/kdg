import 'dart:developer';
import 'dart:io';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

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
      contentPadding: EdgeInsets.all(0),
      buttonPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                enableFeedback: true,
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                )),
          )
        ],
      ),
      content: Container(
        height: Get.height / 2,
        width: Get.width * .9,
        child: FutureBuilder<PDFDocument>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return PDFViewer(
                document: snapshot.data,
                panLimit: 5,
              );
            }
            return Container();
          },
          future: PDFDocument.fromURL(widget.linkToDoc),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () async {
              Share.share('check out my website https://example.com');
							
            },
            child: Text('Partager')),
        TextButton(
            onPressed: () async {
              log('${Directory.systemTemp}');
              // final taskId = await FlutterDownloader.enqueue(
              //   url: widget.linkToDoc,
              //   savedDir: '',
              //   showNotification: true,
              //   openFileFromNotification: true,
              // );
            },
            child: Text('Telecharger')),
      ],
    );
  }
}
