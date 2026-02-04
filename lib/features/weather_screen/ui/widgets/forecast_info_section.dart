part of '../weather_screen.dart';


class _ForecastInfo extends StatelessWidget {
  const _ForecastInfo();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12),
      child: material.Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.event_note,
              color: Color.fromARGB(179, 177, 173, 173),
              size: 16,
            ),
            SizedBox(width: 8),
            Text(
              'Прогноз погоды на 10 дней',
              style: TextStyle(
                color: Color.fromARGB(179, 177, 173, 173),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}