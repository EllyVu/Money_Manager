import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/widgets/sreens/list_item/list_item_cubit.dart';

class DetailScreen extends StatelessWidget {
  static const String route = "DetailScreen";

  @override
  Widget build(BuildContext context) {
    return Page();
  }
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListItemCubit, ListItemState>(
      builder: (context, state) {
        return state.selectedIdx < 0 || state.trans.length == 0 || state.selectedIdx >= state.trans.length
            ? Container()
            : Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date Time : ${state.trans[state.selectedIdx].dateTime}"),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("Title : ${state.trans[state.selectedIdx].title}"),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("Content : ${state.trans[state.selectedIdx].content}"),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("Amount : ${state.trans[state.selectedIdx].amount}"),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(onPressed: () {}, child: const Text("Edit"))
                  ],
                ),
              );
      },
    );
  }
}
