import 'package:flutter/material.dart';
import 'package:trim/modules/home/models/barber.dart';
import 'package:trim/modules/home/widgets/barber_item.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';

class PersonsGridView extends StatelessWidget {
  final bool filterFavorite;
  PersonsGridView({Key key, this.filterFavorite = false});
  @override
  Widget build(BuildContext context) {
    final List<Barber> filteredPersons = filterFavorite
        ? barbers.where((barber) => barber.isFavorite).toList()
        : barbers;
    return InfoWidget(
      responsiveWidget: (_, deviceInfo) => GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: filteredPersons.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: BarberItem(
                  barber: filteredPersons[index], deviceInfo: deviceInfo));
        },
      ),
    );
  }
}
