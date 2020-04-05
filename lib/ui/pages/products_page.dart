import 'package:ecommerce_app/ui/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';



class ProductsPage extends StatefulWidget {

  final void Function() onInit;

  ProductsPage({ this.onInit });

  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {

  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

//  _getUser() async {
//    final prefs = await SharedPreferences.getInstance();
//    final storedUser = prefs.getString('user');
//    print(json.decode(storedUser));
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              centerTitle: true,
              title: SizedBox(child: state.user != null ? Text(state.user.username, style: TextStyle(color: Colors.white),) : Text(''),),
            );
        },
    ),
      ),
    );
  }
}