import 'package:ecommerce_app/ui/models/app_state.dart';
import 'package:ecommerce_app/ui/widgets/categorie_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final categories = StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) {
        return Column(children: [
          Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: new ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.categories.length,
                itemBuilder: (context, index) => new Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    CategorieItem(item: state.categories[index]),
                  ],
                ),
              ),
            ),
          )
        ]);
      });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(16.0),
        constraints: BoxConstraints(maxHeight: 60.0),
        child: categories);
  }
}

class ProductsPage extends StatefulWidget {
  final void Function() onInit;

  ProductsPage({this.onInit});

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
              title: SizedBox(
                child: state.user != null
                    ? Text(
                        state.user.username,
                        style: TextStyle(color: Colors.white),
                      )
                    : Text(''),
              ),
              actions: <Widget>[
                state.user != null
                    ? IconButton(
                        icon: Icon(Icons.exit_to_app),
                        color: Colors.white,
                        onPressed: () => print('pressed'))
                    : Text('')
              ],
            );
          },
        ),
      ),
      body: Categories(),
    );
  }
}
