import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HomeStates {}

//For offers
class LoadingOffersState extends HomeStates {}

class SuccessOffersState extends HomeStates {}

class FailureOffersState extends HomeStates {}

//For most search salonssalons

class LoadingMostSearchState extends HomeStates {}

class SuccessMostSearchState extends HomeStates {}

class FailureMostSearchState extends HomeStates {}

//For trim stars salons

class LoadingTrimStarsState extends HomeStates {}

class SuccessTrimStarsState extends HomeStates {}

class FailureTrimStarsState extends HomeStates {}
