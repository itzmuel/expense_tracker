import 'package:expense_tracker/models/expense_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase {
  // reference the box i created in main
  final _myBox = Hive.box("expense_database");

  // write data
  void saveData(List<ExpenseItem> allExpense){

    /*
    Google said Hive can only store strings and datetime and not custom objects
    */

    List<List<dynamic>>allExpensesFormatted = [];

    for (var expense in allExpense) {
      // convert each expenseItem to list of storable types

      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

    // store the database
    _myBox.put("All_EXPENSES", allExpensesFormatted);
  }

  //read data
  List<ExpenseItem> readData() {
    List savedExpenses = _myBox.get("All_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];

    for (var i = 0; i < savedExpenses.length; i++) {
      // collect the individual expense data ive listed
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      //create expense item
      ExpenseItem expense = 
      ExpenseItem(
        name: name, 
        amount: amount, 
        dateTime: dateTime,
      );

      // add expense to overall
      allExpenses.add(expense);
      
    }
    return allExpenses;
  }
}