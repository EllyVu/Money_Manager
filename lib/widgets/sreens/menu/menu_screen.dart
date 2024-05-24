import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/common/enum/drawer_item.dart';
import 'package:money_manager/main_cubit.dart';

class MenuScreen extends StatelessWidget {
  static const String route = "MenuScreen";

  @override
  Widget build(BuildContext context) {
    return Page();
  }
}

class Page extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Container(
          child: Column(
            children: [
              ListTile(title: const Text('Home'),
              trailing: state.selected != DrawerItem.Home ? const Icon(Icons.navigate_next) : null,
              onTap:(){
                context.read<MainCubit>().setSelected(DrawerItem.Home);
                Navigator.pop(context);
              } ,
              ),
              ListTile(title:const Text('Settings'),
                trailing: state.selected != DrawerItem.Setting ? const Icon(Icons.navigate_next) : null,
                onTap:(){
                  context.read<MainCubit>().setSelected(DrawerItem.Setting);
                  Navigator.pop(context);
                } ,
              ),
            ],
          ),
        );
      },
    );
  }
}
