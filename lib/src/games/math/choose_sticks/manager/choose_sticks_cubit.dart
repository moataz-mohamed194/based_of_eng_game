import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'choose_sticks_state.dart';

class ChooseSticksCubit extends Cubit<ChooseSticksState> {
  ChooseSticksCubit() : super(ChooseSticksInitial());
}
