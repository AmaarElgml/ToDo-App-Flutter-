import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/cubit/cubit.dart';
import 'package:todo_app/cubit/states.dart';

import '../constants.dart';
import '../widgets/custom_text_field.dart';

class HomePage extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {
          if (state is AppInsertToDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                cubit.titles[cubit.currentIndex],
                style: titleStyle,
              ),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(cubit.fabIcon),
              backgroundColor: kPrimaryColor,
              onPressed: () {
                if (cubit.isSheetShown) {
                  if (formKey.currentState.validate()) {
                    cubit.insertToDatabase(
                      title: titleController.text,
                      date: dateController.text,
                      time: timeController.text,
                    );
                  }
                } else {
                  scaffoldKey.currentState
                      .showBottomSheet(
                          (context) => Container(
                                color: Colors.grey[100],
                                padding: EdgeInsets.all(20.0),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomTextField(
                                        titleController: titleController,
                                        hint: 'Task Title',
                                        icon: Icons.title,
                                        type: TextInputType.text,
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomTextField(
                                              titleController: timeController,
                                              hint: 'Task Date',
                                              icon: Icons.date_range,
                                              type: TextInputType.datetime,
                                              onTap: () {
                                                showTimePicker(
                                                        context: context,
                                                        initialTime:
                                                            TimeOfDay.now())
                                                    .then((value) {
                                                  timeController.text = value
                                                      .format(context)
                                                      .toString();
                                                }).catchError(
                                                  (error) {
                                                    print(
                                                        'Error when showing the time picker ${error.toString()}');
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: CustomTextField(
                                              titleController: dateController,
                                              hint: 'Task Time',
                                              icon: Icons.timer_rounded,
                                              type: TextInputType.datetime,
                                              onTap: () {
                                                showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.now()
                                                      .add(Duration(days: 90)),
                                                ).then((value) {
                                                  dateController.text =
                                                      DateFormat.yMMMd()
                                                          .format(value);
                                                }).catchError(
                                                  (error) {
                                                    print(
                                                        'Error when showing the date picker ${error.toString()}');
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                          elevation: 8.0)
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 2,
              backgroundColor: Colors.white,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeCurrentIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.list_bullet),
                    label: cubit.titles[cubit.currentIndex]),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.check_mark_circled),
                    label: cubit.titles[cubit.currentIndex]),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined),
                    label: cubit.titles[cubit.currentIndex]),
              ],
            ),
            body: state is AppGetDatabaseLoadingState
                ? Center(child: CircularProgressIndicator())
                : cubit.pages[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
