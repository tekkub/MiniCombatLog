local testframe1 = CreateFrame("ScrollingMessageFrame", "Mtestin", UIParent)
local testframe1bg = testframe1:CreateTexture(nil,"BACKGROUND")
testframe1bg:SetTexture(0,0,0,0.7)
testframe1bg:SetAllPoints(testframe1)
testframe1:SetBackdropBorderColor(0,0,0,0)
testframe1:SetBackdropColor(0,0,0,0.7)
testframe1:SetWidth(100)
testframe1:SetHeight(400)
testframe1:SetPoint("RIGHT",UIParent,"RIGHT",-100,0)
testframe1:SetMaxLines(250)
testframe1:SetFontObject(ChatFontSmall)
testframe1:SetJustifyH("LEFT")
testframe1:SetFading(false)

local testframe2 = CreateFrame("ScrollingMessageFrame", "Mtestheal", UIParent)
testframe2:SetWidth(100)
testframe2:SetHeight(400)
testframe2:SetPoint("RIGHT",UIParent,"RIGHT",-100,0)
testframe2:SetMaxLines(250)
testframe2:SetFontObject(ChatFontSmall)
testframe2:SetJustifyH("CENTER")
testframe2:SetFading(false)

local testframe3 = CreateFrame("ScrollingMessageFrame", "Mtestout", UIParent)
testframe3:SetWidth(100)
testframe3:SetHeight(400)
testframe3:SetPoint("RIGHT",UIParent,"RIGHT",-100,0)
testframe3:SetMaxLines(250)
testframe3:SetFontObject(ChatFontSmall)
testframe3:SetJustifyH("RIGHT")
testframe3:SetFading(false)

local white = "|cFFFFFFFF"
local yellow = "|cFFFFFF00"
local red = "|cFFFF0000"
local green = "|cFF00FF00"
local lightgreen = "|cFF00FF66"
local orange = "|cFFFF6600"

local function Mgetcolor(value)
    if COMBATLOG_DEFAULT_COLORS.schoolColoring[value] then
        local r = COMBATLOG_DEFAULT_COLORS.schoolColoring[value].r
        local g = COMBATLOG_DEFAULT_COLORS.schoolColoring[value].g
        local b = COMBATLOG_DEFAULT_COLORS.schoolColoring[value].b
        local string = string.format("|cff%02x%02x%02x", r*255, g*255, b*255)
        return string
    end
end

local function Mprint(chat1,chat2,chat3,color,text,critical)
    if critical then text = "*"..text.."*" end
    _G[chat1]:AddMessage(color..text.."|r")
    _G[chat2]:AddMessage(" ")
    _G[chat3]:AddMessage(" ")
end

local amount,prefix,color,chat

local f = CreateFrame("Frame")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:RegisterEvent("PLAYER_REGEN_DISABLED")
f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:SetScript("OnEvent", function(self,event,...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local player = UnitGUID("player")
        local pet = UnitGUID("pet")
        local _,minievent,guidsource,source,_,guidtarget,target,_,_,_,color = ...

        -- Player
        if (guidsource == player or guidtarget == player) then
            if minievent == "SWING_DAMAGE" and guidsource == player then 
                Mprint("Mtestin","Mtestheal","Mtestout",Mgetcolor(color),select(9,...),select(15,...))
            elseif minievent == "SWING_DAMAGE" and guidtarget == player then 
                Mprint("Mtestout","Mtestheal","Mtestin",Mgetcolor(color),select(9,...),select(15,...))
            elseif minievent == "SPELL_DAMAGE" and guidsource == player then 
                Mprint("Mtestin","Mtestheal","Mtestout",Mgetcolor(color),select(12,...),select(18,...))
            elseif minievent == "SPELL_DAMAGE" and guidtarget == player then 
                Mprint("Mtestout","Mtestheal","Mtestin",Mgetcolor(color),select(12,...),select(18,...))
            elseif minievent == "SPELL_PERIODIC_DAMAGE" and guidsource == player then 
                Mprint("Mtestin","Mtestheal","Mtestout",Mgetcolor(color),select(12,...),select(18,...))
            elseif minievent == "SPELL_PERIODIC_DAMAGE" and guidtarget == player then 
                Mprint("Mtestout","Mtestheal","Mtestin",Mgetcolor(color),select(12,...),select(18,...))
            elseif minievent == "ENVIRONMENTAL_DAMAGE" and guidsource == player then 
                Mprint("Mtestin","Mtestheal","Mtestout",Mgetcolor(color),select(10,...))
            elseif minievent == "SPELL_HEAL" and guidtarget == player then 
                if select(13,...) < select(12,...) then
                    Mprint("Mtestheal","Mtestout","Mtestin",green,select(12,...),select(14,...))
                end
            elseif minievent == "SPELL_PERIODIC_HEAL" and guidtarget == player then 
                if select(13,...) < select(12,...) then
                    Mprint("Mtestheal","Mtestout","Mtestin",lightgreen,select(12,...),select(14,...))
                end
            elseif minievent == "SPELL_HEAL" and guidtarget == pet then 
                if select(13,...) < select(12,...) then
                    Mprint("Mtestheal","Mtestout","Mtestin",green,"["..select(12,...).."]",select(14,...))
                end
            elseif minievent == "SPELL_PERIODIC_HEAL" and guidtarget == pet then 
                if select(13,...) < select(12,...) then
                    Mprint("Mtestheal","Mtestout","Mtestin",lightgreen,"["..select(12,...).."]",select(14,...))
                end
            else return end

        -- Pet
        elseif (guidsource == pet or guidtarget == pet) then
            if minievent == "SWING_DAMAGE" and guidsource == pet then 
                Mprint("Mtestin","Mtestheal","Mtestout",Mgetcolor(color),"["..select(9,...).."]",select(15,...))
            elseif minievent == "SWING_DAMAGE" and guidtarget == pet then 
                Mprint("Mtestout","Mtestheal","Mtestin",Mgetcolor(color),"["..select(9,...).."]",select(15,...))
            elseif minievent == "SPELL_DAMAGE" and guidsource == pet then 
                Mprint("Mtestin","Mtestheal","Mtestout",Mgetcolor(color),"["..select(12,...).."]",select(18,...))
            elseif minievent == "SPELL_DAMAGE" and guidtarget == pet then 
                Mprint("Mtestout","Mtestheal","Mtestin",Mgetcolor(color),"["..select(12,...).."]",select(18,...))
            elseif minievent == "SPELL_PERIODIC_DAMAGE" and guidsource == pet then 
                Mprint("Mtestin","Mtestheal","Mtestout",Mgetcolor(color),"["..select(12,...).."]",select(18,...))
            elseif minievent == "SPELL_PERIODIC_DAMAGE" and guidtarget == pet then 
                Mprint("Mtestout","Mtestheal","Mtestin",Mgetcolor(color),"["..select(12,...).."]",select(18,...))
            elseif minievent == "ENVIRONMENTAL_DAMAGE" and guidsoirce == pet then 
                Mprint("Mtestin","Mtestheal","Mtestout",Mgetcolor(color),"["..select(10,...).."]")
            else return end
        end

    elseif event == "PLAYER_REGEN_ENABLED" then
        Mprint("Mtestheal","Mtestout","Mtestin",green,"-- Combat --")
    elseif event == "PLAYER_REGEN_DISABLED" then
        Mprint("Mtestheal","Mtestout","Mtestin",red,"++ Combat ++")
    end
end)

print("mini combatlog")