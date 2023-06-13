import 'dart:io';

void fixPackage(String pathToFile) {
  Process.runSync(
    'dart',
    ['fix', '--apply', pathToFile],
    runInShell: true,
  );
}
