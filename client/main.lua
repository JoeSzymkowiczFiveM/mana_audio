local function loadAudioBank(audioBank)
    local timeout = 500
    while not RequestScriptAudioBank(audioBank, false) do
        if timeout == 0 then
            return false
        else
            timeout -= 1
        end
        Wait(0)
    end
    return true
end

---@class PlaySoundParams
---@field audioBank string
---@field audioName string|string[]
---@field audioRef string

local function playSound(data)
    if type(data.audioName) == 'string' then
        data.audioName = {data.audioName}
    end
    loadAudioBank(data.audioBank)
    for i = 1, #data.audioName do
        local audioName = data.audioName[i]
        local soundId = GetSoundId()
        PlaySoundFrontend(soundId, audioName, data.audioRef, false)
        ReleaseSoundId(soundId)
    end
    ReleaseNamedScriptAudioBank(data.audioBank)
end

exports('PlaySound', playSound)

RegisterNetEvent('mana_audio:client:playSoundFromEntity', playSound)

---@class PlaySoundFromEntityParams: PlaySoundParams
---@field entity number

---@param data PlaySoundFromEntityParams
local function playSoundFromEntity(data)
    if type(data.audioName) == 'string' then
        data.audioName = {data.audioName}
    end
    loadAudioBank(data.audioBank)
    for i = 1, #data.audioName do
        local audioName = data.audioName[i]
        local soundId = GetSoundId()
        PlaySoundFromEntity(soundId, audioName, data.entity, data.audioRef, false, false)
        ReleaseSoundId(soundId)
    end
    ReleaseScriptAudioBank()
end

exports('PlaySoundFromEntity', playSoundFromEntity)

RegisterNetEvent('mana_audio:client:playSoundFromEntity', function(data)
    playSoundFromEntity({
        audioBank = data.audioBank,
        audioName = data.audioName,
        audioRef = data.audioRef,
        entity = NetworkGetEntityFromNetworkId(data.netId),
    })
end)

---@class PlaySoundFromCoordsParams: PlaySoundParams
---@field coords vector3
---@field range number

---@param data PlaySoundFromCoordsParams
local function playSoundFromCoords(data)
    if type(data.audioName) == 'string' then
        data.audioName = {data.audioName}
    end
    loadAudioBank(data.audioBank)
    for i = 1, #data.audioName do
        local audioName = data.audioName[i]
        local soundId = GetSoundId()
        PlaySoundFromCoord(soundId, audioName, data.coords.x, data.coords.y, data.coords.z, data.audioRef, false, data.range, false)
        ReleaseSoundId(soundId)
    end
    ReleaseScriptAudioBank()
end

exports('PlaySoundFromCoords', playSoundFromCoords)
RegisterNetEvent('mana_audio:client:playSoundFromCoords', playSoundFromCoords)