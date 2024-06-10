'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"icons/Icon-maskable-192.png": "fb44471e53d4eda157d6f90db42f58c5",
"icons/Icon-maskable-512.png": "893a4f1d2be5de1cb9ffddb0339328c8",
"icons/Icon-512.png": "893a4f1d2be5de1cb9ffddb0339328c8",
"icons/Icon-192.png": "fb44471e53d4eda157d6f90db42f58c5",
"manifest.json": "cbd8ec414e442de2674854fc81e33f2b",
"favicon.png": "73c0d51c7fc94e1933e48f3a3511f72b",
"flutter_bootstrap.js": "77e94819c9019ca609cbdbe786ed471c",
"version.json": "e3aff1434f3f61cf8817cecf1f900407",
"index.html": "898f6f9fd10aefaf9874f00f5049bc96",
"/": "898f6f9fd10aefaf9874f00f5049bc96",
"main.dart.js": "afc9c3fec4edbb1fafa5507ac6b47efb",
"assets/screenshots/Screenshot_1541613197.png": "41f2d862740c754b3cbf80db2cd5c0e6",
"assets/screenshots/Screenshot_1541613187.png": "2392e4b38a6ee62b708b403f9bf1a552",
"assets/screenshots/Screenshot_1541613193.png": "cac7f003bad5e8b1492ea5b599ad67fb",
"assets/lib/routes/networking_rest_api_fetch_ex.dart": "9eec46779a4a9809285d3f0bc59b59e1",
"assets/lib/routes/data/my_api_state.dart": "69b278273439759a2adb944b7f347fc8",
"assets/lib/routes/data/todo_item.g.dart": "2e0ec4ca894f5e722825549fef2a7bc6",
"assets/lib/routes/data/todo_item.dart": "f1c28cf2acbf0c17a610b90fb6f3c736",
"assets/lib/routes/data/my_api_state.freezed.dart": "cc3ca1efd5ee6c44b03cc820d42cffe3",
"assets/lib/routes/data/myapistate.g.dart": "f2933897d851cc8e7128d1fb475dff1c",
"assets/lib/routes/data/myapistate.freezed.dart": "b77528f6abc9d012540c64cfc7e4b0ef",
"assets/lib/routes/data/myapistate.dart": "24cf7bf26abc88b62301b2236bb14168",
"assets/lib/routes/firebase_vote_ex.dart": "a9b5040f9187f7fff14ae40fb1c00ad0",
"assets/lib/routes/multimedia_image_plugin_ex.dart": "8d0add1a82e5e8b09615051a076bea29",
"assets/lib/routes/onboarding_intro_screen_ex.dart": "913ab8623265cfd587035c37a7445f15",
"assets/lib/routes/multimedia_image_picker_ex.dart": "53c1bed827bb0f2f00c8f8b9cec5fcf1",
"assets/lib/routes/persistence_preference_ex.dart": "e92b979a9814ea9db47f26205d56b6f1",
"assets/lib/routes/charts_heatmap_calendar_ex.dart": "873f3f52a561bc5a5169cefe5e7a873f",
"assets/lib/routes/charts_radar_chart_ex.dart": "5b92942d000b5144c2733dfd213fc603",
"assets/lib/routes/monetization_bottom_banner_ad_ex.dart": "4eb884166049b86ecd5b51da18eed336",
"assets/lib/routes/appbar_sliver_appbar_ex.dart": "bec416c7f42fcf403b9d686ce583defe",
"assets/lib/routes/networking_hacker_news_ex.dart": "08e6b3f6e7e92cad62a080d70950053b",
"assets/lib/routes/nav_routes_ex.dart": "5bac56eb1641751fabe178e9a52b8cb1",
"assets/lib/routes/charts_new_heatmap_calendar_ex.dart": "354b6d7ad4acdac75e571d06e566a82d",
"assets/lib/routes/appbar_hidable_ex.dart": "e3a5d1101e281d6aa23e5339ff60cbc1",
"assets/lib/routes/widgets_typography_ex.dart": "8e2ad04b1038500d72a9feab64f4c64a",
"assets/lib/routes/charts_graphview_ex.dart": "fd59da90a1b00cee4bc2df5bd444f968",
"assets/lib/routes/widgets_text_ex.dart": "c652f5c7cf6b1c13fe184196fd529225",
"assets/lib/routes/nav_bottom_navbar_ex.dart": "79ecdd6a015dd395b7adf8aa7f25d2f4",
"assets/lib/routes/widgets_like_button_ex.dart": "702fa4054d70d6d516ff959382883355",
"assets/lib/routes/growth_my_other_apps.dart": "2781ce6ceee28b1580703df7ea300cfa",
"assets/lib/routes/animation_animated_text_kit_ex.dart": "30bc7ecdb905458b12d7ca6d0e223c92",
"assets/lib/routes/appbar_backdrop_ex.dart": "a1912b820bd7d9ba70a0eb990f82f8fe",
"assets/lib/routes/nav_tabs_ex.dart": "345374f9f3dbe93e5fd5fe9063241bfa",
"assets/lib/routes/lists_datatable_ex.dart": "0606ec0a801ee4b9f2cc41740f297124",
"assets/lib/routes/plugins_shimmer_ex.dart": "e54e0148b53e5936abe3d0c287039604",
"assets/lib/routes/charts_pie_chart_ex.dart": "d567deb4a6d3e1ed07d0d2a6a2281d5f",
"assets/lib/routes/multimedia_edge_detection_ex.dart": "f442d99e69bfd72d15090c495b2577ac",
"assets/lib/routes/richtext_selectable_ex.dart": "2887cc1857a75a638383f0b2a136b4b2",
"assets/lib/routes/feature_grey_app.dart": "40854066abb782458cc328fa10f93b36",
"assets/lib/routes/appbar_bottom_appbar_ex.dart": "885c172f17024d2e5ffb6b71a741b296",
"assets/lib/routes/animation_animated_radial_menu_ex.dart": "77652bbfd6cd87fc5916195328a89603",
"assets/lib/routes/animation_animated_widget_ex.dart": "30b900dfb9e274ddfc351c19c4128055",
"assets/lib/routes/nav_bottom_sheet_ex.dart": "337556932bc60119dfdec39ebff99100",
"assets/lib/routes/monetization_in_app_purchase_ex.dart": "07d7a20ed28682baa7c6a7902a09a195",
"assets/lib/routes/persistence_hive_ex.dart": "a749e99b170577949e26f491f6251474",
"assets/lib/routes/widgets_textfield_ex.dart": "b1254ff8bc7456b5e6927966690e1521",
"assets/lib/routes/multimedia_video_player_ex.dart": "5f1535b127d5fa3c92c71fce38bf0c2b",
"assets/lib/routes/async_streamcontroller_ex.dart": "e530b8aa42e1e43715bae5109c3efe3d",
"assets/lib/routes/async_futurebuilder_ex.dart": "ffeffcf62b8498c7e758bac21516d4e4",
"assets/lib/routes/richtext_supereditor_ex.dart": "da8328cadee59ffcc62095687e1790e4",
"assets/lib/routes/state_scoped_model_ex.dart": "9b35dd0eea4ac482082c64f7915889df",
"assets/lib/routes/animation_animated_builder_ex.dart": "1e8557bd9ae8ceed99a1ca60c5167a09",
"assets/lib/routes/widgets_stateful_widgets_ex.dart": "6f923516d97486036e72955b22d8b0e3",
"assets/lib/routes/widgets_card_ex.dart": "7b064e31a032e9259781015b0d09c7d6",
"assets/lib/routes/lists_wheel_scroll_view_ex.dart": "941751d4afcbaf98b859684c59f95813",
"assets/lib/routes/multimedia_extended_image_ex.dart": "a26ce87e307cf06d340e3f539d4fddc3",
"assets/lib/routes/state_state_notifier_freezed_ex.dart": "52713a2ce59b44b51081ddc0770e22c3",
"assets/lib/routes/growth_inapp_review_ex.dart": "bc26b12858c86359a03be8a0d0945862",
"assets/lib/routes/state_inherited_widget_ex.dart": "b3595d3e7869b261773794143068731a",
"assets/lib/routes/nav_pageselector_ex.dart": "941ee284d4aff61b7817b5e9b36e2ba6",
"assets/lib/routes/plugins_share_plus_ex.dart": "0505b749d06116a3853570a98381c022",
"assets/lib/routes/monetization_user_purchases_ex.dart": "c5b399504cfa58ecc08db0fb1b5f6728",
"assets/lib/routes/layouts_expanded_ex.dart": "2c5cc1152fac4bace459b51768cc02cf",
"assets/lib/routes/appbar_search_ex.dart": "acf97ec1fc28e290480e4694e1d3cfb0",
"assets/lib/routes/nav_nav_drawer_header_ex.dart": "88aa9a4981c4394c75866767b372ba5d",
"assets/lib/routes/nav_dialogs_ex.dart": "7422c446d6e4f35174f73a2696cc8a98",
"assets/lib/routes/persistence_sembast_ex.dart": "b49206bb6dcb120e87a3c7496ad36339",
"assets/lib/routes/about.dart": "34112af97a483f1cadd11372b503c638",
"assets/lib/routes/lists_list_tile_ex.dart": "ed78a42f0d4b72fbe1a3f6dd20cb8703",
"assets/lib/routes/richtext_markdown_ex.dart": "05638f4d21f6b76b887dfabdbc7891ef",
"assets/lib/routes/networking_dio_download_ex.dart": "6bf8f0b3092348c1ba71d4c1db16750d",
"assets/lib/routes/charts_fl_bar_chart_ex.dart": "fa2a198f3ef414253225bf5423095bd8",
"assets/lib/routes/monetization_adaptive_banner_ad_ex.dart": "702346ab4de1d4e6fc2c8cdba90d442a",
"assets/lib/routes/widgets_icon_ex.dart": "67696c9a75bc23d58e49841c87de9e7f",
"assets/lib/routes/onboarding_whats_new_ex.dart": "ffe1e3300227e3d38f723f601d0b8270",
"assets/lib/routes/firebase_chatroom_ex.dart": "6f0d3c419457d336ca2365b96c454648",
"assets/lib/routes/widgets_dropdown_button_ex.dart": "b7c1c2e8b217f6902aaf26f161432635",
"assets/lib/routes/freezed_ex_api_state.dart": "68b329da9893e34099c7d8ad5cb9c940",
"assets/lib/routes/state_bloc_ex.dart": "3496e087c2ecaf784415515f37800bcd",
"assets/lib/routes/firebase_mlkit_ex.dart": "fcbc7c5a7dfcca413b67c8e075ed5519",
"assets/lib/routes/lists_expansion_tile_ex.dart": "6c7fb4ef23322b80830912e31f796000",
"assets/lib/routes/onboarding_feature_discovery_ex.dart": "05a0f95f8ad1f80202395fec580bdd0d",
"assets/lib/routes/lists_reorderable_ex.dart": "fcad3144db522c6e6c2835ad84895135",
"assets/lib/routes/charts_fl_line_chart_ex.dart": "28a46495d36ea772c1a4fce6816c9982",
"assets/lib/routes/monetization_inline_banner_ad_ex.dart": "031af74aaabb49559509c9329ac0f002",
"assets/lib/routes/lists_listview_builder_ex.dart": "0b0809c9bdd9765dd4871dc24a512e29",
"assets/lib/routes/lists_grid_list_ex.dart": "f2aab73c8c6a825eff64654f29c8287e",
"assets/lib/routes/networking_googlebooks_ex.dart": "639f874eea430e76fa2707130e1dd49f",
"assets/lib/routes/charts_fl_pie_chart_ex.dart": "b9068a304d8043d738d39592140251fe",
"assets/lib/routes/nav_bottom_tabbar_ex.dart": "8c1ce0e598ce4289ce327f2e8d267ee7",
"assets/lib/routes/monetization_interstitial_ad_ex.dart": "23ed08c499cf5698f6ea9abff325ef3a",
"assets/lib/routes/animation_hero_ex.dart": "d88bc2518d739e4ee251b3adb9be6b56",
"assets/lib/routes/appbar_convex_appbar_ex.dart": "a069610e49c05d1273072ed577aeca99",
"assets/lib/routes/plugins_local_auth_ex.dart": "d94c343857e49ad0dc2aff31b73c1f77",
"assets/lib/routes/feature_device_preview.dart": "2fbee4a343da11a29f5cee12bdb7e25d",
"assets/lib/routes/aiml_chatgpt_ex.dart": "8ea1c51c00f46cd50d48c4ddcbca4fe8",
"assets/lib/routes/layouts_container_padding_center_ex.dart": "6123a75fe62d27c69c1d8d783080abd7",
"assets/lib/routes/monetization_rewarded_ad_ex.dart": "605ba77890c820a1899ee1195bb234ac",
"assets/lib/routes/widgets_buttons_ex.dart": "9b9fb1f52b0f9c2036318809320fcee7",
"assets/lib/routes/plugins_webview_ex.dart": "814918af704a2dd2274753986c66ecba",
"assets/lib/routes/layouts_wrap_ex.dart": "0eab91194bd97e5b1794438d901466fa",
"assets/lib/routes/persistence_sqlite_ex.dart": "d5384b364ab24f5efa0bc77db1c9ed33",
"assets/lib/routes/animation_animated_icons_ex.dart": "a94bc30e1be5bc367bf062044f8567c2",
"assets/lib/routes/growth_device_preview_ex.dart": "a3a3591685a8f29751383bb5a4f49af1",
"assets/lib/routes/animation_low_level_ex.dart": "91e056d4b7ec446621816d20d5ff051d",
"assets/lib/routes/widgets_image_ex.dart": "6b0938c60c1c8833c004032b7ec83dd7",
"assets/lib/routes/firebase_flutterfire_loginui_ex.dart": "6d0ae8c393053a9c790cfd9673507d1c",
"assets/lib/routes/persistence_file_rw_ex.dart": "4c503be8b891d59e2c308153431d726e",
"assets/lib/routes/state_provider_ex.dart": "02f69e577f07555c271020602da3e9f4",
"assets/lib/routes/lists_swipe_to_dismiss_ex.dart": "e39814e47877f3e278f4a6ec5adbb3fe",
"assets/lib/routes/appbar_basic_appbar_ex.dart": "77ef20948eeba50fac45906d0f59b549",
"assets/lib/routes/state_bloc_lib_ex.dart": "bc4fd47fa55f8ab9b6dd4de385cd8ba9",
"assets/lib/routes/async_streambuilder_ex.dart": "12d3576b484129dbd5d7b2ab0c276d18",
"assets/lib/routes/widgets_image_filtered_ex.dart": "513f6ca4ec3bb0a986ac1b6507f6d05f",
"assets/lib/routes/richtext_code_highlight_ex.dart": "564da6555626a3f0c2c08e22183e8ed3",
"assets/lib/routes/layouts_row_col_ex.dart": "5dc5365526dddf3a08d93ed79ce3bead",
"assets/lib/routes/charts_time_series_ex.dart": "871a3dba1a3c0e3adcffff16c773f74d",
"assets/lib/routes/animation_opacity_ex.dart": "541d2aad5b6d715eda2ced0e1e0d5705",
"assets/lib/routes/state_riverpod_freezed_ex.dart": "69c83b18870874abff806f6f5d7eaa7a",
"assets/lib/routes/animation_animations_pkg_ex.dart": "bf7ae95bbd4e27a5109c1620bff7b452",
"assets/lib/routes/networking_rest_api_send_ex.dart": "92763709296c737e9b1685e985ab735b",
"assets/lib/routes/widgets_textformfield_ex.dart": "4ae7fe062f2792820ff2c2f2bdd677b9",
"assets/lib/routes/animation_lottie_ex.dart": "4f151183b275999b2542ab1e60e1e56a",
"assets/lib/routes/firebase_login_ex.dart": "f776c2ef75a676dddc057b55ce97d3d3",
"assets/lib/routes/richtext_quill_ex.dart": "9c71e2d66383bde5aaf250ce144e792f",
"assets/lib/routes/animation_animated_container_ex.dart": "8923ac5b848f638167400e07c746f123",
"assets/lib/routes/nav_draggable_scrollable_sheet_ex.dart": "05197130b767b3213e37c703c066906f",
"assets/lib/routes/lists_slidable_tile_ex.dart": "181a44ef2fcc88bbc2934ae437944bc5",
"assets/lib/routes/multimedia_youtube_player_ex.dart": "c6cee14181af0a15362aee833eea8c03",
"assets/lib/routes/layouts_stack_ex.dart": "d1d6b2c202bad066c9b1958a47f2d4cd",
"assets/lib/routes/charts_timelines_ex.dart": "074578365cb50a203fe7d8dd5376cb1e",
"assets/lib/routes/aiml_groq_ex.dart": "751dd99c34904ea2337c7d37ddff7464",
"assets/lib/routes/layouts_fractionally_sizedbox_ex.dart": "46897861e8763597ffd5e025ebd5a09f",
"assets/lib/routes/widgets_gradient_ex.dart": "6ddefb311cb981610b5abf98e59cf7a4",
"assets/lib/routes/feature_store_secrets.dart": "bc6210e580461f80b8808a854499fd61",
"assets/AssetManifest.json": "722dc5808e18309d960a671fe1702fd6",
"assets/CHANGELOG.md": "1773aa980f157ef5f53cbf68b63582ab",
"assets/packages/community_material_icon/fonts/materialdesignicons-webfont.ttf": "84c7bd136590da0a6ed2c21df180c354",
"assets/packages/flutter_gallery_assets/animated_images/animated_flutter_stickers.webp": "b44800b701a3d0bb1285726003b1ae5c",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "2f141ffd94f3ef0ed716615fd537e708",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "c6ac80bdc5b2896345377c9439f91d54",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "0ebc4e7ca5e040da671730a59b181135",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/youtube_player_iframe/assets/player.html": "ea69af402f26127fa4991b611d4f2596",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "ea5e6fe91d2f0e53f4e853b04d9e4d35",
"assets/fonts/MaterialIcons-Regular.otf": "5e78c38b8ca0b6b517da33d9f68dcdb8",
"assets/NOTICES": "967dbfa25f1c809399669d46b418d548",
"assets/AssetManifest.bin": "d3b7d67e61b19efdbab4e1aece32c08a",
"assets/FontManifest.json": "3b70b61ab32057db7d0ed40a99d19cd2",
"assets/res/images/xymemo-icon.png": "87331e327893f1af76230d8690194d1f",
"assets/res/images/app_icon.png": "59b66f9c414a3f030a2d3ce52e5a06a7",
"assets/res/images/material_design_4.jpg": "43e36ec401db9d8a6c44bb3d327b99b3",
"assets/res/images/xydocs-cpp-icon.png": "1aea6610a130a59825baacfe4c3673cb",
"assets/res/images/xydocs-flutter-icon.png": "4eae01348824761ce9ac74e2850af3d7",
"assets/res/images/elder.jpeg": "8029d3d82174a4bde1d6c3ba61fb9485",
"assets/res/images/dart-side.png": "6162e4c6ba269007cd5f2ae8d78e69af",
"assets/res/images/animated_flutter_lgtm.gif": "b652a58dd464c07a80516f7a8f99ddf1",
"assets/res/images/material_design_3.png": "c4c9411cb6b23dc218688d48f6bf514c",
"assets/res/lottie/thumbs-up.json": "4b4cb2af6893316e53405eae64157cce",
"assets/res/lottie/world.json": "8140dee112e141cd5c53c04e5727cb58",
"splash/img/light-2x.png": "58001dbc574fb60c48621116e03fbe81",
"splash/img/light-1x.png": "feee8002d542ba0a1ebe3caaa4a72867",
"splash/img/dark-2x.png": "58001dbc574fb60c48621116e03fbe81",
"splash/img/dark-1x.png": "feee8002d542ba0a1ebe3caaa4a72867",
"splash/img/dark-4x.png": "893a4f1d2be5de1cb9ffddb0339328c8",
"splash/img/light-4x.png": "893a4f1d2be5de1cb9ffddb0339328c8",
"splash/img/dark-3x.png": "d6e8aa103a41525c988236660525e5ad",
"splash/img/light-3x.png": "d6e8aa103a41525c988236660525e5ad",
"splash/style.css": "c760b1d5a84f4595c09d1dc4672bbe04",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
