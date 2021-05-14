import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/general_widgets/default_button.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';
import 'package:trim/modules/home/cubit/home_states.dart';
import 'package:trim/modules/home/cubit/persons_cubit.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import '../cubit/cities_cubit.dart';
import '../cubit/cities_states.dart';

class BuildCitiesRadio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CitiesCubit, CitiesStates>(
      listener: (_, states) {},
      builder: (_, state) {
        if (state is LoadingCitiesState)
          return Center(child: CircularProgressIndicator());
        if (state is EmptyCitiesState)
          return Center(child: Text('No Cities Found'));
        final cities = CitiesCubit.getInstance(context).cities;
        int selectedId = CitiesCubit.getInstance(context).selectedCity.id;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ...cities
                .map((city) => ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      onTap: () {
                        CitiesCubit.getInstance(context)
                            .changeSelecteCity(city);
                      },
                      leading: Radio<int>(
                        value: city.id,
                        groupValue: selectedId,
                        onChanged: (value) {
                          CitiesCubit.getInstance(context)
                              .changeSelecteCity(city);
                        },
                      ),
                      title: Text(city.nameEn),
                    ))
                .toList(),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: DefaultButton(
                  text: 'Search now',
                  onPressed: () async {
                    if (HomeCubit.getInstance(context).state is AllSalonsState)
                      SalonsCubit.getInstance(context)
                          .searchForSalon(cityId: selectedId);
                    else if (HomeCubit.getInstance(context).state
                        is AllPersonsState)
                      PersonsCubit.getInstance(context)
                          .searchForPerson(cityId: selectedId);

                    Navigator.pop(context);
                  },
                  color: Colors.black,
                )),
          ],
        );
      },
    );
  }
}
