import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' show join, dirname;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

String _modifyMetadata(String htmlContent, String metadata, String url) {
  return htmlContent.replaceAll('<meta name="dynamic-metadata">', metadata);
}

Future<void> main() async {
  final router = Router();

  final webAppPath = join(dirname(Platform.script.toFilePath()), '../web');
  final staticHandler =
      createStaticHandler(webAppPath, defaultDocument: 'index.html');

  router.get('/event/<eventId>', (Request request, String eventId) async {
    final url = request.requestedUri.path;
    final metadata = '<meta name="event $eventId">';

    final indexFile = File(join(webAppPath, 'index.html'));
    final indexContent = await indexFile.readAsString();
    final modifiedContent = _modifyMetadata(indexContent, metadata, url);

    return Response.ok(modifiedContent, headers: {'content-type': 'text/html'});
  });

  router.all('/<path|.*>', staticHandler);

  final app = const Pipeline().addMiddleware(logRequests()).addHandler(router);
  final server = await io.serve(app, 'localhost', 8080);

  print('Serving at http://${server.address.host}:${server.port}');
}
