import 'package:ecommerce_app/ui/models/app_state.dart';
import 'package:ecommerce_app/ui/models/user.dart';
import 'package:ecommerce_app/ui/redux/actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    user: userReducer(state.user, action),
    categories: categoriesReducer(state.categories ,action)
      );
    }
    
User userReducer(User user, dynamic action) {
  if (action is GetUserAction) {
    return action.user;
  } 
  return user;
}

categoriesReducer(categories, action) {
  if (action is GetCategoriesAction) {
    return action.categories;
  }
  return categories;
}