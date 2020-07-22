final RegExp nameRegExp = RegExp(r'[a-zA-Z]');
// or RegExp(r'\p{L}'); // see https://stackoverflow.com/questions/3617797/regex-to-match-only-letters
final RegExp numberRegExp = RegExp(r"^-?[0-9\.]+$");
final intRegex = RegExp(r'\s+(\d+)\s+', multiLine: true);
final doubleRegex = RegExp(r'\s+(\d+\.\d+)\s+', multiLine: true);
final timeRegex = RegExp(r'\s+(\d{1,2}:\d{2})\s+', multiLine: true);
// final RegExp identityRegExp = RegExp(r"^-?[a-zA-Z_]+$");
final RegExp identityRegExp = RegExp(r"^-?[a-zA-Z_]+$");

const text = '''
Lorem Ipsum is simply dummy text of the 123.456 printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an 12:30 unknown printer took a galley of type and scrambled it to make a
23.4567
type specimen book. It has 445566 survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
''';

main(List<String> args) {
  print(numberRegExp.hasMatch("\n 114234234 \n2342"));
  print(numberRegExp.hasMatch(" 1 142342342342"));
  print(numberRegExp.hasMatch("1423423,42342"));
  print(numberRegExp.hasMatch("1"));
  print(numberRegExp.hasMatch("1.0"));
  print(numberRegExp.hasMatch("1000.09999"));
  print(numberRegExp.hasMatch("0.09999"));
  print(numberRegExp.hasMatch("0.099xx9i9"));

  print("----------------------------");

  print(identityRegExp.hasMatch("input"));
  print(identityRegExp.hasMatch("1input"));
  print(identityRegExp.hasMatch("_1input"));
  print("----------------------------");
  var regExpIdentity = RegExp(r'^-?[a-zA-Z_]\w+');
  print(regExpIdentity.hasMatch('a234234'));
  print(regExpIdentity.hasMatch('_a234234'));
  print(regExpIdentity.hasMatch('1_a234234'));
}
