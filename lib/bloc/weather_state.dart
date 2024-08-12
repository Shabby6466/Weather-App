part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}
class WeatherLoading extends WeatherState {}

class WeatherFailure extends WeatherState {}

class WeatherSuccess extends WeatherState {
  final Weather weather;
  final DateTime dateTime;

  const WeatherSuccess(this.weather, this.dateTime);

  @override
  List<Object> get props => [weather, dateTime];
}
