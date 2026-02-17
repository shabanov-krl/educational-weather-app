part of '../favorites_screen.dart';

// TODO(kshabanov): rename
// TODO(kshabanov): создать отдельный блок и убрать жесткую связнось со страницей избранного.
// TODO(kshabanov): (пока не делать) сделать так чтобы поле поиска можно было на любой странице переиспользовать
// TODO(kshabanov): поправить баг чтобы при откртыии клаывы она не закрывала поле поиска
class _SearchButtonCitiesSection extends StatelessWidget {
  final bool citiesLoading;
  final List<String> allCities;
  final void Function(String city) onAddFavorite;
  final String? Function(String text) findBestMatch;
  final String? citiesErrorMessage;

  const _SearchButtonCitiesSection({
    required this.citiesLoading,
    required this.allCities,
    required this.onAddFavorite,
    required this.findBestMatch,
    required this.citiesErrorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final isLoading = citiesLoading;
    final citiesErrorMessageValue = citiesErrorMessage;
    final hasCitiesError =
        citiesErrorMessageValue != null && citiesErrorMessageValue.isNotEmpty;
    final hintText = isLoading
        ? 'Загрузка списка городов...'
        : hasCitiesError
        ? 'Список городов не загружен'
        : 'Поиск города или аэропорта';

    return Autocomplete<String>(
      optionsBuilder: (value) {
        if (isLoading) {
          return const Iterable<String>.empty();
        }

        final inputText = value.text.trim();
        if (inputText.isEmpty) {
          return const Iterable<String>.empty();
        }

        return filterCities(allCities, inputText, limit: 5);
      },
      onSelected: onAddFavorite,
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white12,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(80),
              borderSide: BorderSide.none,
            ),
          ),
          enabled: !isLoading,
          textInputAction: TextInputAction.search,
          onSubmitted: (text) {
            final match = isLoading ? null : findBestMatch(text);

            if (match != null) {
              onAddFavorite(match);
              controller.clear();
              focusNode.unfocus();
            } else {
              final message = hasCitiesError
                  ? 'Не удалось загрузить список городов'
                  : 'Город не найден';
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            }
          },
        );
      },
    );
  }
}
