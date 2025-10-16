import 'package:flutter/material.dart';

class WeatherDisplay extends StatefulWidget {
  const WeatherDisplay({super.key});

  @override
  State<WeatherDisplay> createState() => _WeatherDisplayState();
}

class _WeatherDisplayState extends State<WeatherDisplay> {
  WeatherData? _weatherData;
  bool _isLoading = false;
  String? _error;
  bool _useFahrenheit = false;
  String _selectedCity = 'New York';

  final List<String> _cities = ['New York', 'London', 'Tokyo', 'Invalid City'];

  double celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  Future<Map<String, dynamic>?> _fetchWeatherData(String city) async {
    await Future.delayed(const Duration(seconds: 2));

    if (city == 'Invalid City') return null;

    if (DateTime.now().millisecond % 4 == 0) {
      return {'city': city, 'temperature': 22.5};
    }

    return {
      'city': city,
      'temperature': city == 'London' ? 15.0 : (city == 'Tokyo' ? 25.0 : 22.5),
      'description': city == 'London'
          ? 'Rainy'
          : (city == 'Tokyo' ? 'Cloudy' : 'Sunny'),
      'humidity': city == 'London' ? 85 : (city == 'Tokyo' ? 70 : 65),
      'windSpeed': city == 'London' ? 8.5 : (city == 'Tokyo' ? 5.2 : 12.3),
      'icon': city == 'London' ? '🌧️' : (city == 'Tokyo' ? '☁️' : '☀️'),
    };
  }

  Future<void> _loadWeather() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await _fetchWeatherData(_selectedCity);

      if (!mounted) return;

      if (data == null) {
        setState(() {
          _error = 'Failed to load weather data for $_selectedCity';
          _isLoading = false;
          _weatherData = null;
        });
        return;
      }

      final weatherData = WeatherData.fromJson(data);

      setState(() {
        _weatherData = weatherData;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _error = 'Error parsing weather data: ${e.toString()}';
        _isLoading = false;
        _weatherData = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          /// City selection
          _buildCitySelector(),

          /// Temperature unit toggle
          _buildTemperatureUnitToggle(),

          /// Weather content
          _buildWeatherContent(),
        ],
      ),
    );
  }

  Widget _buildCitySelector() {
    return Row(
      spacing: 8,
      children: [
        const Text('City: '),
        Expanded(
          child: DropdownButton<String>(
            value: _selectedCity,
            isExpanded: true,
            items: _cities.map((city) {
              return DropdownMenuItem(value: city, child: Text(city));
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedCity = value;
                });
                _loadWeather();
              }
            },
          ),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _loadWeather,
          child: const Text('Refresh'),
        ),
      ],
    );
  }

  Widget _buildTemperatureUnitToggle() {
    return Row(
      children: [
        const Text('Temperature Unit:'),
        const SizedBox(width: 10),
        Switch(
          value: _useFahrenheit,
          onChanged: (value) {
            setState(() {
              _useFahrenheit = value;
            });
          },
        ),
        Text(_useFahrenheit ? 'Fahrenheit' : 'Celsius'),
      ],
    );
  }

  Widget _buildWeatherContent() {
    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Card(
          color: Colors.red.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, color: Colors.red.shade700, size: 48),
                const SizedBox(height: 8),
                Text(
                  _error!,
                  style: TextStyle(color: Colors.red.shade700, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _loadWeather,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Try Again'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_weatherData != null) {
      return _buildWeatherCard(_weatherData!);
    }

    return const SizedBox.shrink();
  }

  Widget _buildWeatherCard(WeatherData data) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Row(
              spacing: 16,
              children: [
                Text(data.icon, style: const TextStyle(fontSize: 48)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.city,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        data.description,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Center(
              child: Text(
                _getFormattedTemperature(data.temperatureCelsius),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildWeatherDetail(
                  'Humidity',
                  '${data.humidity}%',
                  Icons.water_drop,
                ),
                _buildWeatherDetail(
                  'Wind Speed',
                  '${data.windSpeed} km/h',
                  Icons.air,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getFormattedTemperature(double celsius) {
    if (_useFahrenheit) {
      return '${celsiusToFahrenheit(celsius).toStringAsFixed(1)}°F';
    } else {
      return '${celsius.toStringAsFixed(1)}°C';
    }
  }

  Widget _buildWeatherDetail(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 32),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class WeatherData {
  final String city;
  final double temperatureCelsius;
  final String description;
  final int humidity;
  final double windSpeed;
  final String icon;

  WeatherData({
    required this.city,
    required this.temperatureCelsius,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.icon,
  });

  factory WeatherData.fromJson(Map<String, dynamic>? json) {
    return WeatherData(
      city: json?['city'] as String,
      temperatureCelsius: (json?['temperature'] as num).toDouble(),
      description: json?['description'] as String,
      humidity: json?['humidity'] as int,
      windSpeed: (json?['windSpeed'] as num).toDouble(),
      icon: json?['icon'] as String,
    );
  }
}
