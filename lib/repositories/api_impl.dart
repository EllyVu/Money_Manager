import 'package:money_manager/models/login.dart';
import 'package:money_manager/models/transaction.dart';
import 'package:money_manager/repositories/api.dart';

import 'log.dart';

class ApiImpl implements Api {
  Log log;

  final List<Transaction> _data = [
    const Transaction(dateTime: "2024-02-15 16:00:00", title: "a", content: "aa", amount: 1000),
    const Transaction(dateTime: "2024-02-17 23:00:00", title: "b", content: "bb", amount: -40),
    const Transaction(dateTime: "2024-02-19 04:00:00", title: "v", content: "vv", amount: -50),
  ];

  ApiImpl(this.log) {
    _data.sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  Future<void> delay() async {
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Future<bool> checkLogin(Login login) async {
    delay();
    if (login.username == 'Elly' && login.password == '1' || login.username == "1" && login.password == '1') {
      return Future(() => true);
    }
    return Future(() => false);
  }

  @override
  Future<void> addTransaction(Transaction transaction) async {
    await delay();
    for (int i = 0; i < _data.length; i++) {
      if (_data[i].dateTime == transaction.dateTime) {
        throw Exception("Duplicate data");
      }
    }
    _data.add(transaction);
    _data.sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  @override
  Future<void> deleteTransaction(String dateTime) async {
    await delay();
    for (int i = 0; i < _data.length; i++) {
      if (_data[i].dateTime == dateTime) {
        _data.removeAt(i);
        return;
      }
    }
    throw Exception("Not found data");
  }

  @override
  Future<void> editTransaction(Transaction transaction) async {
    await delay();
    for (int i = 0; i < _data.length; i++) {
      if (_data[i].dateTime == transaction.dateTime) {
        _data[i] = transaction;
        return;
      }
    }
    throw Exception("Not found data");
  }

  @override
  Future<List<String>> getMonths() async {
    await delay();
    Set<String> r = {};
    for (int i = 0; i < _data.length; i++) {
      var tmp = _data[i].dateTime.substring(0, 7) + "-01 00:00:00";
      r.add(tmp);
    }
    return r.toList();
  }

  @override
  Future<double> getTotal() async {
    await delay();
    double total = 0;
    for (int i = 0; i < _data.length; i++) {
      total += _data[i].amount;
    }
    return total;
  }

  @override
  Future<List<Transaction>> getTransactions(String month) async {
    await delay();
    List<Transaction> r = [];
    for (int i = 0; i < _data.length; i++) {
      var tmp = _data[i].dateTime.substring(0, 7);
      if (month.startsWith(tmp)) r.add(_data[i]);
    }
    return r;
  }
}
