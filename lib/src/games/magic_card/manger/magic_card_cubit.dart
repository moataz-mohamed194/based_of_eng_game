import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../src_model/export_models.dart';

part 'magic_card_state.dart';

class MagicCardCubit extends Cubit<MagicCardInitial> {
  MagicCardCubit({required GameFinalModel gameData})
      : super(MagicCardInitial(gameData: gameData));
}
