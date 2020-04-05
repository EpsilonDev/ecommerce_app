import 'dart:convert';

import 'package:ecommerce_app/ui/models/app_state.dart';
import 'package:ecommerce_app/ui/models/user.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux/redux.dart';

ThunkAction<AppState> getUserAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final String storedUser = prefs.getString("user");
  print(storedUser);
  final user = storedUser!=null ? User.fromJson(jsonDecode(storedUser)) : null;


  store.dispatch(GetUserAction(user));
  };
  
  class GetUserAction {
    final User _user;

    GetUserAction(this._user);

    User get user => this._user;
}