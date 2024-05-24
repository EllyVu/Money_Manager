import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/common/enum/screen_size.dart';
import 'package:money_manager/main_cubit.dart';
import 'package:money_manager/widgets/sreens/detail/detail_screen.dart';
import 'package:money_manager/widgets/sreens/list_item/list_item_cubit.dart';
import 'package:money_manager/widgets/sreens/menu/menu_screen.dart';
import 'package:money_manager/widgets/sreens/setting/setting_screen.dart';
import '../../../common/enum/drawer_item.dart';
import '../../../common/enum/load_status.dart';
import '../../../common/utils.dart';
import '../../../repositories/api.dart';
import '../../common_widgets/noti_bar.dart';

class ListItemScreen extends StatelessWidget {
  static const String route = "ListItemScreen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListItemCubit(context.read<Api>())..loadData(0),
      child: Page(),
    );
  }
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListItemCubit, ListItemState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: CupertinoColors.opaqueSeparator,
            title: const Text("Money Manager"),
          ),
          body: Body(),
          drawer: state.screenSize == ScreenSize.Large
              ? null
              : Drawer(
                  child: MenuScreen(),
                ),
        );
      },
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (contextMain, stateMain) {
        return BlocConsumer<ListItemCubit, ListItemState>(
          listener: (context, state) {
            if (state.loadStatus == LoadStatus.Error) {
              ScaffoldMessenger.of(context).showSnackBar(notiBarErorr("Login Error", true));
            }
          },
          builder: (context, state) {
            var screenSize = calculateScreenSize(MediaQuery.sizeOf(context).width);
            context.read<ListItemCubit>().SetScreenSize(screenSize);
            return state.loadStatus == LoadStatus.Loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : stateMain.selected == DrawerItem.Setting && state.screenSize != ScreenSize.Large
                    ? SettingScreen()
                    : switch (state.screenSize) {
                        ScreenSize.Small => const ListItemPage(),
                        ScreenSize.Medium => const ListItemEditPage(),
                        _ => const ListItemEditMenuPage()
                      };
          },
        );
      },
    );
  }
}

class ListItemPage extends StatelessWidget {
  const ListItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListItemCubit, ListItemState>(
      builder: (context, state) {
        var cubit = context.read<ListItemCubit>();
        return Container(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  children: [
                    Expanded(child: Text("${state.total}")),
                    if (state.months.isNotEmpty && state.selectedMoth == 0 && state.selectedMoth < state.months.length)
                      Container()
                    else
                      IconButton(
                        onPressed: () {
                          cubit.loadData(state.selectedMoth - 1);
                        },
                        icon: const Icon(Icons.navigate_before),
                      ),
                    state.months.length > 0 && state.selectedMoth >= 0 && state.selectedMoth < state.months.length
                        ? Text(state.months[state.selectedMoth].substring(0, 7))
                        : Container(),
                    if (state.months.isEmpty && state.selectedMoth >= 0 && state.selectedMoth == state.months.length - 1)
                      Container()
                    else
                      IconButton(
                        onPressed: () {
                          cubit.loadData(state.selectedMoth + 1);
                        },
                        icon: const Icon(Icons.navigate_next),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    var item = state.trans[index];
                    var cubit = context.read<ListItemCubit>();
                    return Card(
                      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: ListTile(
                        leading: item.amount >= 0
                            ? const Icon(
                                Icons.add,
                                color: Colors.blueAccent,
                              )
                            : const Icon(
                                Icons.remove,
                                color: Colors.redAccent,
                              ),
                        title: Row(
                          children: [
                            Expanded(child: Text(item.title)),
                            Text("${item.amount}"),
                          ],
                        ),
                        subtitle: Text(item.content),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            cubit.removeItem(item.dateTime);
                            if(state.screenSize == ScreenSize.Small){
                              Navigator.of(context).pushNamed(DetailScreen.route , arguments: {'cubit' : cubit} );
                            }
                           // ScaffoldMessenger.of(context).showSnackBar((notiBarDone("Delete Item Success", true)));
                          },
                        ),
                        onTap: (){
                          cubit.setSelectedIdx(index);
                        },
                      ),
                    );
                  },
                  itemCount: state.trans.length,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class ListItemEditPage extends StatelessWidget {
  const ListItemEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: ListItemPage()),
        Expanded(
          child: DetailScreen(),
        )
      ],
    );
  }
}

class ListItemEditMenuPage extends StatelessWidget {
  const ListItemEditMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return state.selected == DrawerItem.Home
            ? Row(
                children: [
                  Expanded(child: MenuScreen()),
                  Expanded(child: ListItemPage()),
                  Expanded(
                    child: DetailScreen(),
                  )
                ],
              )
            : Row(
                children: [
                  Expanded(child: MenuScreen()),
                  Expanded(child: SettingScreen(), flex: 2),
                ],
              );
      },
    );
  }
}
