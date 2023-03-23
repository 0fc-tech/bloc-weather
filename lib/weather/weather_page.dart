import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_animation/weather_animation.dart';
import 'package:weatherappbloc/weather/bloc/weather_bloc.dart';
import 'package:weatherappbloc/weather/weather.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final controllerCity = TextEditingController();
  final listCities = [
    "Angers",
    "Nantes",
    "Lille",
    "Paris",
    "Bordeaux",
    "Toulouse"
  ];
  late String valueDropdown;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    valueDropdown = listCities[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text(context.watch<WeatherBloc>().state.weather.city),),
      body: WrapperScene(
        sizeCanvas: MediaQuery.of(context).size,
        colors: const [Colors.blueGrey, Colors.blue],
        children: [
          //SunWidget(),
          ThunderWidget(),
          //RainWidget(),
          //const SnowflakeWidget(snowflakeConfig: SnowConfig(count:20,),),
          //const CloudWidget(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 50.0),
                  DropdownButton<String>(
                    value: valueDropdown,
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      context
                          .read<WeatherBloc>()
                          .add(NewCityEvent(valueDropdown));
                      setState(() {
                        valueDropdown = value!;
                      });
                    },
                    style: const TextStyle(fontSize: 38.0),
                    icon: Container(),
                    alignment: Alignment.center,
                    dropdownColor: Colors.black,
                    items: listCities
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  ShowWeatherWidget(runtimeType: runtimeType),
                  const SizedBox(height: 50.0),
                  WeatherByHourWidget(),
                  const SizedBox(height: 8.0),
                  WeatherByDayWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherByHourWidget extends StatelessWidget {
  const WeatherByHourWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Color(0x60555555),
          borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        children: [
          const Text(
              "Clear conditions from 1am to 5am, with rain expected at 8",
              style: TextStyle(color: Colors.white)),
          const SizedBox(height: 8.0),
          const Divider(
            height: 5.0,
            color: Colors.white70,
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
              separatorBuilder: (context,index)=>SizedBox(width: 16.0,),
              scrollDirection: Axis.horizontal,
              itemCount: 20,

              itemBuilder: (context,index)=> Column(
                children:const  [
                  Text("Now",
                      style: TextStyle(color: Colors.white)),
                  SizedBox(height: 8.0,),
                  Icon(Icons.cloud),
                  SizedBox(height: 8.0,),
                  Text("12°C",
                      style: TextStyle(color: Colors.white,fontSize: 16)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class WeatherByDayWidget extends StatelessWidget {
  const WeatherByDayWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:10.0,left:10.0,right:10.0),
      decoration: BoxDecoration(
          color: Color(0x60555555),
          borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.calendar_month,size: 18,color: Color(0xB0ffffff),),
              SizedBox(width:6.0),
              Text(
                  "10-DAY FORECAST",
                  style: TextStyle(color: Color(0xB0ffffff))),
            ],
          ),
          const SizedBox(height: 8.0),
          const Divider(
            height: 5.0,
            color: Colors.white70,
          ),
          SizedBox(
            height: 405,
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context,index)=> const Divider(
                height: 5.0,
                color: Colors.white70,
              ),
              scrollDirection: Axis.vertical,
              itemCount: 10,
              itemBuilder: (context,index)=> Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  children:const  [
                    Text("Today",
                        style: TextStyle(color: Colors.white)),
                    Spacer(),
                    Icon(Icons.cloud,color: Colors.white,),
                    Spacer(),
                    Text("12°C",
                        style: TextStyle(color: Colors.white,fontSize: 16)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:8.0),
                      child: SizedBox(
                        width: 80,
                          child: LinearProgressIndicator(value:0.8)
                      ),
                    ),
                    Text("12°C",
                        style: TextStyle(color: Colors.white,fontSize: 16)),
                  ],
                ),
              ),
            ),
          ),
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
        switch (state.runtimeType) {
          case WeatherInitial:
            return Center(
              child: Container(
                  child: Text(
                "${state.weather.temperature}°C",
                style: const TextStyle(
                    fontSize: 38.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              )),
            );
          case NewWeather:
            return Center(
              child: Container(
                child: Text(
                  "${state.weather.temperature}°C",
                  style: const TextStyle(fontSize: 38.0),
                ),
              ),
            );
          default:
            return Container();
        }
      },
    );
  }
}
