import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_by_type.dart';
import 'package:recipes_app/features/recipes/presentation/widgets/recipe_tile.dart';
import 'package:recipes_app/features/shared/presentation/assets/image_assets.dart';

class RecipesByTypeList extends StatelessWidget {
  const RecipesByTypeList({super.key, required this.data});

  final RecipesByType data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.type.name,
          style:
              textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        if (data.recipes.isEmpty)
          const NoRecipes()
        else
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data.recipes.length,
              itemBuilder: (context, index) {
                final recipe = data.recipes[index];
                return RecipeTile(recipe: recipe);
              },
            ),
          ),
      ],
    );
  }
}

class NoRecipes extends StatelessWidget {
  const NoRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: const BoxConstraints(
              maxHeight: 200,
              maxWidth: 200,
            ),
            child: SvgPicture.asset(
              ImageAssets.noRecipes,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'No recipes',
            style: textTheme.bodyLarge
                ?.copyWith(color: colors.onBackground.withOpacity(.6)),
          ),
        ],
      ),
    );
  }
}
