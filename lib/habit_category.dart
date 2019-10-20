import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:germinar/models/habit_config_model.dart';
import 'package:germinar/scoped_models/main_scoped_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/habit_model.dart';

class HabitCategory extends StatefulWidget {
  String categoryName;
  int categoryId;

  HabitCategory({@required this.categoryId, this.categoryName});

  @override
  _HabitCategoryState createState() => _HabitCategoryState();
}

class _HabitCategoryState extends State<HabitCategory> {
  bool actualScreen = false;
  Habit actualHabit;

  _habitClick(Habit habit) {
    setState(() {
      actualScreen = !actualScreen;
      actualHabit = habit;
    });
  }

  _backPressed() {
    setState(() {
      actualScreen = !actualScreen;
    });
  }

  _deleteConfirmation() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Remover meta"),
            content:
                Text("Tem certeza que deseja remover essa meta do cronograma?"),
            actions: <Widget>[
              GestureDetector(
                child: Text("Voltar"),
                onTap: () => Navigator.pop(context),
              ),
              ScopedModelDescendant<MainScopedModel>(
                builder: (context, _, mainModel) {
                  return GestureDetector(
                    child: Container(
                      child: Text("Remover"),
                      padding: EdgeInsets.all(8),
                    ),
                    onTap: () {
                      mainModel.deleteHabitConfig(actualHabit.id).then((_) {
                        Navigator.pop(context);
                      });
                    },
                  );
                },
              ),
            ],
          );
        });
  }

  _addHabitDialog() {
    HabitConfig hConfig = HabitConfig(
        actualHabit.id, false, false, false, false, false, false, false);
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Adicionar meta"),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Marque abaixo os dias da semana da sua meta:"),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: hConfig.monday
                                    ? Color(0xffA5D2B0)
                                    : Colors.transparent),
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "S",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 20),
                            ),
                          ),
                          onTap: () =>
                              setState(() => hConfig.monday = !hConfig.monday),
                        ),
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: hConfig.tuesday
                                    ? Color(0xffA5D2B0)
                                    : Colors.transparent),
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "T",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 20),
                            ),
                          ),
                          onTap: () => setState(
                              () => hConfig.tuesday = !hConfig.tuesday),
                        ),
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: hConfig.wednesday
                                    ? Color(0xffA5D2B0)
                                    : Colors.transparent),
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "Q",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 20),
                            ),
                          ),
                          onTap: () => setState(
                              () => hConfig.wednesday = !hConfig.wednesday),
                        ),
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: hConfig.thursday
                                    ? Color(0xffA5D2B0)
                                    : Colors.transparent),
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "Q",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 20),
                            ),
                          ),
                          onTap: () => setState(
                              () => hConfig.thursday = !hConfig.thursday),
                        ),
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: hConfig.friday
                                    ? Color(0xffA5D2B0)
                                    : Colors.transparent),
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "S",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 20),
                            ),
                          ),
                          onTap: () =>
                              setState(() => hConfig.friday = !hConfig.friday),
                        ),
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: hConfig.saturday
                                    ? Color(0xffA5D2B0)
                                    : Colors.transparent),
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "S",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 20),
                            ),
                          ),
                          onTap: () => setState(
                              () => hConfig.saturday = !hConfig.saturday),
                        ),
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: hConfig.sunday
                                    ? Color(0xffA5D2B0)
                                    : Colors.transparent),
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "D",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 20),
                            ),
                          ),
                          onTap: () =>
                              setState(() => hConfig.sunday = !hConfig.sunday),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
            actions: <Widget>[
              GestureDetector(
                child: Text("Cancelar"),
                onTap: () => Navigator.pop(context),
              ),
              ScopedModelDescendant<MainScopedModel>(
                builder: (context, _, mainModel) {
                  return GestureDetector(
                    child: Container(
                      child: Text("Salvar"),
                      padding: EdgeInsets.all(8),
                    ),
                    onTap: () {
                      mainModel.addHabitConfig(hConfig).then((_) {
                        Navigator.pop(context);
                      });
                    },
                  );
                },
              ),
            ],
          );
        });
  }

  Widget descriptionHabit(Habit habit) {
    return Card(
      child: Container(
        padding: EdgeInsets.only(top: 30, left: 24, right: 24, bottom: 30),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  habit.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.only(right: 8, left: 8),
              child: Text(
                habit.description,
                style: TextStyle(color: Colors.black54),
              ),
            ),
            SizedBox(height: 40),
            ScopedModelDescendant<MainScopedModel>(
                builder: (context, child, mainModel) {
              return GestureDetector(
                child: Card(
                  elevation: 3,
                  color: mainModel.userHasHabit(habit.id)
                      ? Color(0xffE29095)
                      : Color(0xffA5D2B0),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            mainModel.userHasHabit(habit.id)
                                ? 'Remover do cronograma'
                                : 'Adicionar ao cronograma',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  if (mainModel.userHasHabit(habit.id)) {
                    _deleteConfirmation();
                  } else {
                    _addHabitDialog();
                  }
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget habitList(int categoryId) {
    return Card(
      child: ScopedModelDescendant<MainScopedModel>(
        builder: (context, child, mainModel) {
          return Column(
            //Text(mainModel.getHabitForCategoryId(categoryId)[i].title),
            children: List<Widget>.generate(
              mainModel.getHabitForCategoryId(categoryId).length,
              (i) {
                return GestureDetector(
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                mainModel
                                    .getHabitForCategoryId(categoryId)[i]
                                    .title,
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    _habitClick(mainModel.getHabitForCategoryId(categoryId)[i]);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          !actualScreen ? Navigator.of(context).pop() : _backPressed(),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 18, right: 18),
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff389C84),
                Color(0xffCADE87),
              ],
            ),
          ),
          child: SingleChildScrollView(
            physics: ScrollPhysics(parent: BouncingScrollPhysics()),
            child: Container(
              child: Column(
                children: <Widget>[
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: true,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () => !actualScreen
                          ? Navigator.of(context).pop()
                          : _backPressed(),
                    ),
                    title: Text(
                      'METAS: ${widget.categoryName.toUpperCase()}',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(height: 20),
                  !actualScreen
                      ? habitList(widget.categoryId)
                      : descriptionHabit(actualHabit)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
