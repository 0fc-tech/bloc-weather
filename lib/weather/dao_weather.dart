import 'package:http/http.dart';

class DaoWeather{
  static Future<Response> getWeatherByCity(String city){

    switch(city){
      case "Angers":
        return get(Uri.parse("https://api.open-meteo.com/v1/forecast?latitude=47.47&longitude=-0.55&current_weather=true"));
      case "Nantes":
        return get(Uri.parse("https://api.open-meteo.com/v1/forecast?latitude=47.22&longitude=-1.55&current_weather=true"));
      case "Lille":
        return get(Uri.parse("https://api.open-meteo.com/v1/forecast?latitude=50.63&longitude=3.06&current_weather=true"));
      case "Paris":
        return get(Uri.parse("https://api.open-meteo.com/v1/forecast?latitude=47.47&longitude=-0.55&current_weather=true"));
      case "Bordeaux":
        return get(Uri.parse("https://api.open-meteo.com/v1/forecast?latitude=47.47&longitude=-0.55&current_weather=true"));
      case "Toulouse":
        return get(Uri.parse("https://api.open-meteo.com/v1/forecast?latitude=47.47&longitude=-0.55&current_weather=true"));
      default:
        return get(Uri.parse("https://api.open-meteo.com/v1/forecast?latitude=47.47&longitude=-0.55&current_weather=true"));
    }
    
  }
}