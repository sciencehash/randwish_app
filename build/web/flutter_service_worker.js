'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "manifest.json": "668b0f2696548ea3836970d41a156473",
"version.json": "4db193d804ef1734e976fc98599a3019",
"icons/mstile-310x310.png": "8465abbbb7c980911f82be9095551cd4",
"icons/mstile-70x70.png": "8725c45c0566c7214e82a16a9ed5f917",
"icons/favicon-32x32.png": "a164f62911df4f6235cbb3a2a05135f2",
"icons/mstile-310x150.png": "8d0f8dbba44466bafbd59e746912280a",
"icons/android-chrome-192x192.png": "abfe546b00701f2ea39e635411577b8f",
"icons/mstile-150x150.png": "acee287c988c0d5142eb371580ea7867",
"icons/favicon-16x16.png": "787d9e814ed9460b521927b80f7117f1",
"icons/safari-pinned-tab.svg": "c2910c9616bfa70c8c36467c964edc9f",
"icons/favicon.ico": "9aee6103b596fa42278fed4d3a8eefd4",
"icons/mstile-144x144.png": "14b36035875c3c9547defc9010c898e5",
"icons/browserconfig.xml": "6b301dea6bc32ee8bfd65364615f84bd",
"icons/apple-touch-icon.png": "c461faf6ee5f907b19142ada02a047e2",
"icons/android-chrome-512x512.png": "caa509925cd82fe2abef6b60079b7289",
"icons/site.webmanifest": "b029b36da21458319debcfb2786f2886",
"main.dart.js": "2cc4b1044bc551070cfd898289948ce8",
"assets/NOTICES": "9acd778aae7765a996c1fec9676cba54",
"assets/AssetManifest.json": "d0efe8e25a9bd01ef2525d998fe4c3fa",
"assets/assets/images/auth/default.png": "2e4e1e7bda88522ba08a904a202b3c78",
"assets/assets/images/affiliate/hostwinds-hostadvice.jpg": "2d99cda53de940958fc4e541e6303405",
"assets/assets/images/social/facebook_logo.png": "f70966569e1108f7dcf81eaa258f66a7",
"assets/assets/images/social/github_logo.png": "fd29f1ea5b6c1a2696629eb6135b5396",
"assets/assets/images/social/google_logo.png": "b600c85a2bf1594170b0514e613031c7",
"assets/assets/images/social/twitter_logo.png": "7d834333d68ad947b9912869ebd53e20",
"assets/assets/fonts/icons/app-icons.ttf": "07dd92f122420fcb23cb1c4d308b75a2",
"assets/FontManifest.json": "b3b04f85dd67b9229f0c0ea12a22127a",
"index.html": "ebb3d5c52616a9e3820ce7bacbcc2074",
"/": "ebb3d5c52616a9e3820ce7bacbcc2074"
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
