// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) {
  return Menu(
    id: json['_id'] as String,
    date: Menu.dateFromJson(json['date'] as String),
    meal: _$enumDecodeNullable(_$MealEnumMap, json['meal']),
    recipes: (json['recipes'] as List)?.map((e) => e as String)?.toList() ?? [],
  );
}

Map<String, dynamic> _$MenuToJson(Menu instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'date': Menu.dateToJson(instance.date),
    'meal': _$MealEnumMap[instance.meal],
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('recipes', instance.recipes);
  return val;
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$MealEnumMap = {
  Meal.Breakfast: 'Breakfast',
  Meal.Lunch: 'Lunch',
  Meal.Dinner: 'Dinner',
};

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, non_constant_identifier_names

mixin $MenuLocalAdapter on LocalAdapter<Menu> {
  @override
  Map<String, Map<String, Object>> relationshipsFor([Menu model]) => {};

  @override
  Menu deserialize(map) {
    for (final key in relationshipsFor().keys) {
      map[key] = {
        '_': [map[key], !map.containsKey(key)],
      };
    }
    return Menu.fromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model) => model.toJson();
}

// ignore: must_be_immutable
class $MenuHiveLocalAdapter = HiveLocalAdapter<Menu> with $MenuLocalAdapter;

class $MenuRemoteAdapter = RemoteAdapter<Menu> with BaseAdapter<Menu>;

//

final menusLocalAdapterProvider =
    Provider<LocalAdapter<Menu>>((ref) => $MenuHiveLocalAdapter(ref));

final menusRemoteAdapterProvider = Provider<RemoteAdapter<Menu>>(
    (ref) => $MenuRemoteAdapter(ref.read(menusLocalAdapterProvider)));

final menusRepositoryProvider =
    Provider<Repository<Menu>>((ref) => Repository<Menu>(ref));

final _watchMenu = StateNotifierProvider.autoDispose
    .family<DataStateNotifier<Menu>, WatchArgs<Menu>>((ref, args) {
  return ref.read(menusRepositoryProvider).watchOne(args.id,
      remote: args.remote,
      params: args.params,
      headers: args.headers,
      alsoWatch: args.alsoWatch);
});

AutoDisposeStateNotifierProvider<DataStateNotifier<Menu>> watchMenu(dynamic id,
    {bool remote,
    Map<String, dynamic> params = const {},
    Map<String, String> headers = const {},
    AlsoWatch<Menu> alsoWatch}) {
  return _watchMenu(WatchArgs(
      id: id,
      remote: remote,
      params: params,
      headers: headers,
      alsoWatch: alsoWatch));
}

final _watchMenus = StateNotifierProvider.autoDispose
    .family<DataStateNotifier<List<Menu>>, WatchArgs<Menu>>((ref, args) {
  ref.maintainState = false;
  return ref.read(menusRepositoryProvider).watchAll(
      remote: args.remote,
      params: args.params,
      headers: args.headers,
      filterLocal: args.filterLocal,
      syncLocal: args.syncLocal);
});

AutoDisposeStateNotifierProvider<DataStateNotifier<List<Menu>>> watchMenus(
    {bool remote, Map<String, dynamic> params, Map<String, String> headers}) {
  return _watchMenus(
      WatchArgs(remote: remote, params: params, headers: headers));
}

extension MenuX on Menu {
  /// Initializes "fresh" models (i.e. manually instantiated) to use
  /// [save], [delete] and so on.
  ///
  /// Can be obtained via `context.read`, `ref.read`, `container.read`
  Menu init(Reader read) {
    final repository = internalLocatorFn(menusRepositoryProvider, read);
    return repository.remoteAdapter.initializeModel(this, save: true);
  }
}
