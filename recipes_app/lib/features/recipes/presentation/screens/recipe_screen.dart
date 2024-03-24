import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/features/recipe_ingredients/domain/entities/get_recipe_ingredient.dart';
import 'package:recipes_app/features/recipe_steps/domain/entities/get_recipe_step.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe.dart';
import 'package:recipes_app/features/recipes/presentation/bloc/ingredients/ingredients_bloc.dart';
import 'package:recipes_app/features/recipes/presentation/bloc/recipe/recipe_bloc.dart';
import 'package:recipes_app/features/recipes/presentation/bloc/steps/steps_bloc.dart';
import 'package:recipes_app/features/recipes/presentation/bloc/timer/timer_bloc.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({super.key, required this.recipeId});

  final String recipeId;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 10,
            child: _RecipeView(
              id: recipeId,
              showIngredients: size.width < 1480,
            ),
          ),
          if (size.width >= 1480)
            Expanded(
              flex: 4,
              child: RecipesSidePanel(
                recipeId: recipeId,
              ),
            )
        ],
      ),
    );
  }
}

class RecipesSidePanel extends StatelessWidget {
  const RecipesSidePanel({
    super.key,
    required this.recipeId,
  });

  final String recipeId;

  @override
  Widget build(BuildContext context) {
    final recipeBloc = context.watch<RecipeBloc>();
    final textTheme = Theme.of(context).textTheme;

    if (recipeBloc.state is RecipeLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (recipeBloc.state is RecipeError) {
      return Center(child: Text((recipeBloc.state as RecipeError).message));
    }

    final recipe = (recipeBloc.state as RecipeReady).recipe;

    return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade900.withOpacity(.4),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    const Icon(Icons.fastfood_rounded),
                    const SizedBox(width: 10),
                    Text(
                      'Ingredients',
                      style: textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
            ),
            IngredientsList(recipe: recipe),
          ],
        ));
  }
}

class _RecipeView extends StatelessWidget {
  const _RecipeView({
    required this.id,
    this.showIngredients = true,
  });

