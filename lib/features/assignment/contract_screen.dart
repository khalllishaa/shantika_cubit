import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';

import '../../ui/dimension.dart';
import '../../ui/shared_widget/common_appbar.dart';
import '../../ui/shared_widget/custom_button.dart';
import '../../ui/typography.dart';

class ContractScreen extends StatefulWidget {
  final File? file;
  const ContractScreen({super.key, this.file});

  @override
  State<ContractScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen> {
  PDFViewController? controller;
  int pages = 0;
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    basename(widget.file!.path);
    return Scaffold(
      appBar: CommonAppbar(leading: true, title: "Kontrak Penugasan"),
      // AppBar(
      //   title: Text(name),
      //   actions: pages >= 2
      //       ? [
      //           Center(child: Text(text)),
      //           IconButton(
      //             icon: Icon(Icons.chevron_left, size: 32),
      //             onPressed: () {
      //               final page = indexPage == 0 ? pages : indexPage - 1;
      //               controller!.setPage(page);
      //             },
      //           ),
      //           IconButton(
      //             icon: Icon(Icons.chevron_right, size: 32),
      //             onPressed: () {
      //               final page = indexPage == pages - 1 ? 0 : indexPage + 1;
      //               controller!.setPage(page);
      //             },
      //           ),
      //         ]
      //       : null,
      // ),
      body: PDFView(
        filePath: widget.file!.path,
        onRender: (pages) => setState(() => this.pages = pages ?? 0),
        onViewCreated: (controller) => setState(() => this.controller = controller),
        onPageChanged: (indexPage, _) => setState(() => this.indexPage = indexPage ?? 0),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: space300, vertical: space400),
        child: CustomButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/images/ic_import.svg"),
              SizedBox(width: space200),
              Text("Unduh PDF", style: smMedium),
            ],
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
