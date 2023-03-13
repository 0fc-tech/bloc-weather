import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial(Weather())) {
    on<WeatherEvent>((event, emit) {
      emit(NewWeather(Weather()));
    });
    on<NewCityEvent>((event, emit) {
      emit(NewWeather(Weather(city : event.city, temperature: Random().nextDouble())));
    });
  }
}
