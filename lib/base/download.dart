import 'dart:async';

import 'package:download/download.dart' as _downloader;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data' show Uint8List;

class DownloadTask {
  final String url;
  final String saveTo;
  final int pieces;

  DownloadTask(this.url, {required this.pieces, required this.saveTo});
}

Future<void> _downloadConcurrently(url,
    {required String saveTo,
    required int pieces,
    required int contentSize}) async {
  // download a piece
  Future<List<dynamic>> _downloadPiece(Map<String, dynamic> params) async {
    final int iterations = params['iterations'];
    final int pieceSize = params['pieceSize'];
    final int startByte = iterations * pieceSize;
    final int endByte = (iterations + 1) * pieceSize - 1;
    final response = await http
        .get(params['url'], headers: {'range': 'bytes=$startByte-$endByte'});
    return [iterations, response.bodyBytes];
  }

  List<Future> downloads = [];
  final int pieceSize = (contentSize / pieces).ceil();
  int proceeded = 0;
  List<Uint8List> responses = List.filled(pieces, Uint8List(0));
  // Cut file into pieces
  for (int i = 0; i < pieces; i++) {
    // Download a piece with isolate
    downloads.add(compute(_downloadPiece, {
      'url': url,
      'iterations': i,
      'pieceSize': pieceSize
    }).then((message) async {
      final index = message[0];
      final response = message[1];
      responses[index] = response;
      proceeded += 1;
      // If all pieces were downloaded
      if (proceeded == pieces) {
        List<int> result = [];
        for (Uint8List response in responses) {
          for (int byte in response) {
            result.add(byte);
          }
        }
        _downloader.download(Stream.fromIterable(result), saveTo);
      }
    }));
  }
  await Future.wait(downloads);
}

Future<void> _downloadNormally(url, saveTo) async {
  final response = await http.get(Uri.parse(url));
  await _downloader.download(Stream.fromIterable(response.bodyBytes), saveTo);
}

void downloadFromUrl(DownloadTask task) async {
  final url = task.url;
  final saveTo = task.saveTo;
  final pieces = task.pieces;
  final headers = (await http.head(Uri.parse(url))).headers;
  int contentSize = int.parse(headers['content-length']!);
  // Use one-thread download if content size is less than 64KB
  if (contentSize < 1024 * 64) {
    await _downloadNormally(url, saveTo);
  } else {
    await _downloadConcurrently(url,
        saveTo: saveTo, contentSize: contentSize, pieces: pieces);
  }
}
