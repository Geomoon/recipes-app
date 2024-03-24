import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recipes_app/features/recipe_ingredients/presentation/widgets/recipe_ingredients_form.dart';
import 'package:recipes_app/features/recipes/presentation/bloc/add_timer/add_timer_cubit.dart';
import 'package:recipes_app/features/recipes/presentation/bloc/recipe_form/recipe_form_bloc.dart';

class RecipeForm extends StatelessWidget {
  const RecipeForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipeFormBloc(),
      child: const _FormViewProvider(),
    );
  }
}

class _FormViewProvider extends StatelessWidget {
  const _FormViewProvider();

// TODO: refactorizar
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Dialog(
      surfaceTintColor: const Color(0xff1C1B1F),
      backgroundColor: const Color(0xff1C1B1F),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 500,
          minWidth: 500,
          maxWidth: 1024,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const SizedBox(width: 20, height: 80),
                Expanded(
                  child: Text(
                    'New Recipe',
                    style: textTheme.headlineMedium
                        ?.copyWith(color: colors.onSecondaryContainer),
                  ),
                ),
                IconButton(
                  onPressed: context.pop,
                  icon: const Icon(Icons.close_rounded),
                ),
                const SizedBox(width: 20, height: 80),
              ],
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 180,
                              width: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(width: 2, color: colors.outline),
                              ),
                              child: true
                                  ? Center(
                                      child: Icon(
                                        Icons.add_photo_alternate_rounded,
                                        color: colors.onSecondaryContainer,
                                        size: 36,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        '',
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(
                                                    Icons.restaurant_rounded),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: 'Recipe Name',
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.remove_rounded)),
                                    const Chip(
                                        avatar: Icon(Icons.people_rounded),
                                        label: Text('1')),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.add_rounded)),
                                    const SizedBox(width: 40),
                                    Container(
                                      constraints: const BoxConstraints(
                                        maxWidth: 240,
                                        minWidth: 100,
                                      ),
                                      child: DropdownButtonFormField(
                                        focusColor: Colors.transparent,
                                        decoration: const InputDecoration(
                                          hintText: 'Category',
                                          hoverColor: Colors.transparent,
                                          fillColor: Colors.transparent,
                                          prefixIcon: Icon(
                                              Icons.restaurant_menu_rounded),
                                          border: UnderlineInputBorder(),
                                          focusColor: Colors.transparent,
                                        ),
                                        items: [
                                          DropdownMenuItem(
                                            child: Text('A'),
                                            value: 1,
                                          ),
                                          DropdownMenuItem(
                                            child: Text('B'),
                                            value: 2,
                                          ),
                                          DropdownMenuItem(
                                            child: Text('C'),
                                            value: 3,
                                          ),
                                          DropdownMenuItem(
                                            child: Text('D'),
                                            value: 4,
                                          ),
                                        ],
                                        onChanged: (v) {},
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: RecipeIngredientsForm(
                      onSuccess: (a) =>
                          context.read<RecipeFormBloc>().add(AddIngredient(a)),
                    ),
                  ),
                  const IngredientsList(),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Icon(
                                Icons.dinner_dining_rounded,
                                color: colors.onSecondaryContainer,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Steps',
                                style: textTheme.headlineSmall?.copyWith(
                                  color: colors.onSecondaryContainer,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                flex: 4,
                                child: TextFormField(
                                  minLines: 2,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                      hintText: 'Description',
                                      suffixIcon: BlocProvider(
                                        create: (context) => AddTimerCubit(),
                                        child: const AddTimerButton(),
                                      )),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextButton.icon(
                                  onPressed: () {},
                                  label: const Text('Add'),
                                  icon: const Icon(Icons.add_circle_rounded),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverList.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 8, bottom: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.transparent,
                                border:
                                    Border.all(width: 1, color: colors.outline),
                              ),
                              height: 32,
                              width: 32,
                              child: Center(
                                child: Text(
                                  '1',
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'step.description',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: colors.onBackground),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.remove_circle_rounded,
                                          color: colors.error,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  const Chip(label: Text('Step 1')),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.bookmark_add_rounded),
                  onPressed: () {},
                  label: const Text(
                    'Save',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 80,
                  width: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class IngredientsList extends StatelessWidget {
  const IngredientsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<RecipeFormBloc, RecipeFormState>(
      builder: (context, state) {
        final ingredients = state.ingredients;
        return SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 500,
            mainAxisExtent: 36,
            childAspectRatio: 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 2,
          ),
          itemCount: ingredients.length,
          itemBuilder: (context, index) {
            final item = ingredients[index];
            return ListTile(
              title: Text(item.description),
              trailing: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${item.quantity} ${item.quantityType}'),
                  IconButton(
                    iconSize: 24,
                    onPressed: () {},
                    icon: Icon(
                      Icons.remove_circle_rounded,
                      color: colors.error,
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class AddTimerButton extends StatelessWidget {
  const AddTimerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final addTimer = context.watch<AddTimerCubit>();
    final colors = Theme.of(context).colorScheme;

    if (!addTimer.state) {
      return FilledButton.tonalIcon(
        label: const Text('Add Timer'),
        onPressed: context.read<AddTimerCubit>().toggle,
        icon: const Icon(Icons.add_alarm_rounded),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 60,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.keyboard_arrow_up_rounded),
              ),
              TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '00',
                  border: OutlineInputBorder(),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        const Text(':'),
        const SizedBox(width: 10),
        SizedBox(
          width: 60,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.keyboard_arrow_up_rounded),
              ),
              TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '00',
                  border: OutlineInputBorder(),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: context.read<AddTimerCubit>().toggle,
          icon: Icon(
            Icons.remove_circle_rounded,
            color: colors.error,
          ),
        ),
      ],
    );
  }
}
