import 'dart:async';
import 'dart:convert';
import 'package:PedhaPay/utils/WAColors.dart';
import 'package:PedhaPay/view_model/appController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../model/Pedha Pay Model/LoadRequestBankListModel.dart';


class loadRequest extends StatefulWidget {
  const loadRequest({super.key});

  @override
  State<loadRequest> createState() => _loadRequestState();
}

class _loadRequestState extends State<loadRequest> {

  appController fundRequestController = Get.find();

  late Timer _timer;


  @override
  void initState() {
    _timer = Timer(const Duration(milliseconds: 50), () {
      // SOMETHING
      fundRequestController.loadRequestBankListApi();

    });

    super.initState();
  }

  final bankKey = GlobalKey<FormState>();
  final amountKey = GlobalKey<FormState>();
  final txnIdKey = GlobalKey<FormState>();
  final fundKey = GlobalKey<FormState>();

  String ImageName = "Upload";

  XFile? imageFile;
  XFile? imagePath;
  var imgVisible = false.obs;

  Future<void> _pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final bytes = await image!.readAsBytes();
    setState(() {
      imageFile = image;
      fundRequestController.ImagePath = imageFile!.path;
      fundRequestController.base64Imageurl = base64Encode(bytes);
      print(fundRequestController.base64Imageurl);
      ImageName = imageFile!.name;
      fundRequestController.isVisibleSlip.value = true;
      imgVisible.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color
      body: Obx(() {
        return WillPopScope(
          onWillPop: () async {
            // _resetForm();
            return true;
          },
          child: Stack(
            children: [
              Form(
                key: fundKey,
                child: Column(
                  children: [
                    _buildHeader(context), // Static header
                    Expanded(
                      child: SingleChildScrollView(
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildAutocompleteFundMode(context),
                              const SizedBox(height: 15),
                              _buildAutocompleteBank(context),
                              const SizedBox(height: 15),
                              _buildTextField(
                                context,
                                label: "Amount",
                                hint: "Enter amount",
                                controller: fundRequestController.FAmountController,
                                validator: Validation.validateAmount,
                                keyboardType: TextInputType.number,
                                maxLength: 7,
                              ),
                              const SizedBox(height: 15),
                              _buildTextField(
                                context,
                                label: "Txn ID",
                                hint: "Enter transaction ID",
                                controller: fundRequestController.FTxnIdController,
                                validator: Validation.validationRequired,
                              ),
                              const SizedBox(height: 15),
                              _buildDateField(context),
                              const SizedBox(height: 15),
                              _buildTextField(
                                context,
                                label: "Remarks",
                                hint: "Enter remarks",
                                controller: fundRequestController.FRemarksController,
                                validator: Validation.validationRequired,
                                maxLength: 50,
                              ),
                              const SizedBox(height: 15),
                              Visibility(
                                visible: fundRequestController.isVisibleSlip.value,
                                child: fundRequestController.imgShow(),
                              ),
                              const SizedBox(height: 10),
                              _buildUploadButton(context),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  // Validate all fields
                                  if (fundKey.currentState!.validate() && fundKey.currentState!.validate()) {
                                    fundRequestController.fundRequestApi();
                                  } else {
                                    Get.snackbar(
                                      "Validation Error",
                                      "Please correct the highlighted errors.",
                                      snackPosition: SnackPosition.TOP,
                                    );
                                  }
                                },
                                child: const Text("Submit"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (fundRequestController.isLoading.value)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.13,
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.06,
              left: 20,
              right: 20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    // _resetForm();
                    Get.back();
                  },
                  child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                const Text(
                  "Fund Request",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAutocompleteFundMode(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Select Mode", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        InputDecorator(
          decoration: const InputDecoration(
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          ),
          child: Autocomplete<IconLabel>(
            displayStringForOption: (IconLabel mode) => mode.label,
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return IconLabel.values;
              }
              return IconLabel.values.where((IconLabel mode) {
                return mode.label.toLowerCase().contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (IconLabel selectedMode) {
              // Set the selected mode in your controller or state
              fundRequestController.fundMode = selectedMode.label;
              fundKey.currentState!.validate();
            },
            fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
              return TextFormField(
                onChanged: (value){
                  fundKey.currentState!.validate();
                },
                controller: controller,
                focusNode: focusNode,
                decoration: const InputDecoration(
                  hintText: "Search mode",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 8),
                ),
                validator: (value) {
                  if (controller.text.isEmpty) {
                    return "Please select a mode.";
                  }
                  return null;
                },
              );
            },
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4.0,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 200,
                      maxWidth: MediaQuery.of(context).size.width * 0.88,
                    ),
                    child: ListView.builder(
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final IconLabel mode = options.elementAt(index);
                        return ListTile(
                          leading: Icon(mode.icon, color: Theme.of(context).primaryColor),
                          title: Text(mode.label),
                          onTap: () => onSelected(mode),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAutocompleteBank(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Select Bank", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        InputDecorator(
          decoration: const InputDecoration(
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          ),
          child: Autocomplete<loadRequestBankListModel>(
            displayStringForOption: (bank) => "${bank.bankName} (${bank.accountNo})",
            optionsBuilder: (textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return fundRequestController.LoadRequestbanklist;
              }
              return fundRequestController.LoadRequestbanklist.where(
                    (bank) => bank.bankName!.toLowerCase().contains(textEditingValue.text.toLowerCase()),
              );
            },
            onSelected: (bank) {
              fundRequestController.bankName = bank.bankName!;
              fundKey.currentState!.validate();
              print(fundRequestController.bankName);
            },
            fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
              return TextFormField(
                validator: (value) {
                  if (controller.text.isEmpty) {
                    return "Please select a bank.";
                  }
                  return null;
                },
                controller: controller,
                focusNode: focusNode,
                decoration: const InputDecoration(
                  hintText: "Search bank",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 8),
                ),
              );
            },
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4.0,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 300, // Set maximum height for the dropdown
                      maxWidth: MediaQuery.of(context).size.width * 0.89, // Set maximum width
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final loadRequestBankListModel bank = options.elementAt(index);
                        return ListTile(
                          leading: Icon(Icons.account_balance, color: Theme.of(context).primaryColor),
                          title: Text(bank.bankName!),
                          subtitle: Text("(${bank.accountNo!})"),
                          onTap: () => onSelected(bank),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(BuildContext context, {required String label, required String hint, required TextEditingController controller, required String? Function(String?) validator, TextInputType keyboardType = TextInputType.text, int? maxLength}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          maxLength: maxLength,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Txn Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Required";
            }
            return null;
          },
          controller: fundRequestController.FTxnDateController,
          readOnly: true,
          decoration: InputDecoration(
            hintText: "DD-MM-YYYY",
            filled: true,
            fillColor: Colors.grey[200],
          ),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              fundRequestController.FTxnDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
            }
          },
        ),
      ],
    );
  }

  Widget _buildUploadButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        _pickImageFromGallery();
      },
      icon: const Icon(Icons.add),
      label: const Text("Upload Slip"),
    );
  }

}


enum IconLabel {
  smile('CASH', Icons.sentiment_satisfied_outlined, "3"),
  cloud('UPI/IMPS', Icons.cloud_outlined, "2"),
  brush('NEFT/RTGS', Icons.brush_outlined, "5"),
  RTGS('CDM', Icons.favorite, "9"),
  bank('Fund ', Icons.account_box, "8");

  const IconLabel(this.label, this.icon, this.value);
  final String label;
  final IconData icon;
  final String value;
}