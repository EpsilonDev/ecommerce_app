import 'package:ecommerce_app/ui/models/user.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final User user;
  final List<dynamic> categories;

  AppState({@required this.user, @required this.categories});

  factory AppState.initial() {
    return AppState(
      user: null,
      categories: []
    );
  }
}