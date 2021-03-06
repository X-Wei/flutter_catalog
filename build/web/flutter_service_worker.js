'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "manifest.json": "da4afc9b2c76c857d587d6ecf2c2a02a",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"version.json": "cc17986a958a1e1b30a3c4623efc3deb",
"index.html": "24ab52a2a5dd135679133ed75a4265ab",
"/": "24ab52a2a5dd135679133ed75a4265ab",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/AssetManifest.json": "e63122112dc0a5676c694b326857c0f3",
"assets/lib/routes/widgets_stateful_widgets_ex.dart": "dfea559ee765abc64ee3f62553254ea2",
"assets/lib/routes/animation_opacity_ex.dart": "6528b29c0db2692e480d9a89a04aca5a",
"assets/lib/routes/animation_lottie_ex.dart": "1f1f7fc3ddcf47d2987338d438572231",
"assets/lib/routes/multimedia_image_plugin_ex.dart": "a4af330797631a1fb19cbc9826dc3376",
"assets/lib/routes/networking_rest_api_fetch_ex.dart": "b9692ed95449b81e202d4822e1b65927",
"assets/lib/routes/appbar_bottom_appbar_ex.dart": "9350ceb7f61f293d91dd0c015fdf671f",
"assets/lib/routes/charts_fl_line_chart_ex.dart": "5faf419b13346eb11d1b2c962b23d4a3",
"assets/lib/routes/appbar_backdrop_ex.dart": "de4e45a1b325737ef4735d5cd5a4edec",
"assets/lib/routes/widgets_text_ex.dart": "0837e66fd891ddbb4cd9e6c737d87915",
"assets/lib/routes/lists_slidable_tile_ex.dart": "f710d848811a1faaf0af5a8959156384",
"assets/lib/routes/plugins_webview_ex.dart": "cd889b9c0d87750782ff87acec013439",
"assets/lib/routes/animation_animated_builder_ex.dart": "d907679d98d3aa2edd2e542ff8f51f0e",
"assets/lib/routes/lists_listview_builder_ex.dart": "30c2d5b039589bba15f31aa8849aa7ec",
"assets/lib/routes/layouts_expanded_ex.dart": "d77d6683f7620317891eb45e4bcfe1d2",
"assets/lib/routes/networking_rest_api_send_ex.dart": "862418f8cd07438ae52e408d1fd3c13c",
"assets/lib/routes/persistence_sembast_ex.dart": "2003d46ce8fe2c5e199294bb95e75398",
"assets/lib/routes/widgets_image_filtered_ex.dart": "44987d7df9fae7707e1d846c761f61b5",
"assets/lib/routes/nav_nav_drawer_header_ex.dart": "ea37a3d824fc2437d333f0055c473452",
"assets/lib/routes/plugins_feature_discovery_ex.dart": "b41b8fca4afc4d8ad93cf033fa8b27c0",
"assets/lib/routes/state_state_notifier_freezed_ex.dart": "01dc2b97651e1b5e5037a9e956a4f8a4",
"assets/lib/routes/state_provider_ex.dart": "353edb5373690f05cedc79b34b3d2277",
"assets/lib/routes/charts_pie_chart_ex.dart": "d56559406f0e02f89de7c250b01c8d98",
"assets/lib/routes/widgets_buttons_ex.dart": "f93cab6766b51ffb1781f128e652de9d",
"assets/lib/routes/charts_graphview_ex.dart": "fbb1a474f877452541a826322fd3f48f",
"assets/lib/routes/charts_heatmap_calendar_ex.dart": "78d2b44d7dd9ecb55320d9fd1a817d21",
"assets/lib/routes/animation_low_level_ex.dart": "5ade8d4488a5dceb7ac26751810a9337",
"assets/lib/routes/data/my_api_state.dart": "69b278273439759a2adb944b7f347fc8",
"assets/lib/routes/data/todo_item.dart": "27c00d4abf503a78ce032ecf36889bf7",
"assets/lib/routes/data/my_api_state.freezed.dart": "ae1408c4db5687e27fb27288b3daced9",
"assets/lib/routes/data/todo_item.g.dart": "6d77a0996844b6297372c72ec7a334eb",
"assets/lib/routes/lists_expansion_tile_ex.dart": "708eedb65127f66177f0feba6d6f8180",
"assets/lib/routes/persistence_sqlite_ex.dart": "b72888b7216d3361483a5efee6883ebd",
"assets/lib/routes/lists_reorderable_ex.dart": "c211117c5d5abfc5b8c934bd222b62d6",
"assets/lib/routes/layouts_fractionally_sizedbox_ex.dart": "087b7f260424840b339a549c693d073e",
"assets/lib/routes/multimedia_image_picker_ex.dart": "2ee8b0efd1154cd46fe46bb46024f7bf",
"assets/lib/routes/state_bloc_lib_ex.dart": "5c56942237c0642a756b93edbdb835c0",
"assets/lib/routes/layouts_wrap_ex.dart": "3309af4b5955477d37e05c20f852f055",
"assets/lib/routes/animation_animated_container_ex.dart": "2f377c7c728dd96a5c94f2034ed2bf7d",
"assets/lib/routes/widgets_image_ex.dart": "ea119ddc2379a77af4aa360e88a837a6",
"assets/lib/routes/nav_bottom_tabbar_ex.dart": "a473ebb1b057cd9a7bded261a00d0e01",
"assets/lib/routes/appbar_basic_appbar_ex.dart": "e8400d871537aa3cde16c2b9715fa2b6",
"assets/lib/routes/state_riverpod_freezed_ex.dart": "a9c88b1ebb2276b3d5dacadd0c6148a9",
"assets/lib/routes/widgets_gradient_ex.dart": "ae6e3c7f62c1ad98bc0129b1400794fd",
"assets/lib/routes/networking_hacker_news_ex.dart": "032af0b66d3e9cb449a0e9f0c004f313",
"assets/lib/routes/persistence_preference_ex.dart": "0aed09460c1e4bf3622db108ce460bb7",
"assets/lib/routes/nav_bottom_navbar_ex.dart": "117425f15555cc7098ab533744c59fc2",
"assets/lib/routes/nav_pageselector_ex.dart": "0f85a41c47e725cb4dfde5ea04c9535b",
"assets/lib/routes/async_streambuilder_ex.dart": "b8e893e8f9e24a1db69100ca523904ea",
"assets/lib/routes/charts_fl_bar_chart_ex.dart": "1cbdebce3e9da4034789fad516909e03",
"assets/lib/routes/state_inherited_widget_ex.dart": "050ae65b150f3aa182cb0693cfe6a559",
"assets/lib/routes/async_streamcontroller_ex.dart": "a08d3c23398bb52c4e80ed7a0a87a192",
"assets/lib/routes/async_futurebuilder_ex.dart": "e61a1f04d735ef024af958c0a1ad3fb9",
"assets/lib/routes/multimedia_extended_image_ex.dart": "b97b62c1af531af1ae60ae38414b8362",
"assets/lib/routes/animation_hero_ex.dart": "0443e9ad74846ffb2cd26fe6a1f430e5",
"assets/lib/routes/nav_routes_ex.dart": "40d64b5b7159638e916758a874fc8b33",
"assets/lib/routes/multimedia_video_player_ex.dart": "f955da2f3d1fabbba8fbdeb5586f119e",
"assets/lib/routes/plugins_local_auth_ex.dart": "e9da70eedc11ca5b6fc2676f14640241",
"assets/lib/routes/animation_animated_icons_ex.dart": "9ddbe055f10727be0c94cf5752f901b6",
"assets/lib/routes/widgets_textformfield_ex.dart": "25501c03d6b028c2eb8c4e2c3aa0503b",
"assets/lib/routes/widgets_card_ex.dart": "34b82d94b1f29241663292caca342eb3",
"assets/lib/routes/layouts_row_col_ex.dart": "5d56b15649a052514a29ca5f004c448f",
"assets/lib/routes/widgets_icon_ex.dart": "ffe60315c18693af4cda9c30d3aa22bd",
"assets/lib/routes/freezed_ex_api_state.dart": "68b329da9893e34099c7d8ad5cb9c940",
"assets/lib/routes/animation_animations_pkg_ex.dart": "ba3cd34a0f9bb20436681b3e6d4f0840",
"assets/lib/routes/charts_time_series_ex.dart": "e3c4570df0b87e0feba2aae4c40d0216",
"assets/lib/routes/charts_radar_chart_ex.dart": "4088d879fcd1189056873b810b8c4522",
"assets/lib/routes/persistence_hive_ex.dart": "8cbe7fb70791b1c1515d0dc086632c11",
"assets/lib/routes/nav_tabs_ex.dart": "a6e0841919da8d404a69d169e225777d",
"assets/lib/routes/nav_dialogs_ex.dart": "411b283a141241aedcc7fbf41a7b86da",
"assets/lib/routes/persistence_file_rw_ex.dart": "7850974aa0bede210b184406736a1707",
"assets/lib/routes/lists_swipe_to_dismiss_ex.dart": "404c02d547669caa4abf832fd65a5009",
"assets/lib/routes/networking_googlebooks_ex.dart": "cd757b0263b8fd4602b06cde16509439",
"assets/lib/routes/lists_datatable_ex.dart": "6ad19cd5a208e7ceba8b4b0f4946380d",
"assets/lib/routes/about.dart": "2d9fdfad238389d6f3a4fad6ae88d5f1",
"assets/lib/routes/state_scoped_model_ex.dart": "c3abd0494b29e4d588a150b116fc6b9f",
"assets/lib/routes/appbar_search_ex.dart": "283a73625d46e3bd158f90f1bad0060e",
"assets/lib/routes/plugins_markdown_ex.dart": "512c8a8fcc4a473ad7c61339fbb7b8f7",
"assets/lib/routes/lists_list_tile_ex.dart": "b6a0b6d8612fcc982c1403094d7ec1bc",
"assets/lib/routes/layouts_container_padding_center_ex.dart": "e0df341b4d2918bdc3e3353df7b6b05e",
"assets/lib/routes/charts_fl_pie_chart_ex.dart": "a7e1dbaaa5cfdf140d12f6fb25f14404",
"assets/lib/routes/appbar_sliver_appbar_ex.dart": "5833fdb96c1ac6e6bbc088739fdd2a6a",
"assets/lib/routes/widgets_dropdown_button_ex.dart": "9c44bad8ba26ca88da01cd95f4063447",
"assets/lib/routes/lists_grid_list_ex.dart": "b926adef585f099167ba8dd4f7291f7c",
"assets/lib/routes/firebase_vote_ex.dart": "ce39b522e0edf2d85ba87546e6c76511",
"assets/lib/routes/widgets_textfield_ex.dart": "0ac8613bc964b3cf00df3ebfe08faaaa",
"assets/lib/routes/state_bloc_ex.dart": "b986dfc5f734ad1c49ee8f972bc5ee9f",
"assets/lib/routes/firebase_mlkit_ex.dart": "0f44b29e4a201d1dcfe7181ee13c9e16",
"assets/lib/routes/nav_bottom_sheet_ex.dart": "77ff0086d91476367abde0d0cd2b6140",
"assets/lib/routes/layouts_stack_ex.dart": "0f3cacc258dc8cb476755604d05d5400",
"assets/lib/routes/plugins_shimmer_ex.dart": "50b0075d576dac210932052368b050b8",
"assets/lib/routes/appbar_convex_appbar_ex.dart": "e6b5c4519aa20451cc0cdaa94c021f04",
"assets/lib/routes/firebase_login_ex.dart": "995ced69581d7877aa3fb45abc6a3191",
"assets/lib/routes/nav_draggable_scrollable_sheet_ex.dart": "6a67944f6b321822565b6124f9f90c4f",
"assets/lib/routes/firebase_chatroom_ex.dart": "e6d539290b36fef40cc76e425ccf017e",
"assets/lib/routes/multimedia_edge_detection_ex.dart": "24d05c8dcde8f0cb0401456b9441cce6",
"assets/lib/routes/animation_animated_widget_ex.dart": "103ac5b6d95f9389c35b847a223807f1",
"assets/NOTICES": "692720357263c3e97180f8eafec22656",
"assets/res/lottie/thumbs-up.json": "4b4cb2af6893316e53405eae64157cce",
"assets/res/lottie/world.json": "8140dee112e141cd5c53c04e5727cb58",
"assets/res/images/splash_screen.png": "d8251ff671208c7c426f1fafe86a60ee",
"assets/res/images/animated_flutter_lgtm.gif": "b652a58dd464c07a80516f7a8f99ddf1",
"assets/res/images/dart-side.png": "6162e4c6ba269007cd5f2ae8d78e69af",
"assets/res/images/launcher_icon.png": "d8697155bb89d87d8f5ce939cd3c0c6e",
"assets/res/images/material_design_3.png": "c4c9411cb6b23dc218688d48f6bf514c",
"assets/res/images/material_design_4.jpg": "43e36ec401db9d8a6c44bb3d327b99b3",
"assets/packages/fluttertoast/assets/toastify.css": "8beb4c67569fb90146861e66d94163d7",
"assets/packages/fluttertoast/assets/toastify.js": "8f5ac78dd0b9b5c9959ea1ade77f68ae",
"assets/packages/flutter_gallery_assets/animated_images/animated_flutter_stickers.webp": "b44800b701a3d0bb1285726003b1ae5c",
"assets/packages/flutter_markdown/assets/logo.png": "67642a0b80f3d50277c44cde8f450e50",
"main.dart.js": "7c36972f0ca553a81530337e6a5e11eb",
"favicon.png": "5dcef449791fa27946b3d35ad8803796"
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
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
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
