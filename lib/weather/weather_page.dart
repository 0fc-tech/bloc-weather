import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherappbloc/weather/bloc/weather_bloc.dart';
import 'package:weatherappbloc/weather/weather.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final controllerCity = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.watch<WeatherBloc>().state.weather.city),),
      body: Column(
        children: [
          ShowWeatherWidget(runtimeType: runtimeType),
          TextField(controller: controllerCity,),
          ElevatedButton(
              onPressed: ()=> context.read<WeatherBloc>().add(NewCityEvent(controllerCity.text)),
              child: Text("Récupérer Météo"))
        ],
      ),
    );
  }
}

class ShowWeatherWidget extends StatelessWidget {
  const ShowWeatherWidget({
    super.key,
    required this.runtimeType,
  });

  final Type runtimeType;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        switch(state.runtimeType){
          case WeatherInitial:
            return Center(
              child: Container(
                child: Text("À ${state.weather.city} il fait ${state.weather.temperature}°C"),
              ),
            );
          case NewWeather:
            return Center(
              child: Container(
                child: Text("À ${state.weather.city} il fait ${state.weather.temperature}°C"),
              ),
            );
          default:
            return Container();
        }
      },
    );
  }
}
