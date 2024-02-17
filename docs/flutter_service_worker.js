'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "c754e564b59f250b98a1024e16d23856",
"assets/AssetManifest.bin.json": "bc177f2bc5935c1d890bc40ce516d716",
"assets/AssetManifest.json": "65e8da6831d05e2beddd99c1d17f559e",
"assets/FontManifest.json": "f3c04447ffdb238625d63ad3e69d6722",
"assets/fonts/MaterialIcons-Regular.otf": "3f3d7aa429d878b5b40c50e925ee471b",
"assets/NOTICES": "9909f3e1d94c74598ea5968111679c6e",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/shadcn_flutter/fonts/Geist-Black.otf": "cf003c4f85b590cf60bec1e111ebaaf5",
"assets/packages/shadcn_flutter/fonts/Geist-Bold.otf": "d3e1d3dc690224fd330969af598a9c31",
"assets/packages/shadcn_flutter/fonts/Geist-Light.otf": "21f434e8c2b53240a0c459b9d119f22f",
"assets/packages/shadcn_flutter/fonts/Geist-Medium.otf": "f7ceaf00b58d396cf93ff1ea43740027",
"assets/packages/shadcn_flutter/fonts/Geist-SemiBold.otf": "2c0b1d3e7b1c71bedc2eecf78f7a1d1d",
"assets/packages/shadcn_flutter/fonts/Geist-Thin.otf": "8603d0fe0def4273ebeee670eedcfb86",
"assets/packages/shadcn_flutter/fonts/Geist-UltraBlack.otf": "f3591a030925294b2bb427e6a6c9b0d8",
"assets/packages/shadcn_flutter/fonts/Geist-UltraLight.otf": "b64b37fbec0a925067cbf530e4962fec",
"assets/packages/shadcn_flutter/fonts/GeistMono-Black.otf": "d1181fda08ff34e6d3e09008ecdf929e",
"assets/packages/shadcn_flutter/fonts/GeistMono-Bold.otf": "17cd9f83ad9f9b041cce5e1efcacb45f",
"assets/packages/shadcn_flutter/fonts/GeistMono-Light.otf": "38fed41f0d6b4e5028ef9de5e77bd07d",
"assets/packages/shadcn_flutter/fonts/GeistMono-Medium.otf": "178f91b57aa7d648a4c5d4b9b8d5897d",
"assets/packages/shadcn_flutter/fonts/GeistMono-Regular.otf": "59733adbd2346f6cb2337b72dcdce81d",
"assets/packages/shadcn_flutter/fonts/GeistMono-SemiBold.otf": "302d4e3e240eb25c5a1585d1d93aadac",
"assets/packages/shadcn_flutter/fonts/GeistMono-Thin.otf": "8a1ce1ae134a24a960ff022b9300f14d",
"assets/packages/shadcn_flutter/fonts/GeistMono-UltraBlack.otf": "de3105300e7a2a86ea55584895fdac8b",
"assets/packages/shadcn_flutter/fonts/GeistMono-UltraLight.otf": "2da5af8ecc9112e6b9ade9399e624f56",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "59a12ab9d00ae8f8096fffc417b6e84f",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "c722bcd3ac1cd841a0ac3f804f39af1c",
"/": "c722bcd3ac1cd841a0ac3f804f39af1c",
"main.dart.js": "19b3bbe239c60ed4c4780051fcc301bf",
"manifest.json": "9a0de1ff26661cd281cb9deb3db33b02",
"version.json": "ff966ab969ba381b900e61629bfb9789"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
