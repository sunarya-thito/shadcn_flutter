
// `modulePromise` is a promise to the `WebAssembly.module` object to be
//   instantiated.
// `importObjectPromise` is a promise to an object that contains any additional
//   imports needed by the module that aren't provided by the standard runtime.
//   The fields on this object will be merged into the importObject with which
//   the module will be instantiated.
// This function returns a promise to the instantiated module.
export const instantiate = async (modulePromise, importObjectPromise) => {
    let dartInstance;

    // Prints to the console
    function printToConsole(value) {
      if (typeof dartPrint == "function") {
        dartPrint(value);
        return;
      }
      if (typeof console == "object" && typeof console.log != "undefined") {
        console.log(value);
        return;
      }
      if (typeof print == "function") {
        print(value);
        return;
      }

      throw "Unable to print message: " + js;
    }

    // Converts a Dart List to a JS array. Any Dart objects will be converted, but
    // this will be cheap for JSValues.
    function arrayFromDartList(constructor, list) {
      const exports = dartInstance.exports;
      const read = exports.$listRead;
      const length = exports.$listLength(list);
      const array = new constructor(length);
      for (let i = 0; i < length; i++) {
        array[i] = read(list, i);
      }
      return array;
    }

    // A special symbol attached to functions that wrap Dart functions.
    const jsWrappedDartFunctionSymbol = Symbol("JSWrappedDartFunction");

    function finalizeWrapper(dartFunction, wrapped) {
      wrapped.dartFunction = dartFunction;
      wrapped[jsWrappedDartFunctionSymbol] = true;
      return wrapped;
    }

    // Imports
    const dart2wasm = {

_1: (x0,x1,x2) => x0.set(x1,x2),
_2: (x0,x1,x2) => x0.set(x1,x2),
_3: (x0,x1) => x0.transferFromImageBitmap(x1),
_4: x0 => x0.arrayBuffer(),
_5: (x0,x1) => x0.transferFromImageBitmap(x1),
_6: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._6(f,arguments.length,x0) }),
_7: x0 => new window.FinalizationRegistry(x0),
_8: (x0,x1,x2,x3) => x0.register(x1,x2,x3),
_9: (x0,x1) => x0.unregister(x1),
_10: (x0,x1,x2) => x0.slice(x1,x2),
_11: (x0,x1) => x0.decode(x1),
_12: (x0,x1) => x0.segment(x1),
_13: () => new TextDecoder(),
_14: x0 => x0.buffer,
_15: x0 => x0.wasmMemory,
_16: () => globalThis.window._flutter_skwasmInstance,
_17: x0 => x0.rasterStartMilliseconds,
_18: x0 => x0.rasterEndMilliseconds,
_19: x0 => x0.imageBitmaps,
_167: x0 => x0.select(),
_168: (x0,x1) => x0.append(x1),
_169: x0 => x0.remove(),
_172: x0 => x0.unlock(),
_177: x0 => x0.getReader(),
_187: x0 => new MutationObserver(x0),
_204: (x0,x1) => new OffscreenCanvas(x0,x1),
_206: (x0,x1,x2) => x0.addEventListener(x1,x2),
_207: (x0,x1,x2) => x0.removeEventListener(x1,x2),
_210: x0 => new ResizeObserver(x0),
_213: (x0,x1) => new Intl.Segmenter(x0,x1),
_214: x0 => x0.next(),
_215: (x0,x1) => new Intl.v8BreakIterator(x0,x1),
_292: x0 => x0.close(),
_293: (x0,x1,x2,x3,x4) => ({type: x0,data: x1,premultiplyAlpha: x2,colorSpaceConversion: x3,preferAnimation: x4}),
_294: x0 => new window.ImageDecoder(x0),
_295: x0 => x0.close(),
_296: x0 => ({frameIndex: x0}),
_297: (x0,x1) => x0.decode(x1),
_300: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._300(f,arguments.length,x0) }),
_301: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._301(f,arguments.length,x0) }),
_302: (x0,x1) => ({addView: x0,removeView: x1}),
_303: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._303(f,arguments.length,x0) }),
_304: f => finalizeWrapper(f, function() { return dartInstance.exports._304(f,arguments.length) }),
_305: (x0,x1) => ({initializeEngine: x0,autoStart: x1}),
_306: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._306(f,arguments.length,x0) }),
_307: x0 => ({runApp: x0}),
_308: x0 => new Uint8Array(x0),
_310: x0 => x0.preventDefault(),
_311: x0 => x0.stopPropagation(),
_312: (x0,x1) => x0.addListener(x1),
_313: (x0,x1) => x0.removeListener(x1),
_314: (x0,x1) => x0.prepend(x1),
_315: x0 => x0.remove(),
_316: x0 => x0.disconnect(),
_317: (x0,x1) => x0.addListener(x1),
_318: (x0,x1) => x0.removeListener(x1),
_320: (x0,x1) => x0.append(x1),
_321: x0 => x0.remove(),
_322: x0 => x0.stopPropagation(),
_326: x0 => x0.preventDefault(),
_327: (x0,x1) => x0.append(x1),
_328: x0 => x0.remove(),
_329: x0 => x0.preventDefault(),
_330: x0 => x0.preventDefault(),
_335: (x0,x1) => x0.appendChild(x1),
_336: (x0,x1,x2) => x0.insertBefore(x1,x2),
_337: (x0,x1) => x0.removeChild(x1),
_338: (x0,x1) => x0.appendChild(x1),
_339: (x0,x1) => x0.transferFromImageBitmap(x1),
_340: (x0,x1) => x0.append(x1),
_341: (x0,x1) => x0.append(x1),
_342: (x0,x1) => x0.append(x1),
_343: x0 => x0.remove(),
_344: x0 => x0.remove(),
_345: x0 => x0.remove(),
_346: (x0,x1) => x0.appendChild(x1),
_347: (x0,x1) => x0.appendChild(x1),
_348: x0 => x0.remove(),
_349: (x0,x1) => x0.append(x1),
_350: (x0,x1) => x0.append(x1),
_351: x0 => x0.remove(),
_352: (x0,x1) => x0.append(x1),
_353: (x0,x1) => x0.append(x1),
_354: (x0,x1,x2) => x0.insertBefore(x1,x2),
_355: (x0,x1) => x0.append(x1),
_356: (x0,x1,x2) => x0.insertBefore(x1,x2),
_357: x0 => x0.remove(),
_358: x0 => x0.remove(),
_359: (x0,x1) => x0.append(x1),
_360: x0 => x0.remove(),
_361: (x0,x1) => x0.append(x1),
_362: x0 => x0.remove(),
_363: x0 => x0.remove(),
_364: x0 => x0.getBoundingClientRect(),
_365: x0 => x0.remove(),
_366: x0 => x0.blur(),
_367: x0 => x0.remove(),
_368: x0 => x0.blur(),
_369: x0 => x0.remove(),
_382: (x0,x1) => x0.append(x1),
_383: x0 => x0.remove(),
_384: (x0,x1) => x0.append(x1),
_385: (x0,x1,x2) => x0.insertBefore(x1,x2),
_386: x0 => x0.preventDefault(),
_387: x0 => x0.preventDefault(),
_388: x0 => x0.preventDefault(),
_389: x0 => x0.preventDefault(),
_390: x0 => x0.remove(),
_391: (x0,x1) => x0.observe(x1),
_392: x0 => x0.disconnect(),
_393: (x0,x1) => x0.appendChild(x1),
_394: (x0,x1) => x0.appendChild(x1),
_395: (x0,x1) => x0.appendChild(x1),
_396: (x0,x1) => x0.append(x1),
_397: x0 => x0.remove(),
_398: (x0,x1) => x0.append(x1),
_400: (x0,x1) => x0.appendChild(x1),
_401: (x0,x1) => x0.append(x1),
_402: x0 => x0.remove(),
_403: (x0,x1) => x0.append(x1),
_407: (x0,x1) => x0.appendChild(x1),
_408: x0 => x0.remove(),
_968: () => globalThis.window.flutterConfiguration,
_969: x0 => x0.assetBase,
_974: x0 => x0.debugShowSemanticsNodes,
_975: x0 => x0.hostElement,
_976: x0 => x0.multiViewEnabled,
_977: x0 => x0.nonce,
_979: x0 => x0.fontFallbackBaseUrl,
_980: x0 => x0.useColorEmoji,
_984: x0 => x0.console,
_985: x0 => x0.devicePixelRatio,
_986: x0 => x0.document,
_987: x0 => x0.history,
_988: x0 => x0.innerHeight,
_989: x0 => x0.innerWidth,
_990: x0 => x0.location,
_991: x0 => x0.navigator,
_992: x0 => x0.visualViewport,
_993: x0 => x0.performance,
_995: (x0,x1) => x0.fetch(x1),
_998: (x0,x1) => x0.dispatchEvent(x1),
_999: (x0,x1) => x0.matchMedia(x1),
_1000: (x0,x1) => x0.getComputedStyle(x1),
_1002: x0 => x0.screen,
_1003: (x0,x1) => x0.requestAnimationFrame(x1),
_1004: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1004(f,arguments.length,x0) }),
_1009: (x0,x1) => x0.warn(x1),
_1013: () => globalThis.window,
_1014: () => globalThis.Intl,
_1015: () => globalThis.Symbol,
_1018: x0 => x0.clipboard,
_1019: x0 => x0.maxTouchPoints,
_1020: x0 => x0.vendor,
_1021: x0 => x0.language,
_1022: x0 => x0.platform,
_1023: x0 => x0.userAgent,
_1024: x0 => x0.languages,
_1025: x0 => x0.documentElement,
_1026: (x0,x1) => x0.querySelector(x1),
_1028: (x0,x1) => x0.createElement(x1),
_1030: (x0,x1) => x0.execCommand(x1),
_1034: (x0,x1) => x0.createTextNode(x1),
_1035: (x0,x1) => x0.createEvent(x1),
_1039: x0 => x0.head,
_1040: x0 => x0.body,
_1041: (x0,x1) => x0.title = x1,
_1044: x0 => x0.activeElement,
_1046: x0 => x0.visibilityState,
_1047: () => globalThis.document,
_1048: (x0,x1,x2) => x0.addEventListener(x1,x2),
_1049: (x0,x1,x2,x3) => x0.addEventListener(x1,x2,x3),
_1050: (x0,x1,x2,x3) => x0.addEventListener(x1,x2,x3),
_1052: (x0,x1,x2) => x0.removeEventListener(x1,x2),
_1055: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1055(f,arguments.length,x0) }),
_1056: x0 => x0.target,
_1058: x0 => x0.timeStamp,
_1059: x0 => x0.type,
_1060: x0 => x0._cancelable,
_1061: x0 => x0.preventDefault(),
_1065: (x0,x1,x2,x3) => x0.initEvent(x1,x2,x3),
_1070: x0 => x0.firstChild,
_1075: x0 => x0.parentElement,
_1077: x0 => x0.parentNode,
_1080: (x0,x1) => x0.removeChild(x1),
_1081: (x0,x1) => x0.removeChild(x1),
_1082: x0 => x0.isConnected,
_1083: (x0,x1) => x0.textContent = x1,
_1087: (x0,x1) => x0.contains(x1),
_1092: x0 => x0.firstElementChild,
_1094: x0 => x0.nextElementSibling,
_1095: x0 => x0.clientHeight,
_1096: x0 => x0.clientWidth,
_1097: x0 => x0.offsetHeight,
_1098: x0 => x0.offsetWidth,
_1099: x0 => x0.id,
_1100: (x0,x1) => x0.id = x1,
_1103: (x0,x1) => x0.spellcheck = x1,
_1104: x0 => x0.tagName,
_1105: x0 => x0.style,
_1106: (x0,x1) => x0.append(x1),
_1107: (x0,x1) => x0.getAttribute(x1),
_1108: x0 => x0.getBoundingClientRect(),
_1111: (x0,x1) => x0.closest(x1),
_1113: (x0,x1) => x0.querySelectorAll(x1),
_1114: x0 => x0.remove(),
_1115: (x0,x1,x2) => x0.setAttribute(x1,x2),
_1117: (x0,x1) => x0.removeAttribute(x1),
_1118: (x0,x1) => x0.tabIndex = x1,
_1121: (x0,x1) => x0.focus(x1),
_1122: x0 => x0.scrollTop,
_1123: (x0,x1) => x0.scrollTop = x1,
_1124: x0 => x0.scrollLeft,
_1125: (x0,x1) => x0.scrollLeft = x1,
_1126: x0 => x0.classList,
_1127: (x0,x1) => x0.className = x1,
_1131: (x0,x1) => x0.getElementsByClassName(x1),
_1132: x0 => x0.click(),
_1134: (x0,x1) => x0.hasAttribute(x1),
_1136: (x0,x1) => x0.attachShadow(x1),
_1140: (x0,x1) => x0.getPropertyValue(x1),
_1142: (x0,x1,x2,x3) => x0.setProperty(x1,x2,x3),
_1144: (x0,x1) => x0.removeProperty(x1),
_1146: x0 => x0.offsetLeft,
_1147: x0 => x0.offsetTop,
_1148: x0 => x0.offsetParent,
_1150: (x0,x1) => x0.name = x1,
_1151: x0 => x0.content,
_1152: (x0,x1) => x0.content = x1,
_1165: (x0,x1) => x0.nonce = x1,
_1170: x0 => x0.now(),
_1172: (x0,x1) => x0.width = x1,
_1174: (x0,x1) => x0.height = x1,
_1178: (x0,x1) => x0.getContext(x1),
_1248: x0 => x0.width,
_1249: x0 => x0.height,
_1253: x0 => x0.status,
_1254: x0 => x0.headers,
_1255: x0 => x0.body,
_1256: x0 => x0.arrayBuffer(),
_1259: (x0,x1) => x0.get(x1),
_1261: x0 => x0.read(),
_1262: x0 => x0.value,
_1263: x0 => x0.done,
_1265: x0 => x0.name,
_1266: x0 => x0.x,
_1267: x0 => x0.y,
_1270: x0 => x0.top,
_1271: x0 => x0.right,
_1272: x0 => x0.bottom,
_1273: x0 => x0.left,
_1282: x0 => x0.height,
_1283: x0 => x0.width,
_1284: (x0,x1) => x0.value = x1,
_1286: (x0,x1) => x0.placeholder = x1,
_1287: (x0,x1) => x0.name = x1,
_1288: x0 => x0.selectionDirection,
_1289: x0 => x0.selectionStart,
_1290: x0 => x0.selectionEnd,
_1293: x0 => x0.value,
_1294: (x0,x1,x2) => x0.setSelectionRange(x1,x2),
_1299: x0 => x0.readText(),
_1300: (x0,x1) => x0.writeText(x1),
_1301: x0 => x0.altKey,
_1302: x0 => x0.code,
_1303: x0 => x0.ctrlKey,
_1304: x0 => x0.key,
_1305: x0 => x0.keyCode,
_1306: x0 => x0.location,
_1307: x0 => x0.metaKey,
_1308: x0 => x0.repeat,
_1309: x0 => x0.shiftKey,
_1310: x0 => x0.isComposing,
_1311: (x0,x1) => x0.getModifierState(x1),
_1312: x0 => x0.state,
_1314: (x0,x1) => x0.go(x1),
_1315: (x0,x1,x2,x3) => x0.pushState(x1,x2,x3),
_1316: (x0,x1,x2,x3) => x0.replaceState(x1,x2,x3),
_1317: x0 => x0.pathname,
_1318: x0 => x0.search,
_1319: x0 => x0.hash,
_1322: x0 => x0.state,
_1327: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1327(f,arguments.length,x0,x1) }),
_1329: (x0,x1,x2) => x0.observe(x1,x2),
_1332: x0 => x0.attributeName,
_1333: x0 => x0.type,
_1334: x0 => x0.matches,
_1338: x0 => x0.matches,
_1339: x0 => x0.relatedTarget,
_1340: x0 => x0.clientX,
_1341: x0 => x0.clientY,
_1342: x0 => x0.offsetX,
_1343: x0 => x0.offsetY,
_1346: x0 => x0.button,
_1347: x0 => x0.buttons,
_1348: x0 => x0.ctrlKey,
_1349: (x0,x1) => x0.getModifierState(x1),
_1350: x0 => x0.pointerId,
_1351: x0 => x0.pointerType,
_1352: x0 => x0.pressure,
_1353: x0 => x0.tiltX,
_1354: x0 => x0.tiltY,
_1355: x0 => x0.getCoalescedEvents(),
_1356: x0 => x0.deltaX,
_1357: x0 => x0.deltaY,
_1358: x0 => x0.wheelDeltaX,
_1359: x0 => x0.wheelDeltaY,
_1360: x0 => x0.deltaMode,
_1365: x0 => x0.changedTouches,
_1367: x0 => x0.clientX,
_1368: x0 => x0.clientY,
_1369: x0 => x0.data,
_1370: (x0,x1) => x0.type = x1,
_1371: (x0,x1) => x0.max = x1,
_1372: (x0,x1) => x0.min = x1,
_1373: (x0,x1) => x0.value = x1,
_1374: x0 => x0.value,
_1375: x0 => x0.disabled,
_1376: (x0,x1) => x0.disabled = x1,
_1377: (x0,x1) => x0.placeholder = x1,
_1378: (x0,x1) => x0.name = x1,
_1379: (x0,x1) => x0.autocomplete = x1,
_1380: x0 => x0.selectionDirection,
_1381: x0 => x0.selectionStart,
_1382: x0 => x0.selectionEnd,
_1386: (x0,x1,x2) => x0.setSelectionRange(x1,x2),
_1393: (x0,x1) => x0.add(x1),
_1396: (x0,x1) => x0.noValidate = x1,
_1397: (x0,x1) => x0.method = x1,
_1398: (x0,x1) => x0.action = x1,
_1403: (x0,x1) => x0.getContext(x1),
_1406: x0 => x0.convertToBlob(),
_1426: x0 => x0.orientation,
_1427: x0 => x0.width,
_1428: x0 => x0.height,
_1429: (x0,x1) => x0.lock(x1),
_1446: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1446(f,arguments.length,x0,x1) }),
_1456: x0 => x0.length,
_1457: (x0,x1) => x0.item(x1),
_1458: x0 => x0.length,
_1459: (x0,x1) => x0.item(x1),
_1460: x0 => x0.iterator,
_1461: x0 => x0.Segmenter,
_1462: x0 => x0.v8BreakIterator,
_1465: x0 => x0.done,
_1466: x0 => x0.value,
_1467: x0 => x0.index,
_1471: (x0,x1) => x0.adoptText(x1),
_1473: x0 => x0.first(),
_1474: x0 => x0.next(),
_1475: x0 => x0.current(),
_1487: x0 => x0.hostElement,
_1488: x0 => x0.viewConstraints,
_1490: x0 => x0.maxHeight,
_1491: x0 => x0.maxWidth,
_1492: x0 => x0.minHeight,
_1493: x0 => x0.minWidth,
_1494: x0 => x0.loader,
_1495: () => globalThis._flutter,
_1496: (x0,x1) => x0.didCreateEngineInitializer(x1),
_1497: (x0,x1,x2) => x0.call(x1,x2),
_1498: () => globalThis.Promise,
_1499: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1499(f,arguments.length,x0,x1) }),
_1504: x0 => x0.length,
_1507: x0 => x0.tracks,
_1511: x0 => x0.image,
_1516: x0 => x0.codedWidth,
_1517: x0 => x0.codedHeight,
_1520: x0 => x0.duration,
_1524: x0 => x0.ready,
_1525: x0 => x0.selectedTrack,
_1526: x0 => x0.repetitionCount,
_1527: x0 => x0.frameCount,
_1572: x0 => new Event(x0),
_1573: (x0,x1) => x0.dispatchEvent(x1),
_1574: (x0,x1,x2) => new ShadcnAppTheme(x0,x1,x2),
_1575: x0 => new ShadcnAppThemeChangedEvent(x0),
_1576: (x0,x1) => x0.dispatchEvent(x1),
_1578: x0 => x0.globalThis,
_1579: x0 => x0.ShadcnApp,
_1581: () => globalThis.window,
_1584: (x0,x1,x2,x3) => x0.open(x1,x2,x3),
_1585: (x0,x1,x2) => x0.setRequestHeader(x1,x2),
_1586: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1586(f,arguments.length,x0) }),
_1587: (x0,x1,x2) => x0.addEventListener(x1,x2),
_1588: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1588(f,arguments.length,x0) }),
_1589: x0 => x0.send(),
_1590: () => new XMLHttpRequest(),
_1591: (x0,x1,x2,x3) => x0.addEventListener(x1,x2,x3),
_1593: (x0,x1) => x0.createElement(x1),
_1601: (x0,x1,x2,x3) => x0.removeEventListener(x1,x2,x3),
_1604: (x0,x1,x2,x3) => x0.open(x1,x2,x3),
_1623: (x0,x1) => x0.getItem(x1),
_1625: (x0,x1,x2) => x0.setItem(x1,x2),
_1629: (x0,x1) => x0.querySelector(x1),
_1630: (x0,x1) => x0.querySelector(x1),
_1657: x0 => new Array(x0),
_1664: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1664(f,arguments.length,x0) }),
_1665: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1665(f,arguments.length,x0) }),
_1670: (o, a) => o + a,
_1691: (decoder, codeUnits) => decoder.decode(codeUnits),
_1692: () => new TextDecoder("utf-8", {fatal: true}),
_1693: () => new TextDecoder("utf-8", {fatal: false}),
_1694: v => v.toString(),
_1695: (d, digits) => d.toFixed(digits),
_1699: x0 => new WeakRef(x0),
_1700: x0 => x0.deref(),
_1706: Date.now,
_1708: s => new Date(s * 1000).getTimezoneOffset() * 60 ,
_1709: s => {
      if (!/^\s*[+-]?(?:Infinity|NaN|(?:\.\d+|\d+(?:\.\d*)?)(?:[eE][+-]?\d+)?)\s*$/.test(s)) {
        return NaN;
      }
      return parseFloat(s);
    },
_1710: () => {
          let stackString = new Error().stack.toString();
          let frames = stackString.split('\n');
          let drop = 2;
          if (frames[0] === 'Error') {
              drop += 1;
          }
          return frames.slice(drop).join('\n');
        },
_1711: () => typeof dartUseDateNowForTicks !== "undefined",
_1712: () => 1000 * performance.now(),
_1713: () => Date.now(),
_1714: () => {
      // On browsers return `globalThis.location.href`
      if (globalThis.location != null) {
        return globalThis.location.href;
      }
      return null;
    },
_1715: () => {
        return typeof process != "undefined" &&
               Object.prototype.toString.call(process) == "[object process]" &&
               process.platform == "win32"
      },
_1716: () => new WeakMap(),
_1717: (map, o) => map.get(o),
_1718: (map, o, v) => map.set(o, v),
_1719: () => globalThis.WeakRef,
_1730: s => JSON.stringify(s),
_1731: s => printToConsole(s),
_1732: a => a.join(''),
_1735: (s, t) => s.split(t),
_1736: s => s.toLowerCase(),
_1737: s => s.toUpperCase(),
_1738: s => s.trim(),
_1739: s => s.trimLeft(),
_1740: s => s.trimRight(),
_1742: (s, p, i) => s.indexOf(p, i),
_1743: (s, p, i) => s.lastIndexOf(p, i),
_1745: Object.is,
_1746: s => s.toUpperCase(),
_1747: s => s.toLowerCase(),
_1748: (a, i) => a.push(i),
_1752: a => a.pop(),
_1753: (a, i) => a.splice(i, 1),
_1755: (a, s) => a.join(s),
_1756: (a, s, e) => a.slice(s, e),
_1758: (a, b) => a == b ? 0 : (a > b ? 1 : -1),
_1759: a => a.length,
_1761: (a, i) => a[i],
_1762: (a, i, v) => a[i] = v,
_1764: (o, offsetInBytes, lengthInBytes) => {
      var dst = new ArrayBuffer(lengthInBytes);
      new Uint8Array(dst).set(new Uint8Array(o, offsetInBytes, lengthInBytes));
      return new DataView(dst);
    },
_1765: (o, start, length) => new Uint8Array(o.buffer, o.byteOffset + start, length),
_1766: (o, start, length) => new Int8Array(o.buffer, o.byteOffset + start, length),
_1767: (o, start, length) => new Uint8ClampedArray(o.buffer, o.byteOffset + start, length),
_1768: (o, start, length) => new Uint16Array(o.buffer, o.byteOffset + start, length),
_1769: (o, start, length) => new Int16Array(o.buffer, o.byteOffset + start, length),
_1770: (o, start, length) => new Uint32Array(o.buffer, o.byteOffset + start, length),
_1771: (o, start, length) => new Int32Array(o.buffer, o.byteOffset + start, length),
_1773: (o, start, length) => new BigInt64Array(o.buffer, o.byteOffset + start, length),
_1774: (o, start, length) => new Float32Array(o.buffer, o.byteOffset + start, length),
_1775: (o, start, length) => new Float64Array(o.buffer, o.byteOffset + start, length),
_1776: (t, s) => t.set(s),
_1778: (o) => new DataView(o.buffer, o.byteOffset, o.byteLength),
_1780: o => o.buffer,
_1781: o => o.byteOffset,
_1782: Function.prototype.call.bind(Object.getOwnPropertyDescriptor(DataView.prototype, 'byteLength').get),
_1783: (b, o) => new DataView(b, o),
_1784: (b, o, l) => new DataView(b, o, l),
_1785: Function.prototype.call.bind(DataView.prototype.getUint8),
_1786: Function.prototype.call.bind(DataView.prototype.setUint8),
_1787: Function.prototype.call.bind(DataView.prototype.getInt8),
_1788: Function.prototype.call.bind(DataView.prototype.setInt8),
_1789: Function.prototype.call.bind(DataView.prototype.getUint16),
_1790: Function.prototype.call.bind(DataView.prototype.setUint16),
_1791: Function.prototype.call.bind(DataView.prototype.getInt16),
_1792: Function.prototype.call.bind(DataView.prototype.setInt16),
_1793: Function.prototype.call.bind(DataView.prototype.getUint32),
_1794: Function.prototype.call.bind(DataView.prototype.setUint32),
_1795: Function.prototype.call.bind(DataView.prototype.getInt32),
_1796: Function.prototype.call.bind(DataView.prototype.setInt32),
_1799: Function.prototype.call.bind(DataView.prototype.getBigInt64),
_1800: Function.prototype.call.bind(DataView.prototype.setBigInt64),
_1801: Function.prototype.call.bind(DataView.prototype.getFloat32),
_1802: Function.prototype.call.bind(DataView.prototype.setFloat32),
_1803: Function.prototype.call.bind(DataView.prototype.getFloat64),
_1804: Function.prototype.call.bind(DataView.prototype.setFloat64),
_1818: (o, t) => o instanceof t,
_1820: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1820(f,arguments.length,x0) }),
_1821: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1821(f,arguments.length,x0) }),
_1822: o => Object.keys(o),
_1823: (ms, c) =>
              setTimeout(() => dartInstance.exports.$invokeCallback(c),ms),
_1824: (handle) => clearTimeout(handle),
_1825: (ms, c) =>
          setInterval(() => dartInstance.exports.$invokeCallback(c), ms),
_1826: (handle) => clearInterval(handle),
_1827: (c) =>
              queueMicrotask(() => dartInstance.exports.$invokeCallback(c)),
_1828: () => Date.now(),
_1829: () => new XMLHttpRequest(),
_1830: (x0,x1,x2,x3) => x0.open(x1,x2,x3),
_1831: (x0,x1,x2) => x0.setRequestHeader(x1,x2),
_1832: (x0,x1) => x0.send(x1),
_1833: x0 => x0.abort(),
_1834: x0 => x0.getAllResponseHeaders(),
_1841: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1841(f,arguments.length,x0) }),
_1842: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1842(f,arguments.length,x0) }),
_1874: (x0,x1) => x0.key(x1),
_1876: (s, m) => {
          try {
            return new RegExp(s, m);
          } catch (e) {
            return String(e);
          }
        },
_1877: (x0,x1) => x0.exec(x1),
_1878: (x0,x1) => x0.test(x1),
_1879: (x0,x1) => x0.exec(x1),
_1880: (x0,x1) => x0.exec(x1),
_1881: x0 => x0.pop(),
_1885: (x0,x1,x2) => x0[x1] = x2,
_1887: o => o === undefined,
_1888: o => typeof o === 'boolean',
_1889: o => typeof o === 'number',
_1891: o => typeof o === 'string',
_1894: o => o instanceof Int8Array,
_1895: o => o instanceof Uint8Array,
_1896: o => o instanceof Uint8ClampedArray,
_1897: o => o instanceof Int16Array,
_1898: o => o instanceof Uint16Array,
_1899: o => o instanceof Int32Array,
_1900: o => o instanceof Uint32Array,
_1901: o => o instanceof Float32Array,
_1902: o => o instanceof Float64Array,
_1903: o => o instanceof ArrayBuffer,
_1904: o => o instanceof DataView,
_1905: o => o instanceof Array,
_1906: o => typeof o === 'function' && o[jsWrappedDartFunctionSymbol] === true,
_1908: o => {
            const proto = Object.getPrototypeOf(o);
            return proto === Object.prototype || proto === null;
          },
