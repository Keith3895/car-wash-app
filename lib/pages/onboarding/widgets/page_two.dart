import 'package:car_wash/widgets/inputField.dart';
import 'package:car_wash/widgets/inputLabel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PageTwo extends StatefulWidget {
  const PageTwo(
      {super.key,
      required this.formKey,
      required this.gstn,
      required this.PAN,
      required this.registered_company_name,
      required this.bank_account_number,
      required this.IFSC,
      required this.UPID,
      required this.onFormSubmit,
      required this.gstCertificate,
      required this.AdharNumber});

  final Function onFormSubmit;
  final GlobalKey<FormState> formKey;
  final TextEditingController gstn;
  final TextEditingController PAN;
  final TextEditingController registered_company_name;
  final TextEditingController bank_account_number;
  final TextEditingController IFSC;
  final TextEditingController UPID;
  final AdharNumber;
  final gstCertificate;
  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  TextEditingController gstn = TextEditingController();
  TextEditingController PAN = TextEditingController();
  TextEditingController registered_company_name = TextEditingController();
  TextEditingController bank_account_number = TextEditingController();
  TextEditingController IFSC = TextEditingController();
  TextEditingController UPID = TextEditingController();
  TextEditingController gstCertificateText = TextEditingController();
  TextEditingController AdharNumber = TextEditingController();
  late PlatformFile gstCertificate;

  @override
  void initState() {
    super.initState();

    gstn = widget.gstn;
    PAN = widget.PAN;
    registered_company_name = widget.registered_company_name;
    bank_account_number = widget.bank_account_number;
    IFSC = widget.IFSC;
    UPID = widget.UPID;
    if (widget.gstCertificate != null) {
      gstCertificate = widget.gstCertificate;
      gstCertificateText.text = gstCertificate.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
            key: widget.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  runSpacing: 10,
                  children: [
                    const InputLabels(label: "Banking Information"),
                    InputField(
                      key: const Key('Bank Account Number'),
                      labelText: "Bank Account Number",
                      controller: bank_account_number,
                    ),
                    InputField(
                      key: const Key('IFSC'),
                      labelText: "IFSC",
                      controller: IFSC,
                    ),
                    InputField(
                      key: const Key('UPI ID'),
                      labelText: "UPI ID",
                      controller: UPID,
                    ),
                    const InputLabels(label: "KYC Details"),
                    InputField(
                      key: const Key('GSTN'),
                      labelText: "GSTN",
                      controller: gstn,
                    ),
                    InputField(
                      key: const Key('PAN'),
                      labelText: "PAN",
                      controller: PAN,
                    ),
                    InputField(
                      key: const Key('Adhar'),
                      labelText: "Adhar number",
                      controller: AdharNumber,
                    ),
                    InputField(
                      key: const Key('Registered Company Name'),
                      labelText: "Registered Company Name",
                      controller: registered_company_name,
                    ),
                    InputField(
                        key: const Key('GST Certificate'),
                        labelText: "GST Certificate",
                        controller: gstCertificateText,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.upload_file),
                          onPressed: () async {
                            // TODO: error handling.
                            PlatformFile file = await _pickFiles();
                            // if (file != null) {
                            setState(() {
                              gstCertificateText.text = file.name;
                              gstCertificate = file;
                            });
                            widget.onFormSubmit(gstCertificate);
                            // }
                          },
                        )),
                  ],
                ),
              ],
            )));
  }

  _pickFiles() async {
    FilePickerResult? filesResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (filesResult != null) {
      return filesResult.files[0];
    }
    if (!mounted) {
      return;
    }
  }
}
