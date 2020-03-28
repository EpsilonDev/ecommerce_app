import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();
  String _username, _email, _pwd;

  void _onSubmit() {
    if( _formKey.currentState.validate() ) {
      _formKey.currentState.save();
      print('$_username, $_email, $_pwd');
    } else {
      print('Invalid');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    obscureText: true,
                    onSaved: (val) => _pwd = val,
                    validator: (val) => val.length < 6 ? ('Password too short') : null,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      icon: Icon(Icons.lock),
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
                  onPressed: () => print('Login'),
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