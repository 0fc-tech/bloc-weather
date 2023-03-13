part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {

}

class NewCityEvent extends WeatherEvent{
  String city;

  NewCityEvent(this.city);
}