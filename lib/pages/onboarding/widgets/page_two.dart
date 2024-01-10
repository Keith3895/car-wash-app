import 'package:car_wash/widgets/filePicker.dart';
import 'package:car_wash/widgets/inputField.dart';
import 'package:car_wash/widgets/inputLabel.dart';
import 'package:flutter/material.dart';

class PageTwo extends StatefulWidget {
  const PageTwo(
      {Key? key,
      required this.gstn,
      required this.PAN,
      required this.registered_company_name,
      required this.bank_account_number,
      required this.IFSC,
      required this.UPID})
      : super(key: key);
  final TextEditingController gstn;
  final TextEditingController PAN;
  final TextEditingController registered_company_name;
  final TextEditingController bank_account_number;
  final TextEditingController IFSC;
  final TextEditingController UPID;
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

  @override
  void initState() {
    super.initState();
    gstn = widget.gstn;
    PAN = widget.PAN;
    registered_company_name = widget.registered_company_name;
    bank_account_number = widget.bank_account_number;
    IFSC = widget.IFSC;
    UPID = widget.UPID;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              runSpacing: 10,
              children: [
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
                  key: const Key('Registered Company Name'),
                  labelText: "Registered Company Name",
                  controller: registered_company_name,
                ),
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
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            const InputLabels(label: "Car Wash Images"),
            const SizedBox(
              height: 18,
            ),
            FilePickerWidget(
              key: const Key('File Picker'),
              onFilePicked: (result) {
                print(result);
              },
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ));
  }
}
