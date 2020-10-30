

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: directives_ordering, top_level_function_literal_block

import 'package:flutter_data/flutter_data.dart';


import 'package:provider/provider.dart' as p hide ReadContext;
import 'package:provider/single_child_widget.dart';



import 'package:weekly_menu_app/models/ingredient.dart';
import 'package:weekly_menu_app/models/menu.dart';
import 'package:weekly_menu_app/models/recipe.dart';

ConfigureRepositoryLocalStorage configureRepositoryLocalStorage = ({FutureFn<String> baseDirFn, List<int> encryptionKey, bool clear}) {
  // ignore: unnecessary_statements
  baseDirFn;
  return hiveLocalStorageProvider.overrideWithProvider(RiverpodAlias.provider(
        (_) => HiveLocalStorage(baseDirFn: baseDirFn, encryptionKey: encryptionKey, clear: clear)));
};

RepositoryInitializerProvider repositoryInitializerProvider = (
        {bool remote, bool verbose}) {
  
  return _repositoryInitializerProviderFamily(
      RepositoryInitializerArgs(remote, verbose));
};

final _repositoryInitializerProviderFamily =
  RiverpodAlias.futureProviderFamily<RepositoryInitializer, RepositoryInitializerArgs>((ref, args) async {
    final graphs = <String, Map<String, RemoteAdapter>>{'ingredients': {'ingredients': ref.read(ingredientRemoteAdapterProvider)}, 'menus': {'menus': ref.read(menuRemoteAdapterProvider)}, 'recipes': {'recipes': ref.read(recipeRemoteAdapterProvider)}};
    

      await ref.read(ingredientRepositoryProvider).initialize(
        remote: args?.remote,
        verbose: args?.verbose,
        adapters: graphs['ingredients'],
      );

      await ref.read(menuRepositoryProvider).initialize(
        remote: args?.remote,
        verbose: args?.verbose,
        adapters: graphs['menus'],
      );

      await ref.read(recipeRepositoryProvider).initialize(
        remote: args?.remote,
        verbose: args?.verbose,
        adapters: graphs['recipes'],
      );
    return RepositoryInitializer();
});



List<SingleChildWidget> repositoryProviders({FutureFn<String> baseDirFn, List<int> encryptionKey,
    bool clear, bool remote, bool verbose}) {

  return [
    p.Provider(
        create: (_) => ProviderContainer(
          overrides: [
            configureRepositoryLocalStorage(
                baseDirFn: baseDirFn, encryptionKey: encryptionKey, clear: clear),
          ]
      ),
    ),
    p.FutureProvider<RepositoryInitializer>(
      create: (context) async {
        final init = await p.Provider.of<ProviderContainer>(context, listen: false).read(repositoryInitializerProvider(remote: remote, verbose: verbose).future);
        internalLocatorFn = (provider, context) => p.Provider.of<ProviderContainer>(context, listen: false).read(provider);
        return init;
      },
    ),    p.ProxyProvider<RepositoryInitializer, Repository<Ingredient>>(
      lazy: false,
      update: (context, i, __) => i == null ? null : p.Provider.of<ProviderContainer>(context, listen: false).read(ingredientRepositoryProvider),
      dispose: (_, r) => r?.dispose(),
    ),
    p.ProxyProvider<RepositoryInitializer, Repository<Menu>>(
      lazy: false,
      update: (context, i, __) => i == null ? null : p.Provider.of<ProviderContainer>(context, listen: false).read(menuRepositoryProvider),
      dispose: (_, r) => r?.dispose(),
    ),
    p.ProxyProvider<RepositoryInitializer, Repository<Recipe>>(
      lazy: false,
      update: (context, i, __) => i == null ? null : p.Provider.of<ProviderContainer>(context, listen: false).read(recipeRepositoryProvider),
      dispose: (_, r) => r?.dispose(),
    ),]; }


