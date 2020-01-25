import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:flutter_tags/tag.dart';

import '../../models/recipe.dart';
import './expandable_widget.dart';
import './recipe_app_bar.dart';
import './editable_text_field.dart';
import '../../globals/utils.dart';

class RecipeView extends StatefulWidget {
  final Recipe _recipe;

  RecipeView(this._recipe);

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  bool _editEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          RecipeAppBar(
            widget._recipe,
            editModeEnabled: _editEnabled,
            onRecipeEditEnabled: (editEnabled) => setState(() {
              _editEnabled = editEnabled;
            }),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 5,
              ),
              EditableTextField(
                widget._recipe.description,
                editEnabled: _editEnabled,
                hintText: "Description",
              ),
              SizedBox(
                height: 5,
              ),
              Text("Information"),
              Card(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 10,
                    height: 100,
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            EditableTextField(
                              "2",
                              editEnabled: _editEnabled,
                              icon: Icon(Icons.people),
                              hintText: "Servs",
                              maxLines: 1,
                              minLines: 1,
                            ),
                            EditableTextField(
                              "12 min",
                              editEnabled: _editEnabled,
                              icon: Icon(Icons.timer),
                              maxLines: 1,
                              minLines: 1,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            EditableTextField(
                              "3/5",
                              editEnabled: _editEnabled,
                              icon: Icon(Icons.attach_money),
                              maxLines: 1,
                              minLines: 1,
                            ),
                            EditableTextField(
                              "3/5",
                              editEnabled: _editEnabled,
                              icon: Icon(Icons.attach_money),
                              maxLines: 1,
                              minLines: 1,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Text("Ingredients"),
              ...widget._recipe.ingredients
                  .map(
                    (ing) => Card(
                      child: ListTile(
                        leading: Padding(
                          padding: EdgeInsets.all(8),
                          child: Image.asset("assets/icons/supermarket.png"),
                        ),
                        title: Text(ing.name),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              ing.quantity.toStringAsFixed(0),
                              style: TextStyle(
                                fontSize: 27,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              ing.unitOfMeasure,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
              Text("Prepation"),
              EditableTextField(
                "",
                editEnabled: _editEnabled,
                hintText: "Add preparation steps...",
                maxLines: 1000,
              ),
              Text("Notes"),
              EditableTextField(
                "",
                editEnabled: _editEnabled,
                hintText: "Add note...",
                maxLines: 1000,
              ),
              Text("Tags"),
              Tags(
                itemBuilder: (index) => ItemTags(
                  image: ItemTagsImage(
                    child: Icon(
                      Icons.local_offer,
                      color: Colors.white,
                    ),
                  ),
                  title: widget._recipe.tags[index],
                  color: getColorForString(widget._recipe.tags[index]),
                  combine: ItemTagsCombine.withTextAfter,
                  index: index,
                  textScaleFactor: 1.5,
                ),
                itemCount: widget._recipe.tags.length,
              )
            ]),
          ),
        ],
      ),
    );
  }
}
