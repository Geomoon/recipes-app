import 'package:flutter/material.dart';
import 'package:recipes_app/config/app_router.dart';
import 'package:recipes_app/config/env.dart';
import 'package:recipes_app/config/get_it_config.dart';
import 'package:recipes_app/features/recipe_types/domain/domain.dart';
import 'package:recipes_app/features/recipe_types/presentation/bloc/get_recipes/get_recipe_types_cubit.dart';
import 'package:recipes_app/features/recipe_types/presentation/bloc/get_recipes_by_type/get_recipes_by_type_bloc.dart';
import 'package:recipes_app/features/recipe_types/presentation/bloc/tab_selector/tab_selector_cubit.dart';
import 'package:recipes_app/features/recipes/domain/recipe_repository.dart';
import 'package:recipes_app/features/recipes/presentation/bloc/get_recipes/get_recipes_cubit.dart';
import 'package:recipes_app/features/recipes/presentation/bloc/recipe/recipe_bloc.dart';
import 'package:recipes_app/features/shared/presentation/cubit/theme_cubit/theme_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await Env.init();
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const RecipesApp());
}

class RecipesApp extends StatelessWidget {
  const RecipesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetRecipeTypesCubit(repository: getIt<RecipeTypeRepository>()),
        ),
        BlocProvider(
          create: (context) => TabSelectorCubit(),
        ),
        BlocProvider(
          create: (context) => GetRecipesCubit(getIt<RecipeRepository>()),
        ),
        BlocProvider(
          create: (context) => GetRecipesByTypeBloc(getIt<RecipeRepository>()),
        ),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(
          create: (context) => RecipeBloc(
            repository: getIt<RecipeRepository>(),
          ),
        ),
      ],
      child: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      themeMode: context.watch<ThemeCubit>().state,
      theme: ThemeData.light(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.amber, brightness: Brightness.light),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'RedHat'),
          displayMedium: TextStyle(fontFamily: 'RedHat'),
          displaySmall: TextStyle(fontFamily: 'RedHat'),
          headlineMedium: TextStyle(fontFamily: 'RedHat'),
          headlineSmall: TextStyle(fontFamily: 'RedHat'),
          titleLarge: TextStyle(fontFamily: 'RedHat'),
          titleMedium: TextStyle(fontFamily: 'RedHat'),
          titleSmall: TextStyle(fontFamily: 'RedHat'),
          bodyLarge: TextStyle(fontFamily: 'RedHat'),
          bodyMedium: TextStyle(fontFamily: 'RedHat'),
          bodySmall: TextStyle(fontFamily: 'RedHat'),
          labelLarge: TextStyle(fontFamily: 'RedHat'),
          labelSmall: TextStyle(fontFamily: 'RedHat'),
        ),
      ),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'RedHat'),
          displayMedium: TextStyle(fontFamily: 'RedHat'),
          displaySmall: TextStyle(fontFamily: 'RedHat'),
          headlineMedium: TextStyle(fontFamily: 'RedHat'),
          headlineSmall: TextStyle(fontFamily: 'RedHat'),
          titleLarge: TextStyle(fontFamily: 'RedHat'),
          titleMedium: TextStyle(fontFamily: 'RedHat'),
          titleSmall: TextStyle(fontFamily: 'RedHat'),
          bodyLarge: TextStyle(fontFamily: 'RedHat'),
          bodyMedium: TextStyle(fontFamily: 'RedHat'),
          bodySmall: TextStyle(fontFamily: 'RedHat'),
          labelLarge: TextStyle(fontFamily: 'RedHat'),
          labelSmall: TextStyle(fontFamily: 'RedHat'),
        ),
      ),
    );
  }
}
