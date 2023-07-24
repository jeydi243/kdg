import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/services/car_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewerPDF extends StatefulWidget {
  ViewerPDF({this.link, Key? key}) : super(key: key);
  final String? link;
  @override
  State<ViewerPDF> createState() => _ViewerPDFState();
}

class _ViewerPDFState extends State<ViewerPDF> {
  CarService carservice = Get.find();
  late PdfViewerController _controller;
  @override
  void initState() {
    _controller = PdfViewerController();
    _controller.addListener(({property}) {
      print("$property");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        // extendBody: true,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Share.share(widget.link ?? "e");
            },
            child: Icon(Icons.share)),
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: SfPdfViewer.network(
            widget.link ??
                'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
            canShowScrollStatus: true,
            currentSearchTextHighlightColor: Color.fromARGB(255, 252, 248, 249),
            onDocumentLoaded: (detailsLoaded) {
              carservice.stopLoading();
            },
            onDocumentLoadFailed: (details) {
              carservice.onLoadFailed(details.description);
            },
            controller: _controller,
            canShowPasswordDialog: true,
            enableDoubleTapZooming: true,
          ),
        ));
  }
}
