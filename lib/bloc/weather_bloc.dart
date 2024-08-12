import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherLoading()){
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        WeatherFactory weatherFactory = WeatherFactory(
            "c7debaea1a8869c84cc11a814c53e727",
            language: Language.ENGLISH);
        Weather weather = await weatherFactory.currentWeatherByLocation(
            event.position.latitude, event.position.longitude);
        DateTime dateTime = DateTime.now();
        print(weather);
        emit(WeatherSuccess(weather,dateTime));
      } catch (e) {
        emit(WeatherFailure());
      }
    });
    on<UpdateTime>((event,emit){
      if(state is WeatherSuccess){
        WeatherSuccess currentState =  state as WeatherSuccess;
        emit(WeatherSuccess(currentState.weather, event.dateTime));
      }
    });
  }
}