_1909: o => o instanceof RegExp,
_1910: (l, r) => l === r,
_1911: o => o,
_1912: o => o,
_1913: o => o,
_1914: b => !!b,
_1915: o => o.length,
_1918: (o, i) => o[i],
_1919: f => f.dartFunction,
_1920: l => arrayFromDartList(Int8Array, l),
_1921: (data, length) => {
          const jsBytes = new Uint8Array(length);
          const getByte = dartInstance.exports.$uint8ListGet;
          for (let i = 0; i < length; i++) {
            jsBytes[i] = getByte(data, i);
          }
          return jsBytes;
        },
_1922: l => arrayFromDartList(Uint8ClampedArray, l),
_1923: l => arrayFromDartList(Int16Array, l),
_1924: l => arrayFromDartList(Uint16Array, l),
_1925: l => arrayFromDartList(Int32Array, l),
_1926: l => arrayFromDartList(Uint32Array, l),
_1927: l => arrayFromDartList(Float32Array, l),
_1928: l => arrayFromDartList(Float64Array, l),
_1929: (data, length) => {
          const read = dartInstance.exports.$byteDataGetUint8;
          const view = new DataView(new ArrayBuffer(length));
          for (let i = 0; i < length; i++) {
              view.setUint8(i, read(data, i));
          }
          return view;
        },
