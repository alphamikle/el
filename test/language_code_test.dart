import 'package:easiest_localization/src/gen/generator_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final RegExp regExp = const GeneratorConfig().regExp;

  (String?, String?) parse(String path) {
    final RegExpMatch? match = regExp.firstMatch(path);
    return (match?.namedGroup('lang'), match?.namedGroup('country'));
  }

  test('Two-letter language codes', () {
    expect(parse('/assets/en.yaml'), ('en', null));
    expect(parse('/assets/en_CA.yaml'), ('en', 'CA'));
    expect(parse('/assets/el.yaml'), ('el', null));
    expect(parse('/assets/el_GR.yaml'), ('el', 'GR'));
    expect(parse('/assets/el_en.json'), ('en', null));
  });

  test('Three-letter language codes', () {
    expect(parse('/assets/ckb.json'), ('ckb', null));
    expect(parse('/assets/ckb_IQ.json'), ('ckb', 'IQ'));
    expect(parse('/assets/ckb-IQ.yaml'), ('ckb', 'IQ'));
    expect(parse('/assets/el_fil.yaml'), ('fil', null));
  });
}
