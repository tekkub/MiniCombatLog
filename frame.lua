
local f = CreateFrame("Frame", nil, UIParent)
f:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)

f:SetWidth(60)
f:SetHeight(400)
f:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, -30)


f.frames = {}
for i=1,3 do
	local smf = CreateFrame("ScrollingMessageFrame", nil, f)
	smf:SetAllPoints()
	smf:SetMaxLines(250)
	smf:SetFontObject(ChatFontSmall)
	smf:SetFading(false)

	f.frames[i] = smf
end
f.frames[1]:SetJustifyH("LEFT")
f.frames[2]:SetJustifyH("CENTER")
f.frames[3]:SetJustifyH("RIGHT")


local bg = f:CreateTexture(nil, "BACKGROUND")
bg:SetTexture(0, 0, 0, 0.7)
bg:SetPoint("TOPLEFT", f, "TOPLEFT", -2, 0)
bg:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 2, -20)


local icon = "Interface\\LFGFrame\\LFGRole"

local tex1 = f:CreateTexture(nil, "ARTWORK")
tex1:SetWidth(14)
tex1:SetHeight(14)
tex1:SetTexture(icon)
tex1:SetTexCoord(1/2, 0, 1/2, 1, 3/4, 0, 3/4, 1)
tex1:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 0, -5)

local tex2 = f:CreateTexture(nil, "ARTWORK")
tex2:SetWidth(14)
tex2:SetHeight(14)
tex2:SetTexture(icon)
tex2:SetTexCoord(3/4, 0, 3/4, 1, 1, 0, 1, 1)
tex2:SetPoint("TOP", f, "BOTTOM", 0, -5)

local tex3 = f:CreateTexture(nil, "ARTWORK")
tex3:SetWidth(14)
tex3:SetHeight(14)
tex3:SetTexture(icon)
tex3:SetTexCoord(1/4, 0, 1/4, 1, 1/2, 0, 1/2, 1)
tex3:SetPoint("TOPRIGHT", f, "BOTTOMRIGHT", 0, -5)


MCLFRAME = f
