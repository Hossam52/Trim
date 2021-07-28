import 'package:flutter/material.dart';
import 'package:trim/appLocale/translatedWord.dart';
import 'package:trim/constants/asset_path.dart';
import 'package:trim/general_widgets/choice_button.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';
import 'package:trim/modules/home/cubit/home_states.dart';

class SalonsPersonsWidget extends StatelessWidget {
  final bool displaySalons;
  final VoidCallback salonsPressed;
  final VoidCallback personsPressed;

  const SalonsPersonsWidget(
      {Key key,
      @required this.displaySalons,
      @required this.salonsPressed,
      @required this.personsPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ChoiceButton(
              directionRoundedRight: false,
              icon: hairIcon,
              name: translatedWord('Salons', context),
              active: displaySalons,
              pressed: () {
                final state = HomeCubit.getInstance(context).state;
                if (state is TrimStarState)
                  HomeCubit.getInstance(context).emit(MostSearchState());
                else if (state is AllPersonsState)
                  HomeCubit.getInstance(context).emit(AllSalonsState());
                salonsPressed();
              }),
          ChoiceButton(
              directionRoundedRight: true,
              icon: marketIcon,
              name: translatedWord('Persons', context),
              active: !displaySalons,
              pressed: () {
                final state = HomeCubit.getInstance(context).state;
                if (state is MostSearchState)
                  HomeCubit.getInstance(context).emit(TrimStarState());
                else if (state is AllSalonsState)
                  HomeCubit.getInstance(context).emit(AllPersonsState());
                personsPressed();
              }),
        ],
      ),
    );
  }
}
