import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/widgets/sreens/add_edit/add_edit_screen.dart';
import 'package:money_manager/widgets/sreens/detail/detail_screen.dart';
import 'package:money_manager/widgets/sreens/list_item/list_item_cubit.dart';
import 'package:money_manager/widgets/sreens/list_item/list_item_screen.dart';
import 'package:money_manager/widgets/sreens/login/login_screen.dart';

Route<dynamic>? mainRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.route:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case ListItemScreen.route:
      return MaterialPageRoute(builder: (context) => ListItemScreen());
    case DetailScreen.route:
     // return MaterialPageRoute(builder: (context) => DetailScreen());
     var cubit = (settings.arguments as Map<String, dynamic>)['cubit'] as ListItemCubit;
      return MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: cubit,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Detail"),
            ),
            body: DetailScreen(),
          ),
        ),
      );
    case AddEditScreen.route:
      return MaterialPageRoute(builder: (context) => AddEditScreen());
    default:
      return MaterialPageRoute(builder: (context) => LoginScreen());
  }
}
