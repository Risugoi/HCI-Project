import 'package:donation/home.dart';
import 'package:donation/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class donationRequestInfo extends StatefulWidget {
  _requestInfo createState() => _requestInfo();
}

class _requestInfo extends State<donationRequestInfo> {
  double _progress = 0.7;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
          appBar: AppBar(
            title: Text('Name'),
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => home()));
                }),
          ),
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                    child: new Form(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Container(
                            child: Image.asset(
                              'assets/images/icon.png',
                            ),
                            height: 100,
                            width: 100,
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text('Name'),
                                ),
                                Container(
                                  child: Text('School'),
                                ),
                              ],
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: 80,
                        ),
                        Container(
                          child: Text('Info'),
                        ),
                        SizedBox(
                          height: 250,
                        ),
                        //progress bar box
                        Container(
                          decoration: textBox,
                          height: 80,
                          width: 300,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Text("Funds Raised: "),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: Text('Some Amount'),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              //progress bar
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 250,
                                      child: LinearProgressIndicatorApp(),
                                    ),
                                    Text('80.0%')
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 20.0,
                                ),
                                width: 220,
                                child: RaisedButton(
                                  child: Text('Donate'),
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20.0),
                                width: 60,
                                child: RaisedButton(
                                  child: Text("Chat"),
                                  padding: EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  onPressed: () {},
                                ),
                              )
                            ],
                          ),
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
}

class LinearProgressIndicatorApp extends StatelessWidget {
  double _progress = 0.8;
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Colors.blue,
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
      value: _progress,
      minHeight: 20,
    );
  }
}
