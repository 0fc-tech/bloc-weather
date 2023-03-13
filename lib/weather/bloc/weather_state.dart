part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {
  final Weather weather;

  const WeatherState(this.weather);
}

class WeatherInitial extends WeatherState {
  const WeatherInitial(super.weather);
}

class NewWeather extends WeatherState {
  const NewWeather(super.weather);



}
