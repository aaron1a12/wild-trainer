--resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

--resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9' original NativeUI rs



client_scripts {
	'@NativeUI/NativeUI.lua',
	'entityiter.lua',
	'random.lua',
	'global.lua',
	'merryweather.lua',
	'clothes_shop.lua',
	'car_shop.lua',
	'aircraft_shop.lua',
	'hunger.lua',
	'carry.lua',
	'carcrash.lua',
	'law.lua',
	'actionkeys.lua',
	'job_cop.lua',
	'job_drugdealer.lua',
	'chat.lua',
	'point.lua',
	'respawning.lua',
	--'hitchhiker.lua',
	'phone.lua',
	'cl_nuke_mission.lua',
	'client.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua',
	'sv_nuke_mission.lua'
}

dependencies {
	'es_extended',
	'mysql-async'
}

ui_page('html/index.html')

--[[The following is for the files which are need for your UI (like, pictures, the HTML file, css and so on) ]]--
files {
    'html/index.html',
	
	'html/css/style.css',

	'html/js/howler.min.js',
	'html/js/howler.spatial.min.js',
	'html/js/jquery.easing.compatibility.js',
	'html/js/jquery.easing.js',
	'html/js/android.js',
	
	'html/apps/app.camera.js',
	'html/apps/app.cars.js',
	'html/apps/app.mors.mutual.js',
	'html/apps/app.phone.js',
	'html/apps/app.weazel.news.js',
	'html/apps/app.contacts.js',
	
	'html/js/nuke.js',
	
	
	'html/img/desktop.png',
	'html/img/app-camera.png',
	'html/img/app-car.png',
	'html/img/app-mors-mutual.png',
	'html/img/app-phone.png',
	'html/img/app-contacts.png',
	'html/img/app-police.png',
	'html/img/icon-notify-generic.png',
	'html/img/icon-notify-car.png',
	'html/img/icon-notify-mors-mutual.png',
	'html/img/icon-notify-message.png',
	'html/img/app-weazel-news.jpg',
	'html/img/banner-pdm.png',
	
	'html/sounds/notify.ogg',
	'html/sounds/phone_slide.wav',
	'html/sounds/press_up.wav',
	'html/sounds/civil_defense_siren.ogg',
	'html/sounds/eas_missile_message.ogg',
	'html/sounds/blackout.mp3',
	'html/sounds/ambience.ogg',
	'html/sounds/scanner.ogg',

}