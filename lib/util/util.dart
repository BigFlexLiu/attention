bool hasDayPassed(DateTime time) {
  DateTime now = DateTime.now();

  return now.year != time.year ||
      now.month != time.month ||
      now.day != time.day;
}

bool hasMonthPassed(DateTime time) {
  // Check if the year or the month has changed
  DateTime now = DateTime.now();
  bool yearChanged = now.year != now.year;
  bool monthChanged = now.month != now.month;

  // A month boundary has been crossed if either the year or the month has changed
  return yearChanged || monthChanged;
}
