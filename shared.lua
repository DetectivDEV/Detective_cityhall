Config = {}
Lang = {
    ['hired']            = 'You have been hired as a %s!',
    ['not_enough_money'] = 'You do not have enough money for that!',
    ['bought']           = 'You purchased a %s!',
    ['already_job']      = 'You already work as a %s!',
    ['invalid_request']  = 'Invalid request.',
    ['no_player']        = 'Something went wrong, try again.',
}

Config.TargetSystem = 'ox_target' -- 'qb-target' | 'ox_target'


Config.Ped = {
    enabled = true,
    model = `a_m_m_indian_01`,
    coords = vector4(-266.89, -961.62, 30.23, 210.23),
    label = 'Open City Hall',
    icon = 'fas fa-id-card',
    scenario = 'WORLD_HUMAN_CLIPBOARD', -- idle animation, nil to disable
    interactDistance = 2.5
}


Config.Blip = {
    enabled = true,
    name = 'City Hall',
    sprite = 487,
    color = 2,
    scale = 0.8,
    shortRange = true
}


Config.Jobs = {
    { job = 'trucker',  label = 'Trucker',       salary = 50, grade = 0 },
    { job = 'taxi',     label = 'Taxi Driver',   salary = 50, grade = 0 },
    { job = 'tow',      label = 'Tow Truck',     salary = 50, grade = 0 },
    { job = 'reporter', label = 'News Reporter', salary = 50, grade = 0 },
}


Config.Documents = {
    {
        item = 'id_card',
        metaKey = 'id',
        label = 'ID Card',
        price = 100,
        buildInfo = function(PlayerData)
            return {
                citizenid = PlayerData.citizenid,
                firstname = PlayerData.charinfo.firstname,
                lastname = PlayerData.charinfo.lastname,
                birthdate = PlayerData.charinfo.birthdate,
                gender = PlayerData.charinfo.gender,
                nationality = PlayerData.charinfo.nationality,
            }
        end
    },
    {
        item = 'driver_license',
        metaKey = 'driver',
        label = 'Driver License',
        price = 100,
        buildInfo = function(PlayerData)
            return {
                firstname = PlayerData.charinfo.firstname,
                lastname = PlayerData.charinfo.lastname,
                birthdate = PlayerData.charinfo.birthdate,
                gender = PlayerData.charinfo.gender,
                type = 'Class C Driver License',
            }
        end
    },
    {
        item = 'weaponlicense',
        metaKey = 'weapon',
        label = 'Weapon License',
        price = 100,
        buildInfo = function(PlayerData)
            return {
                firstname = PlayerData.charinfo.firstname,
                lastname = PlayerData.charinfo.lastname,
                birthdate = PlayerData.charinfo.birthdate,
                gender = PlayerData.charinfo.gender,
            }
        end
    },
}

-- Shown in the "information" tab regardless of ownership (locked/unlocked state)
Config.InfoDocuments = {
    { item = 'id_card',        label = 'ID Card' },
    { item = 'driver_license', label = 'Driver License' },
    { item = 'weaponlicense',  label = 'Weapon License' },
}
