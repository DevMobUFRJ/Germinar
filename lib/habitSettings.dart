import 'package:flutter/material.dart';

class HabitSettings extends StatefulWidget {
  @override
  _HabitSettingsState createState() => _HabitSettingsState();
}

class _HabitSettingsState extends State<HabitSettings> {
//  _deleteConfirmation(){
//    showDialog(
//      context: context,
//      builder: (BuildContext context){
//        return AlertDialog(
//
//        )
//      }
//    );
//  }

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
                          SizedBox(height: 18),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Meta do dia'),
                              Text('terça, 12/06'),
                            ],
                          ),
                          SizedBox(height: 18),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Usar transporte público'),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.black26,
                                  ),
                                  Checkbox(
                                    value: true,
                                    activeColor: Color(0xffC5E2D0),
                                    onChanged: (_) {},
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 18),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Text(
                              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
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
                                children: <Widget>[Text('Deletar meta')],
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