_1930: l => arrayFromDartList(Array, l),
_1931:       (s, length) => {
        if (length == 0) return '';

        const read = dartInstance.exports.$stringRead1;
        let result = '';
        let index = 0;
        const chunkLength = Math.min(length - index, 500);
        let array = new Array(chunkLength);
        while (index < length) {
          const newChunkLength = Math.min(length - index, 500);
          for (let i = 0; i < newChunkLength; i++) {
            array[i] = read(s, index++);
          }
          if (newChunkLength < chunkLength) {
            array = array.slice(0, newChunkLength);
          }
          result += String.fromCharCode(...array);
        }
        return result;
      }
      ,
_1932:     (s, length) => {
      if (length == 0) return '';

      const read = dartInstance.exports.$stringRead2;
      let result = '';
      let index = 0;
      const chunkLength = Math.min(length - index, 500);
      let array = new Array(chunkLength);
      while (index < length) {
        const newChunkLength = Math.min(length - index, 500);
        for (let i = 0; i < newChunkLength; i++) {
          array[i] = read(s, index++);
        }
        if (newChunkLength < chunkLength) {
          array = array.slice(0, newChunkLength);
        }
        result += String.fromCharCode(...array);
      }
      return result;
    }
    ,
_1933:     (s) => {
      let length = s.length;
      let range = 0;
      for (let i = 0; i < length; i++) {
        range |= s.codePointAt(i);
      }
      const exports = dartInstance.exports;
      if (range < 256) {
        if (length <= 10) {
          if (length == 1) {
            return exports.$stringAllocate1_1(s.codePointAt(0));
          }
          if (length == 2) {
            return exports.$stringAllocate1_2(s.codePointAt(0), s.codePointAt(1));
          }
          if (length == 3) {
            return exports.$stringAllocate1_3(s.codePointAt(0), s.codePointAt(1), s.codePointAt(2));
          }
          if (length == 4) {
            return exports.$stringAllocate1_4(s.codePointAt(0), s.codePointAt(1), s.codePointAt(2), s.codePointAt(3));
          }
          if (length == 5) {
            return exports.$stringAllocate1_5(s.codePointAt(0), s.codePointAt(1), s.codePointAt(2), s.codePointAt(3), s.codePointAt(4));
          }
          if (length == 6) {
            return exports.$stringAllocate1_6(s.codePointAt(0), s.codePointAt(1), s.codePointAt(2), s.codePointAt(3), s.codePointAt(4), s.codePointAt(5));
          }
          if (length == 7) {
            return exports.$stringAllocate1_7(s.codePointAt(0), s.codePointAt(1), s.codePointAt(2), s.codePointAt(3), s.codePointAt(4), s.codePointAt(5), s.codePointAt(6));
          }
          if (length == 8) {
            return exports.$stringAllocate1_8(s.codePointAt(0), s.codePointAt(1), s.codePointAt(2), s.codePointAt(3), s.codePointAt(4), s.codePointAt(5), s.codePointAt(6), s.codePointAt(7));
          }
          if (length == 9) {
            return exports.$stringAllocate1_9(s.codePointAt(0), s.codePointAt(1), s.codePointAt(2), s.codePointAt(3), s.codePointAt(4), s.codePointAt(5), s.codePointAt(6), s.codePointAt(7), s.codePointAt(8));
          }
          if (length == 10) {
            return exports.$stringAllocate1_10(s.codePointAt(0), s.codePointAt(1), s.codePointAt(2), s.codePointAt(3), s.codePointAt(4), s.codePointAt(5), s.codePointAt(6), s.codePointAt(7), s.codePointAt(8), s.codePointAt(9));
          }
        }
        const dartString = exports.$stringAllocate1(length);
        const write = exports.$stringWrite1;
        for (let i = 0; i < length; i++) {
          write(dartString, i, s.codePointAt(i));
        }
        return dartString;
      } else {
        const dartString = exports.$stringAllocate2(length);
        const write = exports.$stringWrite2;
        for (let i = 0; i < length; i++) {
          write(dartString, i, s.charCodeAt(i));
        }
        return dartString;
      }
    }
    ,
