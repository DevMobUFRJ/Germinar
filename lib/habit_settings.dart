import 'package:flutter/material.dart';
import 'package:germinar/models/habit_day_model.dart';
import 'package:germinar/scoped_models/main_scoped_model.dart';
import 'package:germinar/utils.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/habit_model.dart';

class HabitSettings extends StatefulWidget {
  final Habit habit;
  final HabitDay habitDay;

  /// HabitDay é opcional. Se for passado, mostra a data no topo como meta,
  /// se não, mostra apenas os dados do hábito mesmo.
  HabitSettings({@required this.habit, this.habitDay});

  @override
  _HabitSettingsState createState() => _HabitSettingsState();
}

class _HabitSettingsState extends State<HabitSettings> {
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
                      mainModel.deleteHabitConfig(widget.habit.id).then((_) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    'META DO DIA',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          widget.habitDay == null
                              ? Container()
                              : SizedBox(height: 18),
                          widget.habitDay == null
                              ? Container()
                              : Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Meta do dia'),
                                    Text(Utils.dateStringForDay(
                                        widget.habitDay.day)),
                                  ],
                                ),
                          SizedBox(height: 18),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(child: Text(widget.habit.title)),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black26,
                              ),
                              widget.habitDay != null
                                  ? Checkbox(
                                      value: true,
                                      activeColor: Color(0xffC5E2D0),
                                      onChanged: (_) {},
                                    )
                                  : Container(),
                            ],
                          ),
                          SizedBox(height: 18),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Text(
                              widget.habit.description,
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          SizedBox(height: 36),
                          GestureDetector(
                            child: Container(
                              height: 46,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[Text('Compartilhar meta')],
                              ),
                            ),
                            onTap: () {
                              //TODO: implentar função de compartilhar
                            },
                          ),
                          Divider(),
                          GestureDetector(
                            child: Container(
                              height: 46,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ScopedModelDescendant<MainScopedModel>(
                                    builder: (context, child, mainModel) {
                                      return GestureDetector(
                                        child: Text(mainModel
                                                .userHasHabit(widget.habit.id)
                                            ? "Deletar meta"
                                            : "Adicionar ao cronograma"),
                                        onTap: () {
                                          if (mainModel
                                              .userHasHabit(widget.habit.id)) {
                                            _deleteConfirmation();
                                          } else {
                                            //TODO Mandar pra tela de adicionar meta
                                          }
                                        },
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                            onTap: () => Navigator.of(context).pop(),
                          ),
                          SizedBox(height: 16)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
