import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/modules/auth/cubits/activate_states.dart';
import 'package:trim/modules/auth/models/token_model.dart';
import 'package:trim/modules/auth/repositries/activate_repositry.dart';

class ActivateCubit extends Cubit<ActivateStates> {
  ActivateCubit() : super(InitialActivateState());

  static ActivateCubit getInstance(context) =>
      BlocProvider.of<ActivateCubit>(context);

  String accessToken;
  TokenModel activationTokenModel;
  Future<void> checkActivateCode(String code) async {
    try {
      emit(CheckingActivateCodeState());
      final response = await activateAccount(accessToken, code);
      if (response.error) {
        print(response.errorMessage);
        emit(ErrorActivateStates(response.errorMessage));
      } else {
        activationTokenModel = response.data;
        emit(ValidActivateCodeStates());
      }
    } catch (e) {
      emit(ErrorActivateStates(e.toString()));
    }
  }

  Future<void> requestActivationCode(String phone) async {
    emit(RequestingNewActivatationCodeState());
    final response = await requestNewCode(phone);
    try {
      if (response.error) {
        emit(ErrorRequestActivationCodeState(response.errorMessage));
      } else {
        print('request ${response.data.token}');
        accessToken = response.data.token;
        emit(SuccessRequestActivationCodeState());
      }
    } catch (e) {
      emit(ErrorRequestActivationCodeState(response.errorMessage));
    }
  }
}
