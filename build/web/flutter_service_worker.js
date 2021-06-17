'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "manifest.json": "668b0f2696548ea3836970d41a156473",
"version.json": "4db193d804ef1734e976fc98599a3019",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/mstile-310x310.png": "a306ba2590bc9416f2994fa3d3928346",
"icons/mstile-70x70.png": "7affecfe636abc51f1ab4880105af84f",
"icons/favicon-32x32.png": "bb2bc2973054677dd7517b451472f61d",
"icons/mstile-310x150.png": "f65bf81d69cb87eecf2b2715409c13a7",
"icons/android-chrome-192x192.png": "337b33cb8db9a55f13ff8f2ffcd32f4c",
"icons/mstile-150x150.png": "a807225bb4ec10085ae178623eb8ffe5",
"icons/favicon-16x16.png": "ac89e4f5b2f5601b717112572ad70095",
"icons/safari-pinned-tab.svg": "359f11f235f75a085132d10d48d554ee",
"icons/favicon.ico": "c4df1a1c17ede31af4d9460df0bc9b85",
"icons/mstile-144x144.png": "ba08a329357d5f257708b09641a79ede",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/browserconfig.xml": "4abe9cbe28454981119718ed3e32ea38",
"icons/apple-touch-icon.png": "fbcebe0b3dad06a1bd415b6536a216c4",
"icons/android-chrome-512x512.png": "56780053c6baab77102ba8195c2077c6",
"icons/site.webmanifest": "35f3698d1ef7a7459be6ec9005be6466",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"main.dart.js": "fbaff199874f6bae4de81d6439f50615",
"assets/NOTICES": "43e550197dc776748876e5197465fd42",
"assets/AssetManifest.json": "280155ecedc0d4684357662725e9d46e",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/assets/images/auth/default.png": "2e4e1e7bda88522ba08a904a202b3c78",
"assets/assets/images/affiliate/hostwinds-hostadvice.jpg": "2d99cda53de940958fc4e541e6303405",
"assets/assets/images/social/facebook_logo.png": "f70966569e1108f7dcf81eaa258f66a7",
"assets/assets/images/social/github_logo.png": "fd29f1ea5b6c1a2696629eb6135b5396",
"assets/assets/images/social/google_logo.png": "b600c85a2bf1594170b0514e613031c7",
"assets/assets/images/social/twitter_logo.png": "7d834333d68ad947b9912869ebd53e20",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"index.html": "b0e017280475e7627131de97a30c0f81",
"/": "b0e017280475e7627131de97a30c0f81"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
