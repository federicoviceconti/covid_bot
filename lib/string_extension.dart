extension StringExtension on String {
  String getEnumValue() => split('.')[1];

  String espaceCharacters() => 
    replaceAll('\_', '\\_')
    .replaceAll('!', '\!')
    .replaceAll(':', '\:')
    .replaceAll('.', '\.')
    .replaceAll('-', '\-');
}