import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:germinar/habit_settings.dart';
import 'package:germinar/my_flutter_app_icons.dart';
import 'package:germinar/scoped_models/main_scoped_model.dart';
import 'package:germinar/utils.dart';
import 'package:scoped_model/scoped_model.dart';

import 'habit_category.dart';
import 'models/habit_day_model.dart';
import 'models/habit_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool tabState = true;
  int _bottomNavigationSelected = 0;

  _onBottomNavigationTapped(int index) {
    setState(() {
      _bottomNavigationSelected = index;
    });
  }

  Widget cardUm() {
    return Card(
      elevation: 5,
      child: Column(
        children: <Widget>[
          Container(
            height: 48,
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(child: const Text('Meta do dia')),
                Text(Utils.dateStringForDay(DateTime.now())),
              ],
            ),
          ),
          ScopedModelDescendant<MainScopedModel>(
            builder: (context, child, mainModel) {
              return mainModel.todaysHabits.length > 0
                  ? Column(
                      children: List<Widget>.generate(
                          mainModel.todaysHabits.length, (i) {
                        return tileCustom(
                            habit: mainModel.getHabitForId(
                                mainModel.todaysHabits[i].habitId),
                            habitDay: mainModel.todaysHabits[i],
                            action: true);
                      }),
                    )
                  : Container(
                      child: Text(
                        "Sem metas pra hoje :) Visite a aba \"Metas\" e adicione uma!",
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(16),
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget tileCustom({@required Habit habit, HabitDay habitDay, bool action}) {
    return GestureDetector(
      child: Container(
        height: 60,
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Se action=true, então é do topo, não deve mostrar data
            habitDay != null && !action
                ? Text(Utils.dateStringForDay(habitDay.day))
                : Container(),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Text(
                    habit.title,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black26,
                ),
                action
                    ? Checkbox(
                        value: true,
                        activeColor: Color(0xffC5E2D0),
                        onChanged: (_) {},
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HabitSettings(habit: habit, habitDay: habitDay)));
      },
    );
  }

  Widget tabs() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffCCCCCC),
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
      height: 56,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  border: tabState
                      ? Border.all(width: 1, color: Color(0xffCCCCCC))
                      : null,
                  color: tabState ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                ),
                height: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('SEMANAL'),
                  ],
                ),
              ),
              onTap: () {
                if (tabState == false) {
                  setState(() {
                    tabState = !tabState;
                  });
                }
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  border: !tabState
                      ? Border.all(width: 1, color: Color(0xffCCCCCC))
                      : null,
                  color: !tabState ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                ),
                height: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('MENSAL'),
                  ],
                ),
              ),
              onTap: () {
                if (tabState == true) {
                  setState(() {
                    tabState = !tabState;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget cardList() {
    return Card(
      elevation: 5,
      child: ScopedModelDescendant<MainScopedModel>(
        child: tabs(),
        builder: (context, child, mainModel) {
          return Column(
            children: <Widget>[
              child,
            ]..addAll(mainModel.nextHabits
                .map((h) => tileCustom(
                    habitDay: h,
                    habit: mainModel.getHabitForId(h.habitId),
                    action: false))
                .toList()),
          );
        },
      ),
    );
  }

  Widget metasTab() {
    return SingleChildScrollView(
      physics: ScrollPhysics(parent: BouncingScrollPhysics()),
      child: Container(
        child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'METAS',
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(18),
                child: ScopedModelDescendant<MainScopedModel>(
                  builder: (context, child, mainModel) {
                    return Column(
                      children: List<Widget>.generate(
                        mainModel.categories.length,
                        (i) {
                          return GestureDetector(
                            child: Card(
                              elevation: 3,
                              color: Color(0xffC5E2D0),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      mainModel.categories[i].title,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HabitCategory(
                                    categoryId: mainModel.categories[i].id,
                                    categoryName: mainModel.categories[i].title,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget homeTab() {
    return SingleChildScrollView(
      physics: ScrollPhysics(parent: BouncingScrollPhysics()),
      child: Container(
        child: Column(
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
            SizedBox(
              height: 20,
            ),
            cardUm(),
            SizedBox(
              height: 20,
            ),
            cardList()
          ],
        ),
      ),
    );
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
        child: _bottomNavigationSelected == 0 ? homeTab() : metasTab(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xff389C84),
        onTap: _onBottomNavigationTapped,
        currentIndex: _bottomNavigationSelected,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(MyIcons.home),
            title: Text(
              "Home",
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(MyIcons.metas),
            title: Text("Metas"),
          ),
        ],
      ),
    );
  }
}
