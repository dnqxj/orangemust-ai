String getYMD(DateTime dateTime) {
  if (dateTime == null) return "";
  var year = dateTime.year.toString();
  var month = dateTime.month > 9 ? dateTime.month.toString() : '0' + dateTime.month.toString();
  var day = dateTime.day > 9 ? dateTime.day.toString() : '0' + dateTime.day.toString();
  return year + '-' + month + '-' + day;
  // return dateTime == null ? "" : dateTime.year.toString() + '-' + dateTime.month.toString() + '-' + dateTime.day.toString();
}

String timeStampToYMD(int timeStamp) {
  if(timeStamp.toString().length == 13) {
    return getYMD(DateTime.fromMillisecondsSinceEpoch(timeStamp));
  } else if(timeStamp.toString().length == 10) {
    return getYMD(DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000));
  } else {
    return "";
  }
}