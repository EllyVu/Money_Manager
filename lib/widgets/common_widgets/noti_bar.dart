import 'package:flutter/material.dart';

SnackBar notiBarErorr(String message, bool isError,){
  return SnackBar(content: Text(message ),backgroundColor: isError? Colors.redAccent : Colors.black,);
}

SnackBar notiBarDone(String message, bool isDone){
  return SnackBar(content: Text(message), backgroundColor: isDone? Colors.lightBlue : Colors.brown,);
}