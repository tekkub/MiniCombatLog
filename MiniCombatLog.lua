
local mcl, frames = MCLFRAME, MCLFRAME.frames
MCLFRAME = nil


local player

--~ local triangle = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4.blp:0|t"
--~ local cross = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7.blp:0|t"
local skull = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8.blp:0|t"

local red = "|cFFFF0000"
local green = "|cFF00FF00"
local lightgreen = "|cFF99CC00"
local orange = "|cFFCC9900"
local colors = {}
local misstypes = {MISS = "Miss", PARRY = "Parry", DODGE = "Dodge", IMMUNE = "Immune"}


local function output(frame, color, text, critical, pet, prefix)
	local t = (color or "").. (pet and "[" or "").. (critical and "*" or "").. (frame ~= 1 and prefix or "").. text.. (critical and "*" or "").. (frame == 1 and prefix or "").. (pet and "]" or "")
	for i,f in pairs(frames) do f:AddMessage(i == frame and t or " ") end
end


mcl:RegisterEvent("PLAYER_LOGIN")
function mcl:PLAYER_LOGIN()
	player = UnitGUID("player")
	for i,v in pairs(COMBATLOG_DEFAULT_COLORS.schoolColoring) do colors[i] = string.format("|cff%02x%02x%02x", v.r*255, v.g*255, v.b*255) end
	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
end

mcl:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
function mcl:COMBAT_LOG_EVENT_UNFILTERED(event, timestamp, minievent, hidecaster, guidsource, source, sourceflags, sourceraidflags, guidtarget, target, targetflags, destraidflags, ...)
	local pet = UnitGUID("pet")
	if not (guidsource == player or guidtarget == player or guidsource == pet or guidtarget == pet) then return end

--~ 	print(minievent, ...)

	local text, color, crit, oframe, prefix, note, noteprefix
	local spellid, spellname, spellschool, damage, overkill, damageschool, resisted, blocked, absorbed, wascrit, wasglance, wascrush, healed, overheal, misstype
	local ispet = guidsource == pet or guidtarget == pet
	oframe = (guidsource == player or guidsource == pet) and 3 or 1

	if minievent == "SWING_DAMAGE" then
		damage, overkill, damageschool, resisted, blocked, absorbed, wascrit, wasglance, wascrush = ...
		text, crit, color = damage, wascrit, colors[damageschool]

	elseif minievent == "SWING_MISSED" then
		misstype, damage = ...
		text, color, prefix = damage or misstypes[misstype] or misstype, orange, damage and "b"

	elseif minievent == "SPELL_MISSED" then
		spellid, spellname, spellschool, misstype, damage = ...
		text, color, prefix = damage or misstypes[misstype] or misstype, colors[spellschool], damage and "b"

	elseif minievent == "SPELL_DAMAGE" or minievent == "SPELL_PERIODIC_DAMAGE" then
		spellid, spellname, spellschool, damage, overkill, damageschool, resisted, blocked, absorbed, wascrit, wasglance, wascrush = ...
		text, crit, color = damage, wascrit, colors[spellschool]

	elseif minievent == "ENVIRONMENTAL_DAMAGE" then
		envtype, damage, overkill, damageschool, resisted, blocked, absorbed, wascrit, wasglance, wascrush = ...
		text, crit, color = damage, wascrit, colors[damageschool]

	elseif minievent == "SPELL_HEAL" or minievent == "SPELL_PERIODIC_HEAL" then
		spellid, spellname, spellschool, healed, overheal, wascrit = ...
		if overheal < healed then text, crit, prefix = healed-overheal, wascrit, guidsource == player and guidtarget ~= player and "\226\134\145" end
		if overheal > 0 then note = overheal end
		color = minievent == "SPELL_PERIODIC_HEAL" and lightgreen or green
		oframe = 2

	elseif minievent == "UNIT_DIED" then
		text, color, oframe = skull..skull..skull, red, 2

	end

	if blocked   then prefix = "b" end
	if resisted  then prefix = "r" end
	if wasglance then prefix = "g" end
	if wascrush  then prefix = "c" end
	if absorbed  then prefix = "a" end

	if text then output(oframe, color, text, crit, ispet, prefix) end
	if note then output(oframe, orange, note, crit, ispet, noteprefix) end
end


mcl:RegisterEvent("PLAYER_REGEN_ENABLED")
function mcl:PLAYER_REGEN_ENABLED()
	if not UnitIsDead("player") then output(2, green, "-combat-") end
end


mcl:RegisterEvent("PLAYER_REGEN_DISABLED")
function mcl:PLAYER_REGEN_DISABLED()
	output(2, red, "+combat+")
end
