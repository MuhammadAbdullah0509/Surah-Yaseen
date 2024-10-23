import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../adds_integration/bannerads.dart';
import '../styles.dart';

class SurahPdf extends StatefulWidget {
  const SurahPdf({super.key});

  @override
  State<SurahPdf> createState() => _SurahPdfState();
}

class _SurahPdfState extends State<SurahPdf> {
  String? localFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localFile = "pdf/Surah-Yaseen-13Lines.pdf";
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return WillPopScope(
          onWillPop: () async {
            Get.back(result: 'refresh');
            return true;
          },
          child: Scaffold(
              appBar: AppBar(
                title: const Text("Surah Yaseen"),
                centerTitle: true,
                backgroundColor: Styles.appbar,
              ),
              body: Column(
                children: [
                  Expanded(child: PDFViewerFromAsset(pdfAssetPath: localFile.toString())),
                  const BannerAds(),
                ],
              )));
    });
  }
}

class PDFViewerFromAsset extends StatelessWidget {
  PDFViewerFromAsset({Key? key, required this.pdfAssetPath}) : super(key: key);
  final String pdfAssetPath;
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
      StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PDF(
        enableSwipe: true,
        autoSpacing: false,
        pageFling: true,
        fitPolicy: FitPolicy.WIDTH,
        onPageChanged: (int? current, int? total) =>
            _pageCountController.add('${current! + 1} - $total'),
        onViewCreated: (PDFViewController pdfViewController) async {
          _pdfViewController.complete(pdfViewController);
          final int currentPage = await pdfViewController.getCurrentPage() ?? 0;
          final int? pageCount = await pdfViewController.getPageCount();
          _pageCountController.add('${currentPage + 1} - $pageCount');
        },
      ).fromAsset(
        pdfAssetPath,
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
