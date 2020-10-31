import 'package:flutter/material.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_data_state/flutter_data_state.dart';
import 'package:provider/provider.dart';

import '../../models/ingredient.dart';
import '../../providers/ingredients_provider.dart';

class IngredientsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final repository = context.watch<Repository<Ingredient>>();

    return Scaffold(
      appBar: _buildAppBar(context),
      body: DataStateBuilder<List<Ingredient>>(
          notifier: () => repository.watchAll(),
          builder: (context, state, notifier, _) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return RefreshIndicator(
              onRefresh: () async => notifier.reload(),
              child: ListView.builder(
                itemBuilder: (_, index) {
                  return Dismissible(
                    key: ValueKey(state.model[index].id),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (dd) => _showDismissDialog(context, dd),
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Icon(
                            Icons.delete,
                            size: 30,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(state.model[index].name),
                        ),
                        Divider(
                          height: 0,
                        ),
                      ],
                    ),
                    onDismissed: (_) =>
                        _deleteIngredient(context, state.model[index]),
                  );
                },
                itemCount: state.model.length,
              ),
            );
          }),
    );
  }

  Future<bool> _showDismissDialog(
      BuildContext context, DismissDirection direction) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text(
            'This will also remove all related recipe ingredients and shop. list item'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('NO'),
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('YES'),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Ingredients'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {},
        )
      ],
    );
  }

  void _deleteIngredient(BuildContext context, Ingredient ingredient) {
    ingredient.delete();
  }
}
