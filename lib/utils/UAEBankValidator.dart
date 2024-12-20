class UAEBankValidator {
  // Main validation function
  static bool isValidAccountNumber(String? accountNumber) {
    if (accountNumber == null || accountNumber.isEmpty) {
      return false;
    }

    // Remove any spaces or special characters
    final cleanNumber = accountNumber.replaceAll(RegExp(r'[^A-Za-z0-9]'), '');

    // Check if it's an IBAN
    if (cleanNumber.toUpperCase().startsWith('AE')) {
      return _isValidIBAN(cleanNumber);
    }

    // Check if it's a regular account number
    return _isValidRegularAccount(cleanNumber);
  }

  // IBAN validation
  static bool _isValidIBAN(String number) {
    // UAE IBAN must be 23 characters
    if (number.length != 23) {
      return false;
    }

    // Check if starts with AE and followed by 2 check digits and 19 numbers
    final ibanRegex = RegExp(r'^AE\d{21}$');
    return ibanRegex.hasMatch(number);
  }

  // Regular account number validation
  static bool _isValidRegularAccount(String number) {
    // Check length (12-16 digits is acceptable for UAE banks)
    if (number.length < 12 || number.length > 16) {
      return false;
    }

    // Check if contains only digits
    final numberRegex = RegExp(r'^\d+$');
    return numberRegex.hasMatch(number);
  }


  static bool isValidUAEIBAN(String? iban) {
    // Return false if null or empty
    if (iban == null || iban.isEmpty) {
      return false;
    }

    // Remove all spaces and special characters
    final cleanIBAN = iban.replaceAll(RegExp(r'[^A-Za-z0-9]'), '').toUpperCase();

    // Basic length check (UAE IBAN is 23 characters)
    if (cleanIBAN.length != 23) {
      return false;
    }

    // Check if starts with 'AE'
    if (!cleanIBAN.startsWith('AE')) {
      return false;
    }

    // Validate format: AE + 2 check digits + 3 bank code + 16 account number
    final ibanRegex = RegExp(r'^AE\d{2}\d{3}\d{16}$');
    return ibanRegex.hasMatch(cleanIBAN);
  }

  /// Formats IBAN with spaces for better readability
  /// Returns formatted IBAN string
  static String formatIBAN(String iban) {
    final cleanIBAN = iban.replaceAll(RegExp(r'[^A-Za-z0-9]'), '').toUpperCase();

    // Format in groups of 4: AE07 0331 2345 6789 0123 456
    final buffer = StringBuffer();
    for (var i = 0; i < cleanIBAN.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(cleanIBAN[i]);
    }
    return buffer.toString();
  }

  /// Returns detailed error message if IBAN is invalid
  /// Returns null if IBAN is valid
  static String? getErrorMessage(String? iban) {
    if (iban == null || iban.isEmpty) {
      return 'IBAN is required';
    }

    final cleanIBAN = iban.replaceAll(RegExp(r'[^A-Za-z0-9]'), '').toUpperCase();

    if (cleanIBAN.length != 23) {
      return 'UAE IBAN must be 23 characters long';
    }

    if (!cleanIBAN.startsWith('AE')) {
      return 'UAE IBAN must start with AE';
    }

    if (!RegExp(r'^\d+$').hasMatch(cleanIBAN.substring(2))) {
      return 'IBAN must contain only numbers after country code';
    }

    return null;
  }
}