import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:germinar/models/habit_model.dart';
import 'package:germinar/models/habit_status_model.dart';
import 'package:germinar/scoped_models/MainScopedModel.dart';
import 'package:germinar/utils.dart';
import 'package:scoped_model/scoped_model.dart';

class HabitDetails extends StatelessWidget {
  final Habit habit;
  final HabitDay habitDay;

  HabitDetails({@required this.habit, this.habitDay});

  Widget cardUm() {
    return Card(
      child: Column(
        children: <Widget>[
          habitDay == null
              ? Container()
              : Container(
                  height: 48,
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(child: const Text('Meta do dia')),
                      Text(
                          '${Utils.weekdayAsString(habitDay.day.weekday)}, ${habitDay.day.day}/${habitDay.day.month}'),
                    ],
                  ),
                ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            height: 60,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Text(
                    habit.title,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black38,
                ),
                habitDay != null
                    ? Checkbox(
                        value: habitDay?.done,
                        activeColor: Color(0xffC5E2D0),
                        onChanged: (_) {},
                      )
                    : Container(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(42, 16, 42, 16),
              child: SingleChildScrollView(child: Text(habit.description)),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(42, 24, 42, 16),
            child: ScopedModelDescendant<MainScopedModel>(
              builder: (context, _, mainModel) => GestureDetector(
                child: Text(mainModel.hasHabit(habit.id)
                    ? "Deletar Meta"
                    : "Adicionar ao cronograma"),
                onTap: () {
                  if (mainModel.hasHabit(habit.id)) {
                    // TODO Remover a meta
                  } else {
                    // TODO Mandar pra tela de configurar meta
                  }
                },
              ),
            ),
          ),
          const Divider(indent: 42, endIndent: 42),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.fromLTRB(42, 16, 42, 36),
              child: Text("Compartilhar Meta"),
            ),
            onTap: () {
              // TODO Compartilhar
            },
          ),
        ],
      ),
    );
  }

  Widget tileCustom({String meta, bool action}) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 18, right: 18, bottom: 18),
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: true,
                    title: Text(
                      'HOME',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ),
                  Expanded(child: cardUm()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
