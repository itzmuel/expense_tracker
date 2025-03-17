import 'package:expense_tracker/data/hive_database.dart';
import 'package:expense_tracker/datetime/date_time_helper.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier{

  //list of All expenses
  List<ExpenseItem> overallExpenseList = [];

  //get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  // data to display
  final db = HiveDatabase();
  void prepareData() {
    // if they exist
    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
    }
  }

  // add new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);

    notifyListeners();
    db.saveData(overallExpenseList);
  }
  // delete expense
  void deleteExpense(ExpenseItem expenseItem) {
    overallExpenseList.remove(expenseItem);

    notifyListeners();
    db.saveData(overallExpenseList);
  }

  // get weekday (mon, tues, etc) from a datetime object
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
      return 'Mon';
      case 2:
      return 'Tue';
      case 3:
      return 'Wed';
      case 4:
      return 'Thu';
      case 5:
      return 'Fri';
      case 6:
      return 'Sat';
      case 7:
      return 'Sun';
      default:
      return '';
    }
  }


  // get the date for the start of the week ( sunday )
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    //get todays date
    DateTime today = DateTime.now();

    //go backwards from today to find sunday
    for (var i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }

    return startOfWeek!;
  }

  /*
  convert overall list of expenses into a daily expense summary

  e.g.

  overallExpenseList = [

  [ food, 2023/01/30, $10 ],
  [ hat, 2023/01/30, $15 ],
  [ drinks, 2023/01/31, $1 ],
  [ food, 2023/02/01, $5 ],
  [ food, 2023/02/01, $6 ],
  [ food, 2023/02/03, $7 ],
  [ food, 2023/02/05, $10 ],
  [ food, 2023/02/05, $11 ],

  ]

  ->

  dailyExpenseSummary = 
  
  [
  [20230130: $25],
  [20230131: $1],
  [20230201: $11],
  [20230203: $7],
  [20230205: $21],
  ]

  */
  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
      //date (yyyymmdd) : total expense for that day
    };

    for (var expense in overallExpenseList) {
      String date = convertDateTimetoString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }

    return dailyExpenseSummary; 
  }
}