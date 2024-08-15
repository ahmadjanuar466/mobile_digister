import 'dart:async';
import 'package:digister/models/confirm_dues_model.dart';
import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/basic/treasury/components/floating_button.dart';
import 'package:digister/screens/basic/treasury/components/highlight.dart';
import 'package:digister/screens/basic/treasury/components/new_confirmation.dart';
import 'package:digister/screens/basic/treasury/list_data_screen.dart';
import 'package:digister/services/treasury.dart';
import 'package:digister/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/widgets/custom_button.dart';
import 'package:page_transition/page_transition.dart';

class TreasuryScreen extends StatefulWidget {
  const TreasuryScreen({super.key});

  @override
  State<TreasuryScreen> createState() => _TreasuryScreenState();
}

class _TreasuryScreenState extends State<TreasuryScreen> {
  final TextEditingController _dateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  ConfirmDues? _unpaidCitizens;
  ConfirmDues? _paidCitizens;
  ConfirmDues? _unConfirmedCitizens;
  ConfirmDues? _confirmedCitizens;
  String _month = "";
  String _year = "";
  bool _loading = true;
  int _totalUnpaid = 0;
  int _totalPaid = 0;
  int _totalUnconfirmed = 0;
  int _totalConfirmed = 0;

  @override
  void initState() {
    super.initState();
    _month = DateTime.now().month.toString();
    _year = DateTime.now().year.toString();
    _getAllCitizens();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  void _getCitizens({required String uri, required String type}) async {
    final citizens = await getCitizens(uri, {
      'bln': _month,
      'thn': _year,
    });

    if (!mounted) return;

    if (type == 'unpaid') {
      setState(() {
        _unpaidCitizens = citizens;
      });
    } else if (type == 'paid') {
      setState(() {
        _paidCitizens = citizens;
      });
    } else if (type == 'unconfirmed') {
      setState(() {
        _unConfirmedCitizens = citizens;
      });
    } else {
      setState(() {
        _confirmedCitizens = citizens;
        _loading = false;
      });
    }

    if (citizens != null) {
      if (!mounted) return;

      _animateNumber(citizens: citizens, type: type);
    } else {
      setState(() {
        _totalUnpaid = 0;
        _totalPaid = 0;
        _totalUnconfirmed = 0;
        _totalConfirmed = 0;
      });
    }
  }

  void _animateNumber({
    required ConfirmDues citizens,
    required String type,
  }) {
    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (_totalUnpaid != citizens.total && type == 'unpaid') {
        setState(() {
          _totalUnpaid++;
        });
      } else if (_totalPaid != citizens.total && type == 'paid') {
        setState(() {
          _totalPaid++;
        });
      } else if (_totalUnconfirmed != citizens.total && type == 'unconfirmed') {
        setState(() {
          _totalUnconfirmed++;
        });
      } else if (_totalConfirmed != citizens.total && type == 'confirmed') {
        setState(() {
          _totalConfirmed++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _getAllCitizens() {
    _getCitizens(uri: '/api/bendahara/databelumiuran', type: 'unpaid');
    _getCitizens(uri: '/api/bendahara/datasdhbayariuran', type: 'paid');
    _getCitizens(uri: '/api/bendahara/datablmkonfirmasi', type: 'unconfirmed');
    _getCitizens(uri: '/api/bendahara/datasdhkonfirmasi', type: 'confirmed');
  }

  void _showMonthPicker(String type) async {
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
        if (type == "posting") {
          _dateController.text = formattedDate;
        }
        _month = DateFormat("M").format(pickedMonth);
        _year = DateFormat("yyyy").format(pickedMonth);
      });

      if (type == "filter") {
        setState(() {
          _loading = true;
        });
        _getAllCitizens();
      }
    }
  }

  void _createNewPosting() async {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);

      final postCreated = await createPosting({'bln': _month, 'thn': _year});

      if (!postCreated) {
        _showCreateNewBillModal();
      }
    }
  }

  void _showCreateNewBillModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.h),
          topRight: Radius.circular(16.h),
        ),
      ),
      showDragHandle: true,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          left: 16.h,
          right: 16.h,
          bottom: 16.h,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Posting iuran",
                style: TextStyle(fontSize: 18.fSize),
              ),
              SizedBox(height: 10.v),
              TextFormField(
                controller: _dateController,
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Bulan'),
                onTap: () => _showMonthPicker("posting"),
              ),
              SizedBox(height: 10.v),
              CustomButton(
                onPressed: _createNewPosting,
                text: "Lanjutkan",
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            if (_loading)
              LinearProgressIndicator(
                backgroundColor: isDarkMode
                    ? theme.colorScheme.primaryContainer
                    : theme.colorScheme.onPrimary,
              ),
            Padding(
              padding: EdgeInsets.all(10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bendahara',
                    style: theme.textTheme.titleLarge,
                  ),
                  SizedBox(height: 20.v),
                  Row(
                    children: [
                      Expanded(
                        child: Highlight(
                          title: 'Belum bayar',
                          total: _totalUnpaid,
                          onTap: _unpaidCitizens != null
                              ? () => RouteHelper.push(
                                    context,
                                    widget: ListDataScreen(
                                      listData: _unpaidCitizens!.dues,
                                      title: 'Belum iuran',
                                      month: _month,
                                      year: _year,
                                      listType: 'unpaid',
                                    ),
                                    transitionType:
                                        PageTransitionType.rightToLeft,
                                  )
                              : () {},
                        ),
                      ),
                      SizedBox(width: 8.h),
                      Expanded(
                        child: Highlight(
                          title: 'Sudah bayar',
                          total: _totalPaid,
                          onTap: _paidCitizens != null
                              ? () => RouteHelper.push(
                                    context,
                                    widget: ListDataScreen(
                                      listData: _paidCitizens!.dues,
                                      title: 'Sudah iuran',
                                      listType: 'paid',
                                    ),
                                    transitionType:
                                        PageTransitionType.rightToLeft,
                                  )
                              : () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.v),
                  Row(
                    children: [
                      Expanded(
                        child: Highlight(
                          title: 'Belum konfirmasi',
                          total: _totalUnconfirmed,
                          onTap: _unConfirmedCitizens != null
                              ? () => RouteHelper.push(
                                    context,
                                    widget: ListDataScreen(
                                      listData: _unConfirmedCitizens!.dues,
                                      title: 'Belum divalidasi',
                                      listType: 'unconfirmed',
                                    ),
                                    transitionType:
                                        PageTransitionType.rightToLeft,
                                  )
                              : () {},
                        ),
                      ),
                      SizedBox(width: 8.h),
                      Expanded(
                        child: Highlight(
                          title: 'Sudah konfirmasi',
                          total: _totalConfirmed,
                          onTap: _confirmedCitizens != null
                              ? () => RouteHelper.push(
                                    context,
                                    widget: ListDataScreen(
                                      listData: _confirmedCitizens!.dues,
                                      title: 'Sudah divalidasi',
                                      listType: 'confirmed',
                                    ),
                                    transitionType:
                                        PageTransitionType.rightToLeft,
                                  )
                              : () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.v),
                  Text(
                    'Baru konfirmasi',
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(height: 5.v),
                  Expanded(
                    child: NewConfirmation(
                      onRefresh: () async {
                        _getAllCitizens();
                      },
                      unConfirmedCitizens: _unConfirmedCitizens,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingButton(
                    icon: Icons.post_add_rounded,
                    onTap: _showCreateNewBillModal,
                  ),
                  FloatingButton(
                    icon: Icons.filter_alt,
                    onTap: () => _showMonthPicker('filter'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