_1934: () => ({}),
_1935: () => [],
_1936: l => new Array(l),
_1937: () => globalThis,
_1938: (constructor, args) => {
      const factoryFunction = constructor.bind.apply(
          constructor, [null, ...args]);
      return new factoryFunction();
    },
_1939: (o, p) => p in o,
_1940: (o, p) => o[p],
_1941: (o, p, v) => o[p] = v,
_1942: (o, m, a) => o[m].apply(o, a),
_1944: o => String(o),
_1945: (p, s, f) => p.then(s, f),
_1946: s => {
      if (/[[\]{}()*+?.\\^$|]/.test(s)) {
          s = s.replace(/[[\]{}()*+?.\\^$|]/g, '\\$&');
      }
      return s;
    },
_1949: x0 => x0.index,
_1950: x0 => x0.groups,
_1951: x0 => x0.length,
_1953: (x0,x1) => x0[x1],
_1956: x0 => x0.flags,
_1957: x0 => x0.multiline,
_1958: x0 => x0.ignoreCase,
_1959: x0 => x0.unicode,
_1960: x0 => x0.dotAll,
_1961: (x0,x1) => x0.lastIndex = x1,
_1963: (o, p) => o[p],
_2006: x0 => x0.status,
_2007: (x0,x1) => x0.responseType = x1,
_2009: x0 => x0.response,
_2013: () => globalThis.window.flutterCanvasKit,
_2014: () => globalThis.window._flutter_skwasmInstance,
_2049: (x0,x1) => x0.withCredentials = x1,
_2051: x0 => x0.responseURL,
_2052: x0 => x0.status,
_2053: x0 => x0.statusText,
_2055: (x0,x1) => x0.responseType = x1,
_2056: x0 => x0.response,
_3872: () => globalThis.window,
_3951: x0 => x0.navigator,
_4198: x0 => x0.localStorage,
_4324: x0 => x0.userAgent,
_4543: x0 => x0.length,
_7668: () => globalThis.document,
_8120: (x0,x1) => x0.id = x1,
_8136: x0 => x0.children
    };

    const baseImports = {
        dart2wasm: dart2wasm,


        Math: Math,
        Date: Date,
        Object: Object,
        Array: Array,
        Reflect: Reflect,
    };

    const jsStringPolyfill = {
        "charCodeAt": (s, i) => s.charCodeAt(i),
        "compare": (s1, s2) => {
            if (s1 < s2) return -1;
            if (s1 > s2) return 1;
            return 0;
        },
        "concat": (s1, s2) => s1 + s2,
        "equals": (s1, s2) => s1 === s2,
        "fromCharCode": (i) => String.fromCharCode(i),
        "length": (s) => s.length,
        "substring": (s, a, b) => s.substring(a, b),
    };

    dartInstance = await WebAssembly.instantiate(await modulePromise, {
        ...baseImports,
        ...(await importObjectPromise),
        "wasm:js-string": jsStringPolyfill,
    });

    return dartInstance;
}

// Call the main function for the instantiated module
// `moduleInstance` is the instantiated dart2wasm module
// `args` are any arguments that should be passed into the main function.
export const invoke = (moduleInstance, ...args) => {
  moduleInstance.exports.$invokeMain(args);
}

