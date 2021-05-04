import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/modules/home/cubit/reserve_states.dart';
import 'package:trim/modules/home/models/Salon.dart';

class ReserveCubit extends Cubit<ReserveSalonStates> {
  final Salon salon;
  ReserveCubit({this.salon}) : super(IntialReserveState(salon: salon)) {
    print(salon);
  }

  static ReserveCubit getInstance(context) => BlocProvider.of(context);

  Future<void> _loadSalon() {}
}
