package main

import (
	"github.com/go-flutter-desktop/go-flutter"
	"github.com/go-flutter-desktop/plugins/image_picker"
	"github.com/go-flutter-desktop/plugins/path_provider"
	"github.com/go-flutter-desktop/plugins/shared_preferences"
	"github.com/go-flutter-desktop/plugins/url_launcher"
)

const (
	kOrganization = "x_wei.github.io"
	kAppname = "flutter_catalog"
)

var options = []flutter.Option{
	flutter.WindowInitialDimensions(800, 1280),
	flutter.AddPlugin(&image_picker.ImagePickerPlugin{}),
	flutter.AddPlugin(&path_provider.PathProviderPlugin{
		VendorName:      kOrganization,
		ApplicationName: kAppname,
	}),
	flutter.AddPlugin(&shared_preferences.SharedPreferencesPlugin{
		VendorName:      kOrganization,
		ApplicationName: kAppname,
	}),
	flutter.AddPlugin(&url_launcher.UrlLauncherPlugin{}),
}