fx_version 'bodacious'
games { 'gta5' }

description 'ESX Reporter Job'

version '2.0.0'

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  '@es_extended/locale.lua',
  'config.lua',
  'server/main.lua',
  'locales/fr.lua',
  'locales/en.lua'
}

client_scripts {
  '@es_extended/locale.lua',
  'config.lua',
  'client/main.lua',
  'client/vehicle.lua',
  'locales/fr.lua',
  'locales/en.lua'
}

dependencies {
	'es_extended',
	'esx_billing',
	'esx_vehicleshop'
}
