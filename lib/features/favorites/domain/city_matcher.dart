
List<String> filterCities(List<String> allCities, String query, {int limit = 5}) {
  final normQuery = query.trim().toLowerCase();

  if (normQuery.isEmpty) {
    return const [];
  }

  final starts = <String>[];
  final contains = <String>[];

  for (final city in allCities) {
    final lower = city.toLowerCase();
    
    if (lower.startsWith(normQuery)) {
      starts.add(city);
    } else if (lower.contains(normQuery)) {
      contains.add(city);
    }
  }

  final matches = <String>[...starts, ...contains];
  if (matches.length > limit) {
    return matches.sublist(0, limit);
  }
  return matches;
}


String? findBestMatch(List<String> allCities, String input) {
  final normQuery = input.trim().toLowerCase();

  if (normQuery.isEmpty) {
    return null;
  }

  final exact = allCities.firstWhere(
    (city) => city.toLowerCase() == normQuery,
    orElse: () => '',
  );
  if (exact.isNotEmpty) {
    return exact;
  }

  final starts = allCities.where((city) => city.toLowerCase().startsWith(normQuery));
  if (starts.isNotEmpty) {
    return starts.first;
  }

  final contains = allCities.where((city) => city.toLowerCase().contains(normQuery));
  if (contains.isNotEmpty) {
    return contains.first;
  }

  return null;
}