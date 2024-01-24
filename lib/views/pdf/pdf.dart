import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:newupdate/app/data/modals/userdata.dart';
import 'package:newupdate/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PdfView extends StatefulWidget {
  final Map Data;
  const PdfView({super.key, required this.Data});

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: constants().Themecolor,
        title: const Text("Download Pdf"),
      ),
      body: PdfPreview(
        pdfFileName: widget.Data["fileName"]==null?"WrongFile": widget.Data["fileName"],
        build: widget.Data["List"] == null
            ? (format) => DataNotLoaded(format)
            : (format) => _createPdf(format, widget.Data["List"]),
      ),
    );
  }
}

Future<Uint8List> DataNotLoaded(
  PdfPageFormat format,
) async {
  final pdf = pw.Document(version: PdfVersion.pdf_1_4, compress: true);
  pdf.addPage(pw.Page(
      pageFormat: format,
      build: (context) {
        return pw.Center(child: pw.Text("List Is Empty"));
      }));
  return pdf.save();
}



Future<Uint8List> _createPdf(PdfPageFormat format, List<UserData> data) async {
  // final font = await rootBundle.load("assets/open-sans.pw.Font.courierBold()");
  // finalpw.Font() = pw.Font.pw.Font.courierBold()(font);
  final pdf = pw.Document(
    title: "Deepak",
    version: PdfVersion.pdf_1_4,
    compress: true,
  );

  pdf.addPage(
    pw.Page(
      pageFormat: format,
      build: (context) {
        return pw.Table(
          border: pw.TableBorder.all(),
          columnWidths: {
            0: const pw.FlexColumnWidth(2), // Adjust column widths as needed
            1: const pw.FlexColumnWidth(2),
            4: const pw.FlexColumnWidth(2),
            3: const pw.FlexColumnWidth(2), // Adjust column widths as needed
            4: const pw.FlexColumnWidth(2),
            5: const pw.FlexColumnWidth(2),
          },
          children: [
            pw.TableRow(
              children: [
                pw.Center(
                    child: pw.Text("S.No",
                        style: pw.TextStyle(
                            fontBold: pw.Font.timesBold(), fontSize: 13))),
                pw.Center(
                  child: pw.Text('State',
                      style: pw.TextStyle(
                          fontBold: pw.Font.timesBold(), fontSize: 13)),
                ),
                pw.Center(
                  child: pw.Text('District',
                      style: pw.TextStyle(
                          fontBold: pw.Font.timesBold(), fontSize: 13)),
                ),
                pw.Center(
                  child: pw.Text('Tehsil',
                      style: pw.TextStyle(
                          fontBold: pw.Font.timesBold(), fontSize: 13)),
                ),
                pw.Center(
                  child: pw.Text('Ward',
                      style: pw.TextStyle(
                          fontBold: pw.Font.timesBold(), fontSize: 13)),
                ),
                pw.Center(
                  child: pw.Text('Attendance',
                      style: pw.TextStyle(
                          fontBold: pw.Font.timesBold(), fontSize: 13)),
                ),
                pw.Center(
                  child: pw.Text('Name',
                      style: pw.TextStyle(
                          fontBold: pw.Font.timesBold(), fontSize: 13)),
                ),
              ],
            ),
            // Table rows

            for (var person in data)
              pw.TableRow(
                children: [
                  pw.Center(
                    child: pw.Text(data.indexOf(person).toString(),
                        style: const pw.TextStyle(fontSize: 15)),
                  ),
                  pw.Center(
                    child: pw.Text(person.State.toString(),
                        style: const pw.TextStyle(fontSize: 15)),
                  ),
                  pw.Center(
                    child: pw.Text(person.District.toString(),
                        style: const pw.TextStyle(fontSize: 15)),
                  ),
                  pw.Center(
                    child: pw.Text(person.Tehsil.toString(),
                        style: const pw.TextStyle(fontSize: 15)),
                  ),
                  pw.Center(
                    child: pw.Text(person.Address.toString(),
                        style: const pw.TextStyle(fontSize: 15)),
                  ),
                  pw.Center(
                      child: pw.Container(
                    width: 20,
                    height: 20,
                    decoration: pw.BoxDecoration(
                      color: person.Status == status.Absent.toString()
                          ? PdfColors.red
                          : person.Status == status.Waiting.toString()
                              ? PdfColors.yellow
                              : person.Status == status.Present.toString()
                                  ? PdfColors.green
                                  : PdfColors.black,
                      shape: pw.BoxShape.circle,
                    ),
                  )),
                  pw.Center(
                    child: pw.Text(person.Name.toString(),
                        style: const pw.TextStyle(fontSize: 17)),
                  ),
                ],
              ),
          ],
        );
      },
    ),
  );
    Uint8List bytes = await pdf.save();
  return bytes;
}
