import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/features/recipe_types/presentation/bloc/get_recipes_by_type/get_recipes_by_type_bloc.dart';
import 'package:recipes_app/features/recipe_types/presentation/bloc/tab_selector/tab_selector_cubit.dart';
import 'package:recipes_app/features/recipes/presentation/bloc/get_recipes/get_recipes_cubit.dart';
import 'package:recipes_app/features/recipes/presentation/widgets/recipes_by_type_view.dart';
import 'package:recipes_app/features/recipe_types/presentation/widgets/recipes_type_list.dart';
import 'package:recipes_app/features/shared/presentation/widgets/app_logo.dart';
import 'package:recipes_app/features/recipes/presentation/widgets/recipe_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: size.width <= 1280 ? 20 : 40),
            constraints: BoxConstraints(
              maxWidth: size.width <= 800
                  ? 0
                  : size.width >= 1300
                      ? 300
                      : 240,
              minWidth: size.width <= 800 ? 0 : 100,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppLogo(),
                Expanded(child: RecipeTypesList()),
                // Align(alignment: Alignment.centerLeft, child: ThemeButton()),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: AddRecipeButton()),
                ),
              ],
            ),
          ),
          Expanded(flex: 10, child: child),
          // if (size.width >= 1300)
          //   Expanded(
          //     flex: 4,
          //     child: Container(
          //       margin: const EdgeInsets.all(10),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(20),
          //         color: Colors.grey.shade900.withOpacity(.4),
          //       ),
          //       child: const Column(
          //         children: [Icon(Icons.timer_rounded)],
          //       ),
          //     ),
          //   )
        ],
      ),
    );
  }
}

class AddRecipeButton extends StatelessWidget {
  const AddRecipeButton({
    super.key,
  });

  void showNewRecipeDialog(BuildContext context) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return RecipeForm();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showNewRecipeDialog(context);
      },
      icon: const Icon(Icons.library_add_rounded),
      label: const Text('New recipe'),
    );
  }
}

class RecipeByTypePage extends StatelessWidget {
  const RecipeByTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TabSelectorCubit, String?>(
      listener: (context, state) {
        if (state != null) {
          context.read<GetRecipesByTypeBloc>().exec(state);
        }
      },
      child: const RecipesByTypeView(),
    );
  }
}

class RecipesByTypeView extends StatelessWidget {
  const RecipesByTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    final recipesBloc = context.watch<GetRecipesByTypeBloc>();

    if (recipesBloc.state is GetRecipesByTypeLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (recipesBloc.state is GetRecipesByTypeLoaded) {
      return RecipesByTypeList(
        data: (recipesBloc.state as GetRecipesByTypeLoaded).data,
      );
    }

    return const Center(child: Text('Error'));
  }
}

class RecipesViewPage extends StatelessWidget {
  const RecipesViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final recipes = context.watch<GetRecipesCubit>();
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            'FAVORITES',
            style: textTheme.labelSmall
                ?.copyWith(color: colors.onBackground.withOpacity(.6)),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: recipes.state.items.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final item = recipes.state.items[index];
                return Container(
                  height: 200,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(
                        item.img ?? '',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0),
                              Colors.black45.withOpacity(0),
                              Colors.black87,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Text(
                          item.name ?? '',
                          style: textTheme.titleMedium
                              ?.copyWith(color: Colors.white70),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          const Expanded(child: RecipeByTypePage())
        ],
      ),
    );
  }
}
