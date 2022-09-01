class _Import {
  final String package;
  final String? alias;
  // final List<String> show;

  const _Import(
    this.package, {
    this.alias,
    // this.show = const [],
  });
}

const List<_Import> _imports = <_Import>[
  _Import('package:orm/orm.dart', alias: 'runtime'),
  _Import('package:orm/dmmf.dart', alias: 'dmmf'),
];

Future<String> importsGenerator() async {
  final StringBuffer imports = StringBuffer();
  for (final _Import element in _imports) {
    imports.write('import \'${element.package}\'');
    if (element.alias != null) {
      imports.write(' as ${element.alias}');
    }
    // if (element.show.isNotEmpty) {
    //   imports.write(' show ${element.show.join(', ')}');
    // }

    imports.writeln(';');
  }

  return imports.toString();
}