import 'package:flutter/material.dart';

import 'package:weekly_menu_app/widgets/recipe_view/number_text_field.dart';

import '../../models/enums/difficulty.dart';
import '../../models/recipe.dart';

class RecipeInformationTiles extends StatelessWidget {
  final RecipeOriginator _recipe;
  final bool editEnabled;
  final GlobalKey formKey;

  RecipeInformationTiles(this._recipe, {this.editEnabled, this.formKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        EditableInformationTile(
          _recipe.instance.servs?.toDouble(),
          "Servings",
          minValue: 1,
          icon: Icon(
            Icons.people,
            color: Colors.black,
          ),
          editingEnabled: editEnabled,
          suffix: "ppl",
          onChanged: () => {}, //_recipe.setEdited(),
          onSaved: (newValue) => _recipe
              .update(_recipe.instance.copyWith(servs: newValue?.truncate())),
        ),
        EditableInformationTile(
          _recipe.instance.estimatedPreparationTime?.toDouble(),
          "Preparation time",
          icon: Icon(
            Icons.timer,
            color: Colors.blueAccent,
          ),
          editingEnabled: editEnabled,
          suffix: "min",
          onChanged: () => {}, //_recipe.setEdited(),
          onSaved: (newValue) => _recipe.update(_recipe.instance
              .copyWith(estimatedPreparationTime: newValue?.truncate())),
        ),
        EditableInformationTile(
          _recipe.instance.estimatedCookingTime?.toDouble(),
          "Cooking time",
          icon: Icon(
            Icons.timelapse,
            color: Colors.blue,
          ),
          editingEnabled: editEnabled,
          suffix: "min",
          onChanged: () => {}, //_recipe.setEdited(),
          onSaved: (newValue) => _recipe.update(_recipe.instance
              .copyWith(estimatedCookingTime: newValue?.truncate())),
        ),
        ListTile(
          title: Text("Difficulty"),
          leading: Icon(Icons.work, color: Colors.brown.shade400),
          trailing: _buildDifficultyDropdown(context),
        ),
        RecipeInformationLevelSelect(
          "Affinity",
          Icon(Icons.favorite, color: Colors.red.shade300),
          _recipe.instance.rating,
          editEnabled: editEnabled,
          inactiveColor: Colors.grey.withOpacity(0.3),
          activeColor: Colors.red,
          onLevelUpdate: (newLevel) =>
              _recipe.update(_recipe.instance.copyWith(rating: newLevel)),
        ),
        RecipeInformationLevelSelect(
          "Cost",
          Icon(Icons.attach_money, color: Colors.green.shade300),
          _recipe.instance.cost,
          editEnabled: editEnabled,
          inactiveColor: Colors.grey.withOpacity(0.5),
          activeColor: Colors.green,
          onLevelUpdate: (newLevel) =>
              _recipe.update(_recipe.instance.copyWith(cost: newLevel)),
        ),
      ],
    );
  }

  Widget _buildDifficultyDropdown(BuildContext context) {
    return !editEnabled
        ? Text(
            _recipe.instance.difficulty == null
                ? '-'
                : _recipe.instance.difficulty,
            style: const TextStyle(fontSize: 18),
          )
        : DropdownButton<String>(
            value: _recipe.instance.difficulty,
            hint: const Text('Choose'),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black, fontSize: 18),
            onChanged: (String newValue) =>
                _recipe.update(_recipe.instance.copyWith(difficulty: newValue)),
            items: Difficulties.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
  }
}

class RecipeInformationLevelSelect extends StatefulWidget {
  static const LEVELS = 3;

  final int _initialLevel;
  final String _label;
  final Icon _icon;
  final bool editEnabled;
  final Color activeColor;
  final Color inactiveColor;
  final Function(int) onLevelUpdate;

  RecipeInformationLevelSelect(this._label, this._icon, this._initialLevel,
      {this.editEnabled = false,
      this.activeColor = Colors.black,
      this.inactiveColor = Colors.grey,
      @required this.onLevelUpdate});

  @override
  RecipeInformationLevelSelectState createState() =>
      RecipeInformationLevelSelectState(_initialLevel);
}

class RecipeInformationLevelSelectState
    extends State<RecipeInformationLevelSelect> {
  int _level;

  RecipeInformationLevelSelectState(this._level);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget._label),
      leading: widget._icon,
      trailing: SizedBox(
        width: 200,
        child: Row(
          children: List.generate(
            RecipeInformationLevelSelect.LEVELS,
            (index) => !widget.editEnabled
                ? generateIcon(index)
                : IconButton(
                    icon: generateIcon(index),
                    padding: EdgeInsets.all(0),
                    onPressed: () => updateLevel(index + 1),
                    alignment: Alignment.centerRight,
                  ),
          ),
          mainAxisAlignment: MainAxisAlignment.end,
        ),
      ),
    );
  }

  Widget generateIcon(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Icon(
        widget._icon.icon,
        color: (_level != null && index < _level)
            ? widget.activeColor
            : widget.inactiveColor,
      ),
    );
  }

  void updateLevel(int newLevel) {
    setState(() {
      _level = newLevel;
      widget.onLevelUpdate(newLevel);
    });
  }
}

class EditableInformationTile extends StatelessWidget {
  final double value;
  final double minValue;
  final String title;
  final Icon icon;
  final String suffix;
  final bool editingEnabled;
  final void Function(double) onSaved;
  final void Function() onChanged;

  EditableInformationTile(
    this.value,
    this.title, {
    this.icon,
    this.suffix,
    this.editingEnabled,
    this.onSaved,
    this.onChanged,
    this.minValue = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: editingEnabled
          ? NumberFormField(
              initialValue: value?.toDouble(),
              fractionDigits: 0,
              labelText: title,
              minValue: minValue,
              onChanged: (_) => onChanged(),
              onSaved: onSaved,
            )
          : Text(title),
      leading: icon,
      trailing: !editingEnabled
          ? Text(
              "${value?.truncate() ?? '-'} $suffix",
              style: TextStyle(fontSize: 18),
            )
          : null,
    );
  }
}
