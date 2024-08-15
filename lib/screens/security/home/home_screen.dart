import 'dart:async';
import 'package:digister/models/presence_model.dart';
import 'package:digister/routes/route_helper.dart';
import 'package:digister/screens/security/home/notifier.dart';
import 'package:digister/services/security.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer _timer;
  String _hours = "0";
  String _minutes = "0";
  final Notifier _presenceData = Notifier();
  DateTime _selectedDay = DateTime.now();
  Presence? _todayPresence;

  @override
  void initState() {
    super.initState();
    final dateTime = DateTime.now();

    _minutes = dateTime.minute < 10
        ? '0${dateTime.minute}'
        : dateTime.minute.toString();
    _hours =
        dateTime.hour < 10 ? '0${dateTime.hour}' : dateTime.hour.toString();

    _timer = Timer.periodic(1.minutes, (_) {
      final dateTime = DateTime.now();

      setState(() {
        _minutes = dateTime.minute < 10
            ? '0${dateTime.minute}'
            : dateTime.minute.toString();
        _hours =
            dateTime.hour < 10 ? '0${dateTime.hour}' : dateTime.hour.toString();
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkPresence();
      _getPresenceHistory();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _checkPresence() async {
    final todayPresence = await checkPresence();

    if (!mounted) return;

    if (todayPresence != null) {
      setState(() {
        _todayPresence = todayPresence;
      });
    }
  }

  void _getPresenceHistory() async {
    final histories = await getPresenceHistory();

    for (var item in histories) {
      _presenceData.add({item.date!: item.isPresence!});
    }
  }

  void _doPresence() async {
    showLoader(context);

    Presence? presence;

    if (_todayPresence!.checkin == null) {
      presence = await doPresence('masuk');
    } else {
      presence = await doPresence('keluar');
    }

    // ignore: use_build_context_synchronously
    RouteHelper.pop(context);

    setState(() {
      if (presence!.checkin != null) {
        _todayPresence!.checkin = presence.checkin;
      } else {
        _todayPresence!.checkout = presence.checkout;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    isDarkMode = theme.brightness == Brightness.dark;

    if (_todayPresence == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: 200.v,
            color: theme.colorScheme.primary,
          ),
          SafeArea(
            child: ListView(
              padding: EdgeInsets.all(16.h),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Hi,'),
                        Text(user.nama),
                      ],
                    ),
                    Text(
                      '$_hours:$_minutes',
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontSize: 28.fSize,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.v),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.all(16.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.h),
                    color: theme.colorScheme.primaryContainer,
                    border: isDarkMode
                        ? Border.all(color: theme.colorScheme.onPrimary)
                        : null,
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.secondary.withOpacity(0.1),
                        offset: const Offset(4, 5),
                        blurRadius: 9,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('d MMMM yyyy', 'id')
                                .format(DateTime.now()),
                            style: theme.textTheme.titleMedium,
                          ),
                          Text(
                            'Presensi hari ini',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                      SizedBox(height: 20.v),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Masuk',
                                  style: theme.textTheme.titleMedium,
                                ),
                                Text(
                                  _todayPresence?.checkin ?? '--:--',
                                  style: theme.textTheme.titleLarge!.copyWith(
                                    fontSize: 32.fSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Pulang',
                                  style: theme.textTheme.titleMedium,
                                ),
                                Text(
                                  _todayPresence?.checkout ?? '--:--',
                                  style: theme.textTheme.titleLarge!.copyWith(
                                    fontSize: 32.fSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (_todayPresence!.checkout == null)
                        SizedBox(height: 20.v),
                      if (_todayPresence!.checkout == null)
                        SizedBox(
                          width: double.maxFinite,
                          height: 45.v,
                          child: ElevatedButton(
                            onPressed: _doPresence,
                            child: Text(
                              _todayPresence!.checkin == null
                                  ? 'Masuk'
                                  : 'Pulang',
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 20.v),
                const Text('Riwayat kehadiran'),
                ListenableBuilder(
                    listenable: _presenceData,
                    builder: (context, child) {
                      return TableCalendar(
                        firstDay: DateTime(DateTime.now().year, 1, 1),
                        lastDay: DateTime(DateTime.now().year, 12, 31),
                        focusedDay: _selectedDay,
                        locale: 'id',
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                        ),
                        calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.colorScheme.primary,
                          ),
                          selectedDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.colorScheme.primary.withOpacity(0.8),
                          ),
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekendStyle:
                              TextStyle(color: theme.colorScheme.error),
                        ),
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                        onDaySelected: (selectedDay, focusedDay) {
                          if (!isSameDay(_selectedDay, selectedDay)) {
                            setState(() {
                              _selectedDay = selectedDay;
                            });
                          }
                        },
                        calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, day, focusedDay) {
                            if (_presenceData.item.containsKey(day)) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  Text(day.day.toString()),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: _presenceData.item[day]!
                                        ? const Icon(Icons.check,
                                            color: Colors.green)
                                        : const Icon(Icons.close,
                                            color: Colors.red),
                                  )
                                ],
                              );
                            }
                            return null;
                          },
                        ),
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
