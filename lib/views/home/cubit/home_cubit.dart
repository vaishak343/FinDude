import 'package:hydrated_bloc/hydrated_bloc.dart';

class HomeCubit extends Cubit<bool> {
  HomeCubit() : super(false);

  void changeTheme() {
    emit(!state);
  }
}
