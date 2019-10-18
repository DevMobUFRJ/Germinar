import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:germinar/habitSettings.dart';
import 'package:germinar/my_flutter_app_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool tabState = true;

  Widget cardUm() {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            height: 48,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  width: 16,
                ),
                Expanded(child: Text('Meta do dia')),
                Text('Terça, 12/06'),
                SizedBox(
                  width: 16,
                )
              ],
            ),
          ),
          tileCustom(meta: 'Usar transporte público', action: true)
        ],
      ),
    );
  }

  Widget tileCustom({String data, String meta, bool action}) {
    return GestureDetector(
      child: Container(
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            data != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 16),
                      Text(data),
                    ],
                  )
                : Container(),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    meta,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Row(
                  children: <Widget>[
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
                        : Container()
                  ],
                ),
                SizedBox(
                  width: 16,
                )
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HabitSettings()));
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
      child: Column(
        children: <Widget>[
          tabs(),
          tileCustom(
              data: 'Terça, 12/16',
              meta: 'Usar transporte público',
              action: false),
          tileCustom(
              data: 'Terça, 12/16',
              meta: 'Usar transporte público',
              action: false),
          tileCustom(
              data: 'Terça, 12/16',
              meta: 'Usar transporte público',
              action: false),
          tileCustom(
              data: 'Terça, 12/16',
              meta: 'Usar transporte público',
              action: false),
          tileCustom(
              data: 'Terça, 12/16',
              meta: 'Usar transporte público',
              action: false),
          tileCustom(
              data: 'Terça, 12/16',
              meta: 'Usar transporte público',
              action: false),
          tileCustom(
              data: 'Terça, 12/16',
              meta: 'Usar transporte público',
              action: false),
          tileCustom(
              data: 'Terça, 12/16',
              meta: 'Usar transporte público',
              action: false),
          tileCustom(
              data: 'Terça, 12/16',
              meta: 'Usar transporte público',
              action: false),
        ],
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
        child: SingleChildScrollView(
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
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(MyIcons.home),
              title: Text(
                "Home",
                style: TextStyle(color: Color(0xff389C84)),
              ),
              activeIcon: Icon(MyIcons.home, color: Color(0xff389C84))
              //Color(0xff389C84)
              ),
          BottomNavigationBarItem(
              icon: Icon(MyIcons.metas), title: Text("Metas")),
        ],
      ),
    );
  }
}
