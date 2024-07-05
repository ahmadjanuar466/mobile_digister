// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:io';
import 'package:digister/models/dues_model.dart';
import 'package:digister/models/dues_type_model.dart';
import 'package:digister/services/dues.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:digister/screens/loading/loading_screen.dart';
import '../../../utils/global.dart';
import 'image_field.dart';
import 'image_picker_bottom_sheet.dart';

class ConfirmationTab extends StatefulWidget {
  const ConfirmationTab({super.key});

  @override
  State<ConfirmationTab> createState() => _ConfirmationTabState();
}

class _ConfirmationTabState extends State<ConfirmationTab> {
  final TextEditingController _dateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  final TextEditingController _ketController = TextEditingController();
  String _currentDues = "";
  final TextEditingController _monthController = TextEditingController();
  int _currentMonth = 0;
  String _currentYear = "";
  String _imageNull = "";
  final List<DuesType> _duesList = [];

  @override
  void initState() {
    super.initState();
    _getDuesList();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _ketController.dispose();
    _monthController.dispose();
    super.dispose();
  }

  void _getDuesList() async {
    final dues = await getDues();

    if (!mounted) return;

    setState(() {
      _duesList.addAll(dues);
    });
  }

  _imageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = image;
      });
      Navigator.pop(context);
    }
  }

  _imageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = image;
      });
      Navigator.pop(context);
    }
  }

  _showImageDetail(XFile file) {
    showModalDialog(
      context,
      Dialog(
        child: ImageModalContent(
          context: context,
          file: file,
        ),
      ),
    );
  }

  _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2101),
      locale: const Locale("id"),
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: isDarkMode
                ? ColorScheme.dark(
                    primary: theme.colorScheme.primary,
                    onPrimary: theme.colorScheme.onPrimary,
                  )
                : ColorScheme.light(
                    primary: theme.colorScheme.primary,
                    onPrimary: theme.colorScheme.onPrimary,
                  ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd', "id").format(pickedDate);

      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  _showMonthPicker() async {
    final pickedMonth = await showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2100),
      locale: const Locale("id"),
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: isDarkMode
                ? ColorScheme.dark(
                    primary: theme.colorScheme.primary,
                    onPrimary: theme.colorScheme.onPrimary,
                  )
                : ColorScheme.light(
                    primary: theme.colorScheme.primary,
                    onPrimary: theme.colorScheme.onPrimary,
                  ),
          ),
          child: child!,
        );
      },
    );

    if (pickedMonth != null) {
      String formattedDate = DateFormat('MMMM yyyy', "id").format(pickedMonth);

      setState(() {
        _monthController.text = formattedDate;
        _currentMonth = pickedMonth.month;
        _currentYear = pickedMonth.year.toString();
      });
    }
  }

  _showBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: theme.colorScheme.primaryContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (BuildContext context) {
        return ImagePickerBottomSheet(
          onCameraTap: _imageFromCamera,
          onGalleryTap: _imageFromGallery,
        );
      },
    );
  }

  _handleSubmit() {
    if (_image == null) {
      setState(() {
        _imageNull = "Anda belum menyertakan bukti pembayaran";
      });
      return;
    }

    if (_formKey.currentState!.validate()) {
      final imageBytes = File(_image!.path).readAsBytesSync();
      final base64Image = base64Encode(imageBytes);

      final currentDues = _duesList
          .where(
            (element) => element.duesId == _currentDues,
          )
          .toList();

      final dues = Dues(
        userId: int.parse(user.userId),
        nik: user.nik,
        name: user.nama,
        block: user.block,
        houseNum: int.parse(user.houseNum),
        duesPrice: int.parse(currentDues[0].duesPrice),
        duesType: currentDues[0].duesName,
        duesId: _currentDues,
        paymentDate: _dateController.text,
        paymentMonth: _currentMonth,
        paymentYear: _currentYear,
        isValid: 0,
        proofOfPayment: base64Image,
      );

      Navigator.push(
        context,
        PageTransition(
          child: LoadingScreen(dues: dues),
          type: PageTransitionType.bottomToTop,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField(
              menuMaxHeight: 200,
              dropdownColor: isDarkMode
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.onPrimary,
              items: _duesList
                  .map(
                    (item) => DropdownMenuItem(
                      value: item.duesId,
                      child: Text("${item.duesName}, Rp. ${item.duesPrice}"),
                    ),
                  )
                  .toList(),
              decoration: const InputDecoration(
                labelText: 'Jenis iuran',
              ),
              onChanged: (value) {
                setState(() {
                  _currentDues = value ?? "";
                });
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _dateController,
              keyboardType: TextInputType.text,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Tanggal pembayaran',
              ),
              validator: validator,
              onTap: _showDatePicker,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _monthController,
              keyboardType: TextInputType.text,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Pembayaran bulan',
              ),
              validator: validator,
              onTap: _showMonthPicker,
            ),
            const SizedBox(height: 10),
            const Text("Bukti Pembayaran"),
            const SizedBox(height: 5),
            ImageField(
              onTap: _showBottomSheet,
              image: _image,
              onViewImage: () => _showImageDetail(_image!),
              onCancelImage: () {
                setState(() {
                  _image = null;
                });
              },
            ),
            if (_imageNull.isNotEmpty)
              Text(
                _imageNull,
                style: theme.textTheme.bodySmall!.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _ketController,
              keyboardType: TextInputType.text,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Keterangan',
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: _handleSubmit,
                child: const Text('Kirim'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
