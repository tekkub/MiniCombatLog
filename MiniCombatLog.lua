local testframe1 = CreateFrame("ScrollingMessageFrame", nil, UIParent)
testframe1:SetBackdropBorderColor(0,0,0,0)
testframe1:SetBackdropColor(0,0,0,0.7)
testframe1:SetWidth(60)
testframe1:SetHeight(400)
testframe1:SetPoint("RIGHT",UIParent,"RIGHT",-100,0)
testframe1:SetMaxLines(250)
testframe1:SetFontObject(ChatFontSmall)
testframe1:SetJustifyH("LEFT")
testframe1:SetFading(false)

local testframe2 = CreateFrame("ScrollingMessageFrame", nil, UIParent)
testframe2:SetAllPoints(testframe1)
testframe2:SetMaxLines(250)
testframe2:SetFontObject(ChatFontSmall)
testframe2:SetJustifyH("CENTER")
testframe2:SetFading(false)

local testframe3 = CreateFrame("ScrollingMessageFrame", nil, UIParent)
testframe3:SetAllPoints(testframe1)
testframe3:SetMaxLines(250)
testframe3:SetFontObject(ChatFontSmall)
testframe3:SetJustifyH("RIGHT")
testframe3:SetFading(false)

local bg = testframe1:CreateTexture(nil,"BACKGROUND")
bg:SetTexture(0,0,0,0.7)
bg:SetPoint("TOPLEFT",testframe1,"TOPLEFT",-2,0)
bg:SetPoint("BOTTOMRIGHT",testframe1,"BOTTOMRIGHT",2,-20)

local icon = "Interface\\LFGFrame\\LFGRole"

local tex1 = testframe1:CreateTexture(nil,"ARTWORK")
tex1:SetWidth(14)
tex1:SetHeight(14)
tex1:SetTexture(icon)
tex1:SetTexCoord(0.25, 0, 0.25, 1, 0.5, 0, 0.5, 1)
tex1:SetPoint("TOPLEFT",testframe1,"BOTTOMLEFT",0,-5)

local tex2 = testframe2:CreateTexture(nil,"ARTWORK")
tex2:SetWidth(14)
tex2:SetHeight(14)
tex2:SetTexture(icon)
tex2:SetTexCoord(0.75, 0, 0.75, 1, 1, 0, 1, 1)
tex2:SetPoint("TOP",testframe1,"BOTTOM",0,-5)

local tex3 = testframe3:CreateTexture(nil,"ARTWORK")
tex3:SetWidth(14)
tex3:SetHeight(14)
tex3:SetTexture(icon)
tex3:SetTexCoord(0.5, 0, 0.5, 1, 0.75, 0, 0.75, 1)
tex3:SetPoint("TOPRIGHT",testframe1,"BOTTOMRIGHT",0,-5)

local red = "|cFFFF0000"
local green = "|cFF00FF00"
local lightgreen = "|cFF99CC00"
local triangle = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4.blp:0|t"
local cross = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7.blp:0|t"
local skull = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8.blp:0|t"

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
    chat1:AddMessage(color..text.."|r")
    chat2:AddMessage(" ")
    chat3:AddMessage(" ")
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
		if minievent == "SWING_DAMAGE" and guidsource == player then 
			Mprint(testframe1,testframe2,testframe3,Mgetcolor(color),select(9,...),select(15,...))
		elseif minievent == "SWING_DAMAGE" and guidtarget == player then 
			Mprint(testframe3,testframe2,testframe1,Mgetcolor(color),select(9,...),select(15,...))
		elseif minievent == "SPELL_DAMAGE" and guidsource == player then 
			Mprint(testframe1,testframe2,testframe3,Mgetcolor(color),select(12,...),select(18,...))
		elseif minievent == "SPELL_DAMAGE" and guidtarget == player then 
			Mprint(testframe3,testframe2,testframe1,Mgetcolor(color),select(12,...),select(18,...))
		elseif minievent == "SPELL_PERIODIC_DAMAGE" and guidsource == player then 
			Mprint(testframe1,testframe2,testframe3,Mgetcolor(color),select(12,...),select(18,...))
		elseif minievent == "SPELL_PERIODIC_DAMAGE" and guidtarget == player then 
			Mprint(testframe3,testframe2,testframe1,Mgetcolor(color),select(12,...),select(18,...))
		elseif minievent == "ENVIRONMENTAL_DAMAGE" and guidtarget == player then 
			Mprint(testframe1,testframe2,testframe3,Mgetcolor(color),select(10,...),nil)
		elseif minievent == "SPELL_HEAL" and guidtarget == player then 
			if select(13,...) < select(12,...) then
				Mprint(testframe2,testframe1,testframe3,green,select(12,...),select(14,...))
			end
		elseif minievent == "SPELL_PERIODIC_HEAL" and guidtarget == player then 
			if select(13,...) < select(12,...) then
				Mprint(testframe2,testframe1,testframe3,lightgreen,select(12,...),select(14,...))
			end
		elseif minievent == "SPELL_HEAL" and guidtarget == pet then 
			if select(13,...) < select(12,...) then
				Mprint(testframe2,testframe1,testframe3,green,"["..select(12,...).."]",select(14,...))
			end
		elseif minievent == "SPELL_PERIODIC_HEAL" and guidtarget == pet then 
			if select(13,...) < select(12,...) then
				Mprint(testframe2,testframe1,testframe3,lightgreen,"["..select(12,...).."]",select(14,...))
			end

		-- Pet
		elseif minievent == "SWING_DAMAGE" and guidsource == pet then 
			Mprint(testframe1,testframe2,testframe3,Mgetcolor(color),"["..select(9,...).."]",select(15,...))
		elseif minievent == "SWING_DAMAGE" and guidtarget == pet then 
			Mprint(testframe3,testframe2,testframe1,Mgetcolor(color),"["..select(9,...).."]",select(15,...))
		elseif minievent == "SPELL_DAMAGE" and guidsource == pet then 
			Mprint(testframe1,testframe2,testframe3,Mgetcolor(color),"["..select(12,...).."]",select(18,...))
		elseif minievent == "SPELL_DAMAGE" and guidtarget == pet then 
			Mprint(testframe3,testframe2,testframe1,Mgetcolor(color),"["..select(12,...).."]",select(18,...))
		elseif minievent == "SPELL_PERIODIC_DAMAGE" and guidsource == pet then 
			Mprint(testframe1,testframe2,testframe3,Mgetcolor(color),"["..select(12,...).."]",select(18,...))
		elseif minievent == "SPELL_PERIODIC_DAMAGE" and guidtarget == pet then 
			Mprint(testframe3,testframe2,testframe1,Mgetcolor(color),"["..select(12,...).."]",select(18,...))
		elseif minievent == "ENVIRONMENTAL_DAMAGE" and guidtarget == pet then 
			Mprint(testframe1,testframe2,testframe3,Mgetcolor(color),"["..select(10,...).."]",nil)
		else return end

    elseif event == "PLAYER_REGEN_ENABLED" then
		Mprint(testframe2,testframe1,testframe3,green,"+++")
    elseif event == "PLAYER_REGEN_DISABLED" then
        Mprint(testframe2,testframe1,testframe3,red,"---")
    end
end)

print("mini combatlog")