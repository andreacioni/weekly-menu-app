import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:provider/provider.dart';

import '../../providers/recipes_provider.dart';
import './add_ingredient_button.dart';
import './recipe_ingredient_tile/dismissible_recipe_ingredient.dart';
import '../recipe_view/recipe_information_tiles.dart';
import '../../models/recipe.dart';
import './recipe_app_bar.dart';
import './recipe_tags.dart';
import './editable_text_field.dart';
import '../../globals/utils.dart';

class RecipeView extends StatefulWidget {
  final Object _heroTag;

  RecipeView(this._heroTag);

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  bool _editEnabled = false;
  double spinner = 0;

  @override
  Widget build(BuildContext context) {
    final Recipe recipe = Provider.of<Recipe>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          RecipeAppBar(
            recipe,
            widget._heroTag,
            editModeEnabled: _editEnabled,
            onRecipeEditEnabled: (editEnabled) => _handleEditToggle(recipe, editEnabled)
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 5,
              ),
              EditableTextField(
                recipe.description,
                editEnabled: _editEnabled,
                hintText: "Description",
                onSubmitted: (newDescription) => recipe.updateDescription(newDescription),
                
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Information",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child:
                      RecipeInformationTiles(recipe, editEnabled: _editEnabled),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Ingredients",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              if (recipe.ingredients.isEmpty && !_editEnabled)
                EditableTextField(
                  "",
                  editEnabled: false,
                  hintText: "No ingredients",
                ),
              if (recipe.ingredients.isNotEmpty)
                ...recipe.ingredients
                    .map((recipeIng) => ChangeNotifierProvider.value(
                          value: recipeIng,
                          child: DismissibleRecipeIngredientTile(_editEnabled),
                        ))
                    .toList(),
              if (_editEnabled)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AddIngredientButton(recipe),
                ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Prepation",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              EditableTextField(
                recipe.preparation,
                editEnabled: _editEnabled,
                hintText: "Add preparation steps...",
                maxLines: 1000,
                onChanged: (text) => recipe.updatePreparation(text),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Notes",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              EditableTextField(
                recipe.note,
                editEnabled: _editEnabled,
                hintText: "Add note...",
                maxLines: 1000,
                onChanged: (text) => recipe.updateNote(text),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Tags",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              RecipeTags(
                recipe: recipe,
                editEnabled: _editEnabled,
              ),
              SizedBox(
                height: 5,
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void _handleEditToggle(Recipe recipe, bool editEnabled) {
    if(!editEnabled && (recipe.isResourceEdited || (recipe.ingredients.indexWhere((recipeIng) => recipeIng.isResourceEdited) != -1))) {
      //When switching from 'editEnabled = true' to 'editEnabled = false' means we must update resource on remote (if needed)
      recipe.save();
    }

    setState(() => _editEnabled = editEnabled);
  }
}
