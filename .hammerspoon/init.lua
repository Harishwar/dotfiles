-- Keys
local hyper = {"cmd", "alt", "ctrl"}

-- WiFi
local wifiWatcher = nil
local homeSSID = ""
local officeSSID = ""
local lastSSID = hs.wifi.currentNetwork()

function ssidChangedCallback()
    currentSSID = hs.wifi.currentNetwork()

    -- Show current WiFi network
    if currentSSID ~= "" and currentSSID ~= nil then
        hs.alert.show(currentSSID)
    end

    -- Home and Office settings
    newSSID = currentSSID
    if newSSID == homeSSID and lastSSID ~= homeSSID then
        -- Home WiFi network
        home_arrived()
    elseif newSSID ~= homeSSID and lastSSID == homeSSID then
        -- Departed from Home WiFi network
        setVolume(0)
    elseif newSSID == officeSSID and lastSSID ~= officeSSID then
        -- Office WiFi network
        office_arrived()
    elseif newSSID ~= officeSSID and lastSSID == officeSSID then
        -- Departed from Office WiFi network
        setVolume(20)
    end
    lastSSID = newSSID
end

-- Perform tasks to configure the system for my home WiFi network
function home_arrived()
    setSkypeStatus("Away")
    setVolume(50)
end

-- Perform tasks to configure the system for my office WiFi network
function office_arrived()
    setSkypeStatus("Online")
    setVolume(5)
end

-- Set Volume
function setVolume(vol)
    hs.audiodevice.defaultOutputDevice():setVolume(vol)
end

-- Reload config
function reloadConfig(paths)
    doReload = false
    for _,file in pairs(paths) do
        if file:sub(-4) == ".lua" then
            print("A lua file changed, doing reload")
            doReload = true
        end
    end
    if not doReload then
        print("No lua file changed, skipping reload")
        return
    end

    hs.reload()
end

-- Toggle Skype between muted/unmuted, whether it is focused or not
function setSkypeStatus(status)
    local skype = hs.appfinder.appFromName("Skype")

    if not skype then
        return
    end

    -- local lastapp = nil
    -- if not skype:isFrontmost() then
    --     lastapp = hs.application.frontmostApplication()
    --     skype:activate()
    -- end

    if status == "Online" then
        skype:selectMenuItem({"File", "Change Status", "Online"})
    elseif status == "Away" then
        skype:selectMenuItem({"File", "Change Status", "Away"})
    elseif status == "DND" then
        skype:selectMenuItem({"File", "Change Status", "Do not disturb"})
    elseif status == "Invisible" then
        skype:selectMenuItem({"File", "Change Status", "Invisible"})
    end

    -- if lastapp then
    --     lastapp:activate()
    -- end
end


-- Google search with the clipboard content
hs.hotkey.bind(hyper, "G", function()
  local content = hs.pasteboard.getContents()
  local searchUrl = "https://google.com/search?q=" .. content
  hs.execute("open " .. searchUrl)
end)

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()

configFileWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig)
configFileWatcher:start()
