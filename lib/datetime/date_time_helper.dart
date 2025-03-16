// convert DateTime object to a string yyyymmdd
String convertDateTimetoString(DateTime dateTime) {
  // year in the format of 4 digits
  String year = dateTime.year.toString();

  // month in the format of 2 digits
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0' + month;
  }

  // day in the format of 2 digits
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0' + day;
  }

  // final format -> yyyymmdd
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}

