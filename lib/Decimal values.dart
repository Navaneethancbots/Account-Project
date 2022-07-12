
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyFormatIn extends TextInputFormatter{

  var money = NumberFormat("##,##,###");
  var newText ="";
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    if(newValue.selection.baseOffset == 0) {
      return newValue;
    }
    double value = double.parse(newValue.text);

    newText = money.format(value);
    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length)
    );
  }

}