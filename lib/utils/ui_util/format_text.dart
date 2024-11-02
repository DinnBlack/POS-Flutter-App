class FormatText {
  static String formatCurrency(int amount) {
    return '${amount.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}đ';
  }

  static int parseCurrency(String formattedValue) {
    return int.tryParse(
            formattedValue.replaceAll('đ', '').replaceAll('.', '').trim()) ??
        0;
  }


  static String formatPercentage(int percentage) {
    return '${percentage.toString()}%';
  }

  static int parsePercentage(String formattedValue) {
    return int.tryParse(formattedValue.replaceAll('%', '').trim()) ?? 0;
  }
}
