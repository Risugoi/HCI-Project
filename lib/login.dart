import 'package:donation/signup.dart';
import 'package:donation/home.dart';
import 'package:donation/database/dbHelper.dart';
import 'package:donation/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class login extends StatefulWidget {
  @override
  _loginScreen createState() => _loginScreen();
}

class _loginScreen extends State<login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //strings that will be used
  String _email;
  String _password;

  //controllers
  final _emailCon = new TextEditingController();
  final _passwordCon = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
            backgroundColor: Colors.white,
            body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: Stack(children: <Widget>[
                  Container(
                      height: double.infinity,
                      child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 50.0),
                          child: new Form(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                SizedBox(
                                    height:
                                        100), // height of logo from top of the screen
                                //logo image
                                Container(
                                  child: Image.asset(
                                    'assets/images/logo.png',
                                    height: 100,
                                    width: 100,
                                  ),
                                  alignment: Alignment(0, -0.8),
                                ),
                                SizedBox(height: 100), // image to textformfield

                                //email
                                Container(
                                  decoration: textBox,
                                  height: 40,
                                  width: 300,
                                  child: TextFormField(
                                    controller: _emailCon,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          top: 2.0, bottom: 2.0, left: 1.0),
                                      hintText: 'Email',
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Email is Required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(height: 20), // email to password

                                //password
                                Container(
                                  decoration: textBox,
                                  height: 40,
                                  width: 300,
                                  child: TextFormField(
                                    controller: _passwordCon,
                                    obscureText: true, //make password *
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          top: 2.0, bottom: 2.0, left: 1.0),
                                      hintText: 'Password',
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Password is Required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(height: 30), // passowrd to login

                                //login button
                                Container(
                                  child: RaisedButton(
                                      child: Text('Login'),
                                      onPressed: () {
                                        _email = _emailCon.text;
                                        _password = _passwordCon.text;
                                        _checkTable();
                                      }),
                                ),
                                SizedBox(height: 10), // login button to signup

                                //signup button
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Don't Have an Account?  ",
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      signup()));
                                        },
                                        child: Text(
                                          'Signup',
                                          style: TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ))
                                  ],
                                ),
                              ]))))
                ]))));
  }

  Widget loginError() {
    //buttons
    Widget button = FlatButton(
        onPressed: () => Navigator.pop(context, false),
        child: Text('Continue'));

    //words
    AlertDialog message = AlertDialog(
      title: Text('Login Error'),
      content: Text('Invalid Username/password'),
      actions: [button],
    );

    //show the box
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return message;
        });
  }

//check database if user exists
  _checkTable() async {
    String path = p.join(await getDatabasesPath(), dbHelper.dbName);
    var db = await openDatabase(path);
    List<Map> numRows = await db.rawQuery(
        "SELECT COUNT(${dbHelper.email}) FROM ${dbHelper.table1}"); // check if there is existing data
    int getNum = numRows[0].values.elementAt(0);

    //get the number of users with the email
    List<Map> results = await db.rawQuery(
        "SELECT COUNT(*) FROM ${dbHelper.table1} WHERE ${dbHelper.email}='$_email'");
    if (getNum == 0) {
      //empty table
    } else {
      //not empty table
      int userCount = results[0]
          .values
          .elementAt(0); // number of input emails in the database
      if (userCount > 0) {
        // if there are existing emails
        //get their password
        List<Map> storedPassword = await db.rawQuery(
            "Select ${dbHelper.password} FROM ${dbHelper.table1} WHERE ${dbHelper.email}='$_email'");
        String checkPassword = storedPassword[0].values.elementAt(0).toString();

        if (checkPassword == _password) {
          //password match
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => home(email: _email)));
        } else {
          //password failed
          loginError();
        }
      } else {
        // no emails in the database
        print('no data');
        loginError();
      }
    } // not empty table
  }
}
