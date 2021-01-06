/*
  no checked if email is already in the database but the program gets the first email that was registered
  good emough for prototype just make sure not to make the mistake while presenting 
*/

import 'package:donation/main.dart';
import 'package:donation/styles/styles.dart';
import 'package:donation/database/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class signup extends StatefulWidget {
  @override
  _signup createState() => _signup();
}

class _signup extends State<signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //strings that will be used
  String _username;
  String _name;
  String _school;
  String _yearLevel;
  String _email;
  String _password;
  String _photo;

  //controllers
  final _usernameCon = new TextEditingController();
  final _nameCon = new TextEditingController();
  final _yearCon = new TextEditingController();
  final _emailCon = new TextEditingController();
  final _passwordCon = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          appBar: AppBar(
            title: Text('Sign up'),
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                }),
          ),
          backgroundColor: Colors.white,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 50.0),
                      child: new Form(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          /*
                          //logo image
                          Container(
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: 100,
                              width: 100,
                            ),
                            alignment: Alignment(0, -0.8),
                          ),
                          SizedBox(height: 50.0), //space between logo and text
                          */
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //username
                              Text('Username'),
                              SizedBox(
                                  height:
                                      10.0), //space between name text and textformfield
                              Container(
                                  decoration: textBox,
                                  height: 40.0,
                                  width: 300.0,
                                  child: TextFormField(
                                    controller: _usernameCon,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          top: 2.0, bottom: 2.0, left: 10.0),
                                      hintText: 'Userame*',
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Userame is Required';
                                      }
                                      return null;
                                    },
                                  )),
                              SizedBox(
                                height: 30,
                              ), //space between name and school

                              Text('Name'),
                              SizedBox(
                                  height:
                                      10.0), //space between name text and textformfield
                              Container(
                                  decoration: textBox,
                                  height: 40.0,
                                  width: 300.0,
                                  child: TextFormField(
                                    controller: _nameCon,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          top: 2.0, bottom: 2.0, left: 10.0),
                                      hintText: 'Name*',
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Userame is Required';
                                      }
                                      return null;
                                    },
                                  )),
                              SizedBox(
                                height: 30,
                              ), //space between name and school

                              //school
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('School'),
                                  SizedBox(
                                    height: 2.0,
                                  ), //space between school text and dropdown
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: 40.0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 2.0, bottom: 2.0, left: 1.0),
                                      child: DropdownButton<String>(
                                        hint: Text('Select School'),
                                        value: _school,
                                        isExpanded: true,
                                        onChanged: (String value) {
                                          setState(() {
                                            _school = value;
                                          });
                                        },
                                        items: [
                                          DropdownMenuItem<String>(
                                            value:
                                                'Ateneo de Manila University',
                                            child: Text(
                                                'Ateneo de Manila University'),
                                          ),
                                          DropdownMenuItem(
                                              value: 'De La Salle University',
                                              child: Text(
                                                  'De La Salle University')),
                                          DropdownMenuItem(
                                              value:
                                                  'De La Salle - College of Saint Benilde',
                                              child: Text(
                                                  'De La Salle - College of Saint Benilde')),
                                          DropdownMenuItem(
                                              value: 'Mapua University',
                                              child: Text('Mapua University')),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              //year
                              SizedBox(
                                height: 30,
                              ), //space between school and year
                              Text('Year'),
                              SizedBox(
                                  height:
                                      10.0), //space between year text and textformfield
                              Container(
                                  decoration: textBox,
                                  height: 40.0,
                                  width: 300.0,
                                  child: TextFormField(
                                    controller: _yearCon,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          top: 2.0, bottom: 2.0, left: 10.0),
                                      hintText: 'Year*',
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Year is Required';
                                      }
                                      return null;
                                    },
                                  )),

                              //email
                              SizedBox(
                                height: 30,
                              ), //space between year and email
                              Text('Email'),
                              SizedBox(
                                  height:
                                      10.0), //space between email text and textformfield
                              Container(
                                  decoration: textBox,
                                  height: 40.0,
                                  width: 300.0,
                                  child: TextFormField(
                                    controller: _emailCon,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          top: 2.0, bottom: 2.0, left: 10.0),
                                      hintText: 'Email*',
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Email is Required';
                                      }
                                      return null;
                                    },
                                  )),

                              //password
                              SizedBox(
                                height: 30,
                              ), //space between year and email
                              Text('Password'),
                              SizedBox(
                                  height:
                                      10.0), //space between email text and textformfield
                              Container(
                                  decoration: textBox,
                                  height: 40.0,
                                  width: 300.0,
                                  child: TextFormField(
                                    controller: _passwordCon,
                                    obscureText: true, // make password *
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          top: 2.0, bottom: 2.0, left: 10.0),
                                      hintText: 'Password*',
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Password is Required';
                                      }
                                      return null;
                                    },
                                  )),
                              /*
                              //photo
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                  vertical: 20.0,
                                ),
                                child: RaisedButton(
                                  child: Text('Upload Photo'),
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  onPressed: () {
                                    // _saveImage();
                                  },
                                ),
                              ),
                              */
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
                                    _username = _usernameCon.text;
                                    _name = _nameCon.text;
                                    _yearLevel = _yearCon.text;
                                    _email = _emailCon.text;
                                    _password = _passwordCon.text;
                                    _insert(); //database
                                    _createRequestTable();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home()));
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
                    ),
                  ),
                ],
              )),
        ));
  }

  _insert() async {
    Database db = await dbHelper.createInstance().insertInfo();
    Map<String, dynamic> toMap() => {
          "username": _username,
          "name": _name,
          "school": _school,
          "year": _yearLevel,
          "email": _email,
          "password": _password,
        };
    return await db.insert(dbHelper.table1, toMap());
  }

  Future<Database> _createRequestTable() async {
    String path = p.join(await getDatabasesPath(), "$_username.db");
    return openDatabase(path, version: 1, onCreate: _userDonationRequest);
  }

  void _userDonationRequest(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS Request(name, school, year, need, fundsCollected, fundsNeed, message, location)");
  }

/*
  void _saveImage() async {
    File _image;
    final ImagePicker _picker = ImagePicker();

    //get image from gallery
    final PickedFile photo =
        await _picker.getImage(source: ImageSource.gallery);

    File tmpFile = File(photo.path);

    //save to path
    final String path = 'assets/images';
    final String fileName = _username;

    tmpFile = await tmpFile.copy('$path/$fileName.png');

    setState(() {
      _image = tmpFile;
    });
  }
  */
}
