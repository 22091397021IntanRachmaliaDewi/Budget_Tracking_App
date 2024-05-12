import 'package:intl/intl.dart';

extension FormatDateTime on DateTime {
  String formatForm() {
    return DateFormat('dd-MM-yyyy').format(this);
  }

  String formatUI() {
    return DateFormat('d MMMM y HH:mm a', 'id').format(this);
  }

  String formatRp() {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(this);
  }
}
