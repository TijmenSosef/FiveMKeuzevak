fx_version 'cerulean'
game 'gta5'

description 'Mijn eerste resource'
version '0.0.1'

studentinfo {
	'Rik Remijn - 1056047 - INF1D'
}

lua54 'yes'

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}