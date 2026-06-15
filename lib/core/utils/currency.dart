import 'package:intl/intl.dart';

/// Formats whole rupiah (contract `priceIdr`, no minor unit) for display, e.g.
/// `2450000 → "Rp 2.450.000"`. Indonesian grouping (dot separators) regardless
/// of the active locale, since prices are always IDR in the MVP market.
String formatIdr(int priceIdr) {
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  return formatter.format(priceIdr);
}
