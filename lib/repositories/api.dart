import 'package:money_manager/models/transaction.dart';
import '../models/login.dart';

abstract class Api {
 Future<bool> checkLogin(Login login) ;

 Future<double> getTotal();

 Future<List<String>> getMonths();

 Future<List<Transaction>> getTransactions(String month);

 Future<void>addTransaction(Transaction transaction);

 Future<void>editTransaction(Transaction transaction);

 Future<void>deleteTransaction(String dateTime);

}