class Presence {
  String? checkin;
  String? checkout;
  final DateTime? date;
  final bool? isPresence;

  Presence({
    this.checkin,
    this.checkout,
    this.date,
    this.isPresence,
  });

  factory Presence.fromJson(Map<String, dynamic> data) {
    String? checkin;
    String? checkout;
    DateTime? date;

    if (data['jam_masuk'] != null && data['jam_masuk'].isNotEmpty) {
      final list = data['jam_masuk'].split(':');
      list.removeLast();
      checkin = list.join(':');
    }

    if (data['jam_keluar'] != null && data['jam_keluar'].isNotEmpty) {
      final list = data['jam_keluar'].split(':');
      list.removeLast();
      checkout = list.join(':');
    }

    if (data['tanggal'] != null) {
      date = DateTime.parse(data['tanggal']);
    }

    return Presence(
      checkin: checkin,
      checkout: checkout,
      date: date != null ? DateTime.utc(date.year, date.month, date.day) : null,
      isPresence: data['status'] != null ? data['status'] == 'HADIR' : null,
    );
  }
}
