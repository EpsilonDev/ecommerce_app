import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _obscureText = true;
  String _username, _email, _pwd;


  void _registerUser() async {

    http.Response response = await http.post(
      'http://10.0.3.2:1337/auth/local/register',
      body: {
        "username": _username,
        "email": _email,
        "password": _pwd
      }
    );

    var responseData = json.decode(response.body);
    print(responseData);

    if(response.statusCode == 200) {
      _showSnackBar();
      _formKey.currentState.reset();
    } else {
        final errorMessage = responseData['message'];
        _showErrorSnackBar(errorMessage);
        _formKey.currentState.reset();
        throw Exception('Error registering: $errorMessage');
    }
  }

   void _showErrorSnackBar(message) {
    final _snackBar = SnackBar(content: Text('$message', style: TextStyle(color: Colors.white),), backgroundColor: Theme.of(context).primaryColor,);
    _scaffoldKey.currentState.showSnackBar(_snackBar);
  } 

  void _showSnackBar() {
    final _snackBar = SnackBar(content: Text('User: $_username successfully created !', style: TextStyle(color: Colors.white),), backgroundColor: Theme.of(context).primaryColor,);
    _scaffoldKey.currentState.showSnackBar(_snackBar);
  }


  void _onSubmit() {
    if( _formKey.currentState.validate() ) {
      _formKey.currentState.save();
      _registerUser();
    } else {
      print('Invalid');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Center(child: Text('Register')),),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Register', style: Theme.of(context).textTheme.headline),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onSaved: (val) => _username = val,
                    validator: (val) => val.length < 6 ? ('Username too short') : null,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      hintText: 'Minimum lenght 6 character',
                      icon: Icon(Icons.face)
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onSaved: (val) => _email = val,
                    validator: (val) => !val.contains('@') ? ('Invalid email') : null,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter a valid email',
                      icon: Icon(Icons.email)
                    )
                  ),
                ),              
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: _obscureText,
                    onSaved: (val) => _pwd = val,
                    validator: (val) => val.length < 6 ? ('Password too short') : null,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      icon: Icon(Icons.lock),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                      )
                    ),
                  ),
                ),
                RaisedButton.icon(
                  onPressed: _onSubmit,
                  icon: Icon(Icons.send, color: Colors.white),
                  color: Theme.of(context).primaryColor,
                  label: Text('Submit', style: TextStyle(color: Colors.white),),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)))     
                ),
                FlatButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                  child: Text('Existing user ? Login')
                )    
              ],
            )),
          )
        ),
      ),
    );
  }
}