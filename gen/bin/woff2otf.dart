// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';

class WoffConverter {
  static const int WOFF_SIGNATURE = 0x774F4646; // 'wOFF'

  Future<void> convertStreams(
    RandomAccessFile infile,
    RandomAccessFile outfile,
  ) async {
    Map<String, int> WOFFHeader = {
      'signature': _readUint32(infile),
      'flavor': _readUint32(infile),
      'length': _readUint32(infile),
      'numTables': _readUint16(infile),
      'reserved': _readUint16(infile),
      'totalSfntSize': _readUint32(infile),
      'majorVersion': _readUint16(infile),
      'minorVersion': _readUint16(infile),
      'metaOffset': _readUint32(infile),
      'metaLength': _readUint32(infile),
      'metaOrigLength': _readUint32(infile),
      'privOffset': _readUint32(infile),
      'privLength': _readUint32(infile),
    };

    await outfile.writeFrom(_packUint32(WOFFHeader['flavor']!));
    await outfile.writeFrom(_packUint16(WOFFHeader['numTables']!));

    List<List<int>> maximum = [
      for (int n = 0; n < 64; n++) [n, 1 << n],
    ].where((x) => x[1] <= WOFFHeader['numTables']!).toList();
    int searchRange = maximum.last[1] * 16;
    await outfile.writeFrom(_packUint16(searchRange));
    int entrySelector = maximum.last[0];
    await outfile.writeFrom(_packUint16(entrySelector));
    int rangeShift = WOFFHeader['numTables']! * 16 - searchRange;
    await outfile.writeFrom(_packUint16(rangeShift));

    int offset = await outfile.position();

    List<Map<String, int>> TableDirectoryEntries = [];
    for (int i = 0; i < WOFFHeader['numTables']!; i++) {
      TableDirectoryEntries.add({
        'tag': _readUint32(infile),
        'offset': _readUint32(infile),
        'compLength': _readUint32(infile),
        'origLength': _readUint32(infile),
        'origChecksum': _readUint32(infile),
      });
      offset += 4 * 4;
    }

    for (var TableDirectoryEntry in TableDirectoryEntries) {
      await outfile.writeFrom(_packUint32(TableDirectoryEntry['tag']!));
      await outfile.writeFrom(
        _packUint32(TableDirectoryEntry['origChecksum']!),
      );
      await outfile.writeFrom(_packUint32(offset));
      await outfile.writeFrom(_packUint32(TableDirectoryEntry['origLength']!));
      TableDirectoryEntry['outOffset'] = offset;
      offset += TableDirectoryEntry['origLength']!;
      if (offset % 4 != 0) {
        offset += 4 - (offset % 4);
      }
    }

    for (var TableDirectoryEntry in TableDirectoryEntries) {
      await infile.setPosition(TableDirectoryEntry['offset']!);
      Uint8List compressedData = await infile.read(
        TableDirectoryEntry['compLength']!,
      );
      Uint8List uncompressedData;
      if (TableDirectoryEntry['compLength'] !=
          TableDirectoryEntry['origLength']) {
        // uncompressedData = zlib.decode(compressedData);
        var decoder = const ZLibDecoder();
        uncompressedData = Uint8List.fromList(
          decoder.decodeBytes(compressedData),
        );
      } else {
        uncompressedData = compressedData;
      }
      await outfile.setPosition(TableDirectoryEntry['outOffset']!);
      await outfile.writeFrom(uncompressedData);
      offset =
          TableDirectoryEntry['outOffset']! +
          TableDirectoryEntry['origLength']!;
      int padding = 0;
      if (offset % 4 != 0) {
        padding = 4 - (offset % 4);
      }
      await outfile.writeFrom(Uint8List(padding));
    }
  }

  Future<void> convert(String infilename, String outfilename) async {
    var infile = await File(infilename).open(mode: FileMode.read);
    var outfile = await File(outfilename).open(mode: FileMode.write);
    await convertStreams(infile, outfile);
    await infile.close();
    await outfile.close();
  }

  void convertFile(File source, File target) async {
    if (!target.existsSync()) {
      target.createSync(recursive: true);
    }
    final infile = await source.open();
    final outfile = await target.open(mode: FileMode.write);
    await convertStreams(infile, outfile);
    await infile.close();
    await outfile.close();
  }

  int _readUint32(RandomAccessFile file) {
    var bytes = file.readSync(4);
    return ByteData.sublistView(bytes).getUint32(0, Endian.big);
  }

  int _readUint16(RandomAccessFile file) {
    var bytes = file.readSync(2);
    return ByteData.sublistView(bytes).getUint16(0, Endian.big);
  }

  List<int> _packUint32(int value) {
    var bytes = ByteData(4);
    bytes.setUint32(0, value, Endian.big);
    return bytes.buffer.asUint8List();
  }

  List<int> _packUint16(int value) {
    var bytes = ByteData(2);
    bytes.setUint16(0, value, Endian.big);
    return bytes.buffer.asUint8List();
  }
}
