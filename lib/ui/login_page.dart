import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isSubmitting = false, _obscureText = true;
  String _email, _pwd;


  void _registerUser() async {

    setState(() {
      _isSubmitting = true;
    });

    http.Response response = await http.post(
      'http://10.0.3.2:1337/auth/local/',
      body: {
        "identifier": _email,
        "password": _pwd
      }
    );

    var responseData = json.decode(response.body);
    print(responseData);

    if(response.statusCode == 200) {
        setState(() {
          _isSubmitting = false;
        });
      _showSnackBar();
      _formKey.currentState.reset();
    } else {
        setState(() {
          _isSubmitting = false;
        });
        final errorMessage = responseData['message'];
        _showErrorSnackBar(errorMessage);
        _formKey.currentState.reset();
        //throw Exception('Error loggin: $errorMessage');
    }
  }

   void _showErrorSnackBar(message) {
    final _snackBar = SnackBar(content: Text('$message', style: TextStyle(color: Colors.white),), backgroundColor: Theme.of(context).primaryColor,);
    _scaffoldKey.currentState.showSnackBar(_snackBar);
  } 

  void _showSnackBar() {
    final _snackBar = SnackBar(content: Text('User: successfully logged in !', style: TextStyle(color: Colors.white),), backgroundColor: Theme.of(context).primaryColor,);
    _scaffoldKey.currentState.showSnackBar(_snackBar);
  }



  void _onSubmit() {
    if( _formKey.currentState.validate() ) {
      _formKey.currentState.save();
      _registerUser();
      print('$_email, $_pwd');
    } else {
      print('Invalid');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Center(child: Text('Login')),),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Login', style: Theme.of(context).textTheme.headline),
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
                _isSubmitting ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),) : RaisedButton.icon(
                  onPressed: _onSubmit,
                  icon: Icon(Icons.done, color: Colors.white),
                  color: Theme.of(context).primaryColor,
                  label: Text('Submit', style: TextStyle(color: Colors.white),),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)))     
                ),
                FlatButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
                  child: Text('New user ? Register')
                )    
              ],
            )),
          )
        ),
      ),
    );
  }
}