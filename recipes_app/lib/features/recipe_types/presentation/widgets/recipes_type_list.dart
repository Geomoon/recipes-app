import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/features/recipe_types/presentation/bloc/get_recipes/get_recipe_types_cubit.dart';
import 'package:recipes_app/features/recipe_types/presentation/bloc/tab_selector/tab_selector_cubit.dart';
import 'package:recipes_app/features/recipe_types/presentation/widgets/recipe_type_list_tile.dart';

class RecipeTypesList extends StatelessWidget {
  const RecipeTypesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final list = context.watch<GetRecipeTypesCubit>();
    final tabSelector = context.watch<TabSelectorCubit>();
    final size = MediaQuery.of(context).size;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: list.state.items.length,
      itemBuilder: (context, index) {
        final item = list.state.items[index];
        return RecipeTypeListTile(
          width: size.width <= 800
              ? 0
              : size.width >= 1300
                  ? 300
                  : 240,
          onTap: () => context.read<TabSelectorCubit>().setTab(item.id),
          item: item,
          isSelected: item.id == tabSelector.state,
        );
      },
    );
  }
}
