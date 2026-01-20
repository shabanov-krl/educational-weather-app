
import 'package:flutter/material.dart';
import 'package:test_project_weather/utility/utility.dart';

class AsyncSection<T> extends StatefulWidget {
  final Future<T> Function() load;
  final Widget Function(T data) builder;

  const AsyncSection({
    required this.load, required this.builder, super.key,
  });

  @override
  State<AsyncSection<T>> createState() => _AsyncSectionState<T>();
}

class _AsyncSectionState<T> extends State<AsyncSection<T>> {
  late Future<T> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.load();
  }

  void _retry() {
    setState(() {
      _future = widget.load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          final text = snapshot.error is WeatherException
              ? (snapshot.error as WeatherException).message
              : 'Ошибка загрузки';

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: const TextStyle(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _retry,
                  child: const Text('Повторить'),
                ),
              ],
            ),
          );
        }
        return widget.builder(snapshot.data as T);
      },
    );
  }
}
