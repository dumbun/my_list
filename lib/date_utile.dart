import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DateConvertUtils {
  static String formate(Timestamp date) {
    final DateTime convertedTimeStamp = date.toDate().toLocal();
    final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
    final String formattedDate = formatter.format(convertedTimeStamp);
    return formattedDate;
  }
}