  final String id;
  final bool showIngredients;
  @override
  Widget build(BuildContext context) {
    final recipeBloc = context.watch<RecipeBloc>();
    final textTheme = Theme.of(context).textTheme;

    if (recipeBloc.state is RecipeLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (recipeBloc.state is RecipeError) {
      return Center(child: Text((recipeBloc.state as RecipeError).message));
    }

    final recipe = (recipeBloc.state as RecipeReady).recipe;

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          title: Text('Recipe'),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      recipe.img ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name ?? '',
                      style: textTheme.headlineLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.people_rounded),
                        const SizedBox(width: 10),
                        Text('${recipe.numPortions}'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Chip(
                      label: Text(
                        recipe.timeTxt,
                        style: textTheme.labelLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      avatar: const Icon(Icons.timer_rounded),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        if (showIngredients)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(Icons.fastfood_rounded),
                  const SizedBox(width: 10),
                  Text(
                    'Ingredients',
                    style: textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ),
        if (showIngredients) IngredientsList(recipe: recipe),
        SliverToBoxAdapter(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20),
            child: Row(
              children: [
                const Icon(Icons.dinner_dining_rounded),
                const SizedBox(width: 10),
                Text(
                  'Preparation',
                  style: textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ),
        StepsBuilder(recipe: recipe),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }
}

class StepsBuilder extends StatelessWidget {
  const StepsBuilder({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StepsBloc(recipe.steps),
      child: StepsList(recipe: recipe),
    );
  }
}

class StepsList extends StatelessWidget {
  const StepsList({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<StepsBloc>();

    return SliverList.builder(
      itemCount: bloc.state.steps.length,
      itemBuilder: (context, index) {
        final step = bloc.state.steps[index];
        return StepTile(
          step: step,
          onChangeCompleted: context.read<StepsBloc>().changeCompleted,
        );
      },
    );
  }
}

class StepTile extends StatelessWidget {
  const StepTile({
    super.key,
    required this.step,
    required this.onChangeCompleted,
  });

  final Function(String, bool) onChangeCompleted;

  final GetRecipeStep step;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: step.isComplete
                  ? colors.secondaryContainer
                  : Colors.transparent,
              border: step.isComplete
                  ? null
                  : Border.all(width: 1, color: colors.outline),
            ),
            height: 32,
            width: 32,
            child: Center(
              child: Text(
                '${step.order}',
                style: textTheme.labelLarge?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  step.description,
                  style: TextStyle(
                      fontSize: 16,
                      color: step.isComplete
                          ? colors.onBackground.withOpacity(.5)
                          : colors.onBackground),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ActionChip(
                      side: BorderSide.none,
                      onPressed: () =>
                          onChangeCompleted(step.id, !step.isComplete),
                      label: step.isComplete
                          ? const Text('Unmark')
                          : const Text('Mark as complete'),
                      avatar: step.isComplete
                          ? null
                          : const Icon(Icons.done_all_rounded),
                    ),
                    const SizedBox(width: 10),
                    if (step.time > 0) TimerBuilder(time: step.time),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimerBuilder extends StatelessWidget {
  const TimerBuilder({
    super.key,
    required this.time,
  });

  final int time;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerBloc(time),
      child: const TimerChip(),
    );
  }
}

class TimerChip extends StatelessWidget {
  const TimerChip({
    super.key,
  });

  Icon getIcon(TimerStateEnum state) => switch (state) {
        TimerStateEnum.stop => const Icon(Icons.play_arrow_rounded),
        TimerStateEnum.running => const Icon(Icons.timelapse_sharp),
        TimerStateEnum.finished => const Icon(Icons.restore_rounded),
        TimerStateEnum.pause => const Icon(Icons.pause_rounded),
      };

  @override
  Widget build(BuildContext context) {
    final timer = context.watch<TimerBloc>();
    final colors = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ActionChip.elevated(
          tooltip: 'Start timer',
          onPressed: context.read<TimerBloc>().start,
          label: Text(timer.state.timeTxt),
          avatar: getIcon(timer.state.state),
        ),
        if (timer.state.state == TimerStateEnum.pause)
          ActionChip.elevated(
            elevation: 0,
            tooltip: 'Restart timer',
            onPressed: context.read<TimerBloc>().stop,
            label: Icon(
              Icons.restore_rounded,
              color: colors.primary,
              size: 20,
            ),
          ),
      ],
    );
  }
}

class IngredientsList extends StatelessWidget {
  const IngredientsList({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IngredientsBloc(recipe.ingredients),
      child: const IngredientsGrid(),
    );
  }
}

class IngredientsGrid extends StatelessWidget {
  const IngredientsGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final list = context.watch<IngredientsBloc>();
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500,
        mainAxisExtent: 30,
        childAspectRatio: 1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 2,
      ),
      itemCount: list.state.ingredients.length,
      itemBuilder: (context, index) {
        final ingredient = list.state.ingredients[index];
        return IngredientTile(
          ingredient: ingredient,
          onChange: context.read<IngredientsBloc>().changeCompleted,
        );
      },
    );
  }
}

class IngredientTile extends StatelessWidget {
  const IngredientTile({
    super.key,
    required this.ingredient,
    required this.onChange,
  });

  final GetRecipeIngredient ingredient;
  final Function(String, bool) onChange;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.only(left: 4, right: 10, top: 4, bottom: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: ingredient.isComplete,
            onChanged: (v) => onChange(ingredient.id, v ?? false),
          ),
          const SizedBox(width: 10),
          Text(ingredient.description, style: textTheme.bodyLarge),
          const Spacer(),
          Text('${ingredient.quantity}', style: textTheme.labelLarge),
          const SizedBox(width: 10),
          Text(
            '${ingredient.quantityType}',
            style: textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
