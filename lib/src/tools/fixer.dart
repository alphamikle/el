import 'dart:io';

void fixPackage(String pathToFile) {
  final ProcessResult process = Process.runSync(
    'dart',
    ['fix', '--apply', pathToFile],
    runInShell: true,
  );
  process.exitCode;
}
