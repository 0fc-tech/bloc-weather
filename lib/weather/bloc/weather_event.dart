part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {

}

class NewCityEvent extends WeatherEvent{
  final String city;

  NewCityEvent(this.city);
}

