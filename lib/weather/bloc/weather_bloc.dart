import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weatherappbloc/weather/dao_weather.dart';

import '../weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial(Weather())) {
    on<WeatherEvent>((event, emit) {
      emit(NewWeather(Weather()));
    });
    on<NewCityEvent>((event, emit) async{
      final resp =await DaoWeather.getWeatherByCity(event.city);
        if(resp.body.isNotEmpty){
          Map<String,dynamic> mapWeather=jsonDecode(resp.body);
          emit(
            NewWeather(
              Weather(
                  city : event.city,
                  temperature: mapWeather["current_weather"]["temperature"])
            )
          );
        }

        }
      );


  }
}
