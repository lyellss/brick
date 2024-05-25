import 'dart:async';
import 'dart:io';

typedef OnProgressChanged = Function(double);

const _tag = 'extension_file';

extension FileExtension on File {
  /// 文件复制
  Future copyTo(
    String destinationPath, {
    OnProgressChanged? onProgressChanged,
  }) async {
    File sourceFile = this;
    if (!sourceFile.existsSync()) {
      throw Exception('$_tag sourcePath [${sourceFile.path} file not exist,please check this file');
    }

    File destinationFile = File(destinationPath);
    if (destinationFile.existsSync()) {
      destinationFile.deleteSync(recursive: true);
    }

    int totalBytes = sourceFile.lengthSync();
    int bytesWritten = 0;
    Completer completer = Completer();
    final StreamSubscription subscription = sourceFile.openRead().listen(
      (List<int> data) {
        destinationFile.writeAsBytesSync(data, mode: FileMode.append);
        bytesWritten += data.length;
        double progress = bytesWritten / totalBytes;
        onProgressChanged?.call(progress);
      },
      onDone: () {
        completer.complete(true);
      },
      onError: (error) {
        completer.completeError(error);
      },
    );
    final result = await completer.future;
    subscription.cancel();
    return result;
  }
}
