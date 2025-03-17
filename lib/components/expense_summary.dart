import 'package:expense_tracker/bar%20graph/bar_graph.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({
    super.key,
    required this.startOfWeek,
    });

    // calculate max amount in bar gra
    double calculateMax(
      ExpenseData value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday,
    ) {
      double? max = 100;

      List<double> values = [
        value.calculateDailyExpenseSummary()[sunday] ?? 0,
        value.calculateDailyExpenseSummary()[monday] ?? 0,
        value.calculateDailyExpenseSummary()[tuesday] ?? 0,
        value.calculateDailyExpenseSummary()[wednesday] ?? 0,
        value.calculateDailyExpenseSummary()[thursday] ?? 0,
        value.calculateDailyExpenseSummary()[friday] ?? 0,
        value.calculateDailyExpenseSummary()[saturday] ?? 0,
      ];

      // sort from small to large
      values.sort();
      // get the max value
      max = values.last * 1.1;

      return max == 0 ? 100 : max;
    }

    // calcu;ate the week total
    double calculateWeek


// jioenvgbreanblvrflhgrpnhv gpvrih gvrhgiler hg;earh gilehfgj;oehrfgb gpiecahgrbviargoahdgbfocahrgapicsrgcba;ishrgpqiac r





  @override
  Widget build(BuildContext context) {
    // get yyyymmdd for each day of this week
    String sunday = convertDateTimetoString(startOfWeek.add(const Duration(days: 0)));
    String monday = convertDateTimetoString(startOfWeek.add(const Duration(days: 1)));
    String tuesday = convertDateTimetoString(startOfWeek.add(const Duration(days: 2)));
    String wednesday = convertDateTimetoString(startOfWeek.add(const Duration(days: 3)));
    String thursday = convertDateTimetoString(startOfWeek.add(const Duration(days: 4)));
    String friday = convertDateTimetoString(startOfWeek.add(const Duration(days: 5)));
    String saturday = convertDateTimetoString(startOfWeek.add(const Duration(days: 6)));


    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          //week total
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Text(
                  'Week Total: '
                  style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('\$200'),
                ],
            ),
          )
          SizedBox(
            height: 200,
            child: MyBarGraph(
              maxY: calculateMax(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday), 
              sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0, 
              monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0, 
              tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0, 
              wedAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0, 
              thurAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0, 
              friAmount: value.calculateDailyExpenseSummary()[friday] ?? 0, 
              satAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0,
            ),
          ),
        ],
      ),
      
    );
  }
  
}