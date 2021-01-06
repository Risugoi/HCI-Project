import 'package:donation/home.dart';
import 'package:donation/database/requestdb.dart';
import 'package:donation/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:donation/database/feeddb.dart';

class donation extends StatefulWidget {
//get username
  final String username;
  final String name;
  final String school;
  final String year;

  const donation({Key key, this.username, this.name, this.school, this.year})
      : super(key: key);
  @override
  _requestForm createState() => _requestForm();
}

class _requestForm extends State<donation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //strings that will be used
  String _name;
  String _school;
  String _year;
  String _need;
  String _fundsCollected = "0";
  String _fundsNeed;
  String _message;
  String _location;
  //controllers
  //final _nameCon = new TextEditingController();
  final _needCon = new TextEditingController();
  final _fundsCon = new TextEditingController();
  final _messageCon = new TextEditingController();
  final _locCon = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
          appBar: AppBar(
              title: Text('Create Form'),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => home()));
                  })),
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 50.0),
                    child: new Form(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //need
                            Container(
                              decoration: textBox,
                              height: 40.0,
                              width: 300.0,
                              child: TextFormField(
                                  controller: _needCon,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: 2.0, bottom: 2.0, left: 1.0),
                                    hintText: 'Required Item*',
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'need is required';
                                    }
                                    return null;
                                  }),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),

                            //message
                            Container(
                              decoration: textBox,
                              height: 250,
                              width: 300,
                              child: TextFormField(
                                controller: _messageCon,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      top: 2.0,
                                      bottom: 2.0,
                                      left: 2.0,
                                      right: 2.0),
                                  hintText: 'Message to donors*',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'message is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),

                            //location
                            Container(
                              decoration: textBox,
                              height: 40,
                              width: 300,
                              child: TextFormField(
                                controller: _fundsCon,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      top: 2.0,
                                      bottom: 2.0,
                                      left: 2.0,
                                      right: 2.0),
                                  hintText:
                                      'Total Funds Required/ Number of Items*',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Location is required';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            SizedBox(
                              height: 20.0,
                            ),

                            //location
                            Container(
                              decoration: textBox,
                              height: 40,
                              width: 300,
                              child: TextFormField(
                                controller: _locCon,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      top: 2.0,
                                      bottom: 2.0,
                                      left: 2.0,
                                      right: 2.0),
                                  hintText: 'Location*',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Location is required';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            //submit button
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 20.0,
                              ),
                              width: 300.0,
                              child: RaisedButton(
                                child: Text(
                                  "Submit",
                                ),
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onPressed: () {
                                  _name = widget.name.toString();
                                  _school = widget.school.toString();
                                  _year = widget.year.toString();
                                  _need = _needCon.text;
                                  _fundsNeed = _fundsCon.text;
                                  _message = _messageCon.text;
                                  _location = _locCon.text;
                                  _insert();
                                  _insertFeed();
                                  _successRequest(context);
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    )),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget _successRequest(BuildContext context) {
    //buttons
    Widget button = FlatButton(
      child: Text('Ok'),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => home()));
      },
    );

    //words
    AlertDialog message = AlertDialog(
      title: Text("Request Successful"),
      content: Text("Donation Request Successfully Posted"),
      actions: [button],
    );

    //show box
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return message;
        });
  }

  _insert() async {
    Database db = await requestdb
        .createInstance()
        .insertRequest(widget.username.toString());
    Map<String, dynamic> toMap() => {
          "name": _name,
          "school": _school,
          "year": _year,
          "need": _need,
          "fundsCollected": _fundsCollected,
          "fundsNeed": _fundsNeed,
          "message": _message,
          "location": _location,
        };
    return await db.insert(requestdb.table, toMap());
  }

  _insertFeed() async {
    Database db = await feeddb.createInstance().insertFeed();
    Map<String, dynamic> toMap() => {
          "name": _name,
          "school": _school,
          "need": _need,
          "fundsCollected": _fundsCollected,
          "fundsNeed": _fundsNeed
        };
    return await db.insert(feeddb.table1, toMap());
  }
}
