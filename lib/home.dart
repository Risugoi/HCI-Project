import 'package:donation/database/dbHelper.dart';
import 'package:donation/database/feeddb.dart';
import 'package:donation/database/requestdb.dart';
import 'package:donation/login.dart';
import 'package:flutter/material.dart';
import 'package:donation/requestInfo.dart';
import 'package:donation/donationForm.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class home extends StatefulWidget {
//get info
  final String email;
  const home({Key key, this.email}) : super(key: key);

  @override
  _home createState() => _home();
}

class _home extends State<home> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _username = "";
  String _name = "";
  String _school = "";
  String _year = "";
  int _requests;
  List _feedInfo = [];

  @override
  void initState() {
    super.initState();
    info();
  }

  @override
  Widget build(BuildContext context) {
    _requests = _feedInfo.length;
    print(_feedInfo);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Container(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                        Container(
                          child: Image.asset('assets/images/icon.png'),
                          height: 70,
                          width: 70,
                        ),
                        SizedBox(height: 15),
                        Container(
                          child: Text('$_username'),
                        )
                      ]),
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Profile'),
                ),
                ListTile(
                  title: Text('Donation Request'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => donation(
                                username: _username,
                                name: _name,
                                school: _school,
                                year: _year)));
                  },
                ),
                ListTile(
                  title: Text('My Donation'),
                ),
                ListTile(
                  title: Text('Chat'),
                ),
                ListTile(
                  title: Text('Settings'),
                ),
                ListTile(
                  title: Text('Signout'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => login()));
                  },
                )
              ],
            ),
          ),
          body: new ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: _requests,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                leading: Image.asset('assets/images/icon.png'),
                title: Text(_feedInfo[index].values.elementAt(0)),
                subtitle: Text(_feedInfo[index].values.elementAt(1)),
                trailing: FittedBox(
                  child: Column(
                    children: <Widget>[
                      Text(_feedInfo[index].values.elementAt(2)),
                      Text(((int.parse(_feedInfo[index].values.elementAt(3)) /
                                  int.parse(
                                      _feedInfo[index].values.elementAt(4))) *
                              100)
                          .toString())
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  void info() async {
    try {
      String un = await _getUsername();
      String n = await _getName();
      String s = await _getSchool();
      String y = await _getYear();
      List d = await _getInfo();
      setState(() {
        _username = un;
        _name = n;
        _school = s;
        _year = y;
        _feedInfo = d;
      });
    } catch (e) {
      print('error');
    }
  }

  //get personal info from table
  _getUsername() async {
    String path = p.join(await getDatabasesPath(), dbHelper.dbName);
    var db = await openDatabase(path);
    List<Map> username = await db.rawQuery(
        "SELECT ${dbHelper.username} FROM ${dbHelper.table1} WHERE ${dbHelper.email} = '${widget.email}'");
    return username[0].values.toList()[0];
  }

  _getName() async {
    String path = p.join(await getDatabasesPath(), dbHelper.dbName);
    var db = await openDatabase(path);
    List<Map> name = await db.rawQuery(
        "SELECT ${dbHelper.name} FROM ${dbHelper.table1} WHERE ${dbHelper.email} = '${widget.email}'");
    return name[0].values.toList()[0];
  }

  _getSchool() async {
    String path = p.join(await getDatabasesPath(), dbHelper.dbName);
    var db = await openDatabase(path);
    List<Map> school = await db.rawQuery(
        "SELECT ${dbHelper.school} FROM ${dbHelper.table1} WHERE ${dbHelper.email} = '${widget.email}'");
    return school[0].values.toList()[0];
  }

  _getYear() async {
    String path = p.join(await getDatabasesPath(), dbHelper.dbName);
    var db = await openDatabase(path);
    List<Map> year = await db.rawQuery(
        "SELECT ${dbHelper.year} FROM ${dbHelper.table1} WHERE ${dbHelper.email} = '${widget.email}'");
    return year[0].values.toList()[0];
  }

  //get feed info from table
  _getInfo() async {
    String path = p.join(await getDatabasesPath(), feeddb.dbName);
    var db = await openDatabase(path);
    List<Map> info = await db.rawQuery("SELECT * FROM ${feeddb.table1}");
    return info.toList();
  }
}
