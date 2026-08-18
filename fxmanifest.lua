fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'DetectivDEV'
description 'A modern City Hall UI for QBCore & Qbox'
version '1.0.0'
contribution 'SWGAURKO'



shared_scripts {   
    'shared.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}


ui_page 'html/index.html'

files {
    'html/index.html',
    'html/css/*.css',
    'html/js/*.js',
    'html/fonts/*'
}
