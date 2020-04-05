import 'package:ecommerce_app/ui/models/user.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final User user;

  AppState({@required this.user});

  factory AppState.initial() {
    return AppState(
      user: null,
    );
  }
}