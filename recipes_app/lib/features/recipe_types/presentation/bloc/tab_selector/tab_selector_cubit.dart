import 'package:flutter_bloc/flutter_bloc.dart';

class TabSelectorCubit extends Cubit<String?> {
  TabSelectorCubit() : super(null);

  void setTab(String id) => emit(id);
}
