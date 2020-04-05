import 'package:ecommerce_app/ui/models/app_state.dart';
import 'package:ecommerce_app/ui/pages/login_page.dart';
import 'package:ecommerce_app/ui/pages/products_page.dart';
import 'package:ecommerce_app/ui/redux/reducers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'ui/pages/register_page.dart';
import 'ui/redux/actions.dart';

void main() {
  final store = Store<AppState>(appReducer, initialState: AppState.initial(), middleware: [thunkMiddleware]);
  runApp(MyApp(store: store,));

} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Store<AppState> store;

  MyApp({ this.store });

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
        title: 'Ecommerce',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xff3d155f),
          accentColor: Color(0xffdf678c),
          cursorColor: Colors.black,
          textTheme: TextTheme(
            headline: TextStyle( fontSize: 72.0, fontWeight: FontWeight.bold),
            title: TextStyle( fontSize: 36.0, fontStyle: FontStyle.normal),
            body1: TextStyle( fontSize: 18.0)
          )
        ),
        routes: {
          '/login' : (BuildContext context) => LoginPage(),
          '/register' : (BuildContext context) => RegisterPage(),
          '/products' : (BuildContext context) => ProductsPage(
            onInit: () {
              StoreProvider.of<AppState>(context).dispatch(getUserAction);
            },
          )
        },
        home: LoginPage()
      ),
    );
  }
}

