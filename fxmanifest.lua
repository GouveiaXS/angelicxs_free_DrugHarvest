fx_version 'cerulean'
game 'gta5'

author 'AngelicXS'
version '1.3.1'
lua54 'yes'
client_script 'client.lua'

server_script {
	'server.lua',
    '@mysql-async/lib/MySQL.lua'
}

shared_script {'config.lua', '@ox_lib/init.lua'}
