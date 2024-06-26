import 'package:digister/models/confirm_dues_model.dart';
import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/treasury/components/floating_button.dart';
import 'package:digister/screens/treasury/components/highlight.dart';
import 'package:digister/screens/treasury/components/new_confirmation.dart';
import 'package:digister/screens/treasury/list_data_screen.dart';
import 'package:digister/services/treasury.dart';
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
  ConfirmDuesModel? _unpaidCitizens;
  ConfirmDuesModel? _paidCitizens;
  ConfirmDuesModel? _unConfirmedCitizens;
  ConfirmDuesModel? _confirmedCitizens;
  String _month = "";
  String _year = "";
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _month = DateTime.now().month.toString();
    _year = DateTime.now().year.toString();
    _getUnpaidCitizens();
    _getPaidCitizens();
    _getConfirmedCitizens();
    _getUnconfirmedCitizens();
  }

  _getUnpaidCitizens() async {
    final unpaidCitizens = await getCitizens('/api/bendahara/databelumiuran', {
      'bln': _month,
      'thn': _year,
    });

    if (!mounted) return;

    setState(() {
      _unpaidCitizens = unpaidCitizens;
    });
  }

  _getPaidCitizens() async {
    final paidCitizens = await getCitizens('/api/bendahara/datasdhbayariuran', {
      'bln': _month,
      'thn': _year,
    });

    if (!mounted) return;

    setState(() {
      _paidCitizens = paidCitizens;
    });
  }

  _getConfirmedCitizens() async {
    final confirmedCitizens = await getCitizens(
      '/api/bendahara/datasdhkonfirmasi',
      {
        'bln': _month,
        'thn': _year,
      },
    );

    if (!mounted) return;

    setState(() {
      _confirmedCitizens = confirmedCitizens;
      _loading = false;
    });
  }

  _getUnconfirmedCitizens() async {
    final unConfirmedCitizens = await getCitizens(
      '/api/bendahara/datablmkonfirmasi',
      {
        'bln': _month,
        'thn': _year,
      },
    );

    if (!mounted) return;

    setState(() {
      _unConfirmedCitizens = unConfirmedCitizens;
    });
  }

  _showMonthPicker(String type) async {
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
        _getUnpaidCitizens();
        _getPaidCitizens();
        _getConfirmedCitizens();
        _getUnconfirmedCitizens();
      }
    }
  }

  _createNewPosting() async {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);

      final postCreated = await createPosting({'bln': _month, 'thn': _year});

      if (!postCreated) {
        _showCreateNewBillModal();
      }
    }
  }

  _showCreateNewBillModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.primaryContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      showDragHandle: true,
      builder: (context) => Container(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Posting iuran",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _dateController,
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Bulan'),
                onTap: () => _showMonthPicker("posting"),
              ),
              const SizedBox(height: 10),
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
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Highlight(
                          title: 'Belum bayar',
                          total: _unpaidCitizens?.total ?? 0,
                          onTap: () => RouteHelper.push(
                            context,
                            widget: ListDataScreen(
                              listData: _unpaidCitizens!.dues,
                              title: 'Belum iuran',
                              month: _month,
                              year: _year,
                              listType: 'unpaid',
                            ),
                            transitionType: PageTransitionType.rightToLeft,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Highlight(
                          title: 'Sudah bayar',
                          total: _paidCitizens?.total ?? 0,
                          onTap: () => RouteHelper.push(
                            context,
                            widget: ListDataScreen(
                              listData: _paidCitizens!.dues,
                              title: 'Sudah iuran',
                              listType: 'paid',
                            ),
                            transitionType: PageTransitionType.rightToLeft,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Highlight(
                          title: 'Belum konfirmasi',
                          total: _unConfirmedCitizens?.total ?? 0,
                          onTap: () => RouteHelper.push(
                            context,
                            widget: ListDataScreen(
                              listData: _unConfirmedCitizens!.dues,
                              title: 'Belum divalidasi',
                              listType: 'unconfirmed',
                            ),
                            transitionType: PageTransitionType.rightToLeft,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Highlight(
                          title: 'Sudah konfirmasi',
                          total: _confirmedCitizens?.total ?? 0,
                          onTap: () => RouteHelper.push(
                            context,
                            widget: ListDataScreen(
                              listData: _confirmedCitizens!.dues,
                              title: 'Sudah divalidasi',
                              listType: 'confirmed',
                            ),
                            transitionType: PageTransitionType.rightToLeft,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Baru konfirmasi',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: NewConfirmation(
                      onRefresh: () async {
                        _getUnpaidCitizens();
                        _getPaidCitizens();
                        _getUnconfirmedCitizens();
                        _getConfirmedCitizens();
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
