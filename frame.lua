
local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)

local textframe1 = CreateFrame("ScrollingMessageFrame", nil, UIParent)
textframe1:SetBackdropBorderColor(0,0,0,0)
textframe1:SetBackdropColor(0,0,0,0.7)
textframe1:SetWidth(60)
textframe1:SetHeight(400)
textframe1:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, -30)
textframe1:SetMaxLines(250)
textframe1:SetFontObject(ChatFontSmall)
textframe1:SetJustifyH("LEFT")
textframe1:SetFading(false)

local textframe2 = CreateFrame("ScrollingMessageFrame", nil, UIParent)
textframe2:SetAllPoints(textframe1)
textframe2:SetMaxLines(250)
textframe2:SetFontObject(ChatFontSmall)
textframe2:SetJustifyH("CENTER")
textframe2:SetFading(false)

local textframe3 = CreateFrame("ScrollingMessageFrame", nil, UIParent)
textframe3:SetAllPoints(textframe1)
textframe3:SetMaxLines(250)
textframe3:SetFontObject(ChatFontSmall)
textframe3:SetJustifyH("RIGHT")
textframe3:SetFading(false)

local bg = textframe1:CreateTexture(nil,"BACKGROUND")
bg:SetTexture(0,0,0,0.7)
bg:SetPoint("TOPLEFT",textframe1,"TOPLEFT",-2,0)
bg:SetPoint("BOTTOMRIGHT",textframe1,"BOTTOMRIGHT",2,-20)

local icon = "Interface\\LFGFrame\\LFGRole"

local tex1 = textframe1:CreateTexture(nil,"ARTWORK")
tex1:SetWidth(14)
tex1:SetHeight(14)
tex1:SetTexture(icon)
tex1:SetTexCoord(0.5, 0, 0.5, 1, 0.75, 0, 0.75, 1)
tex1:SetPoint("TOPLEFT",textframe1,"BOTTOMLEFT",0,-5)

local tex2 = textframe2:CreateTexture(nil,"ARTWORK")
tex2:SetWidth(14)
tex2:SetHeight(14)
tex2:SetTexture(icon)
tex2:SetTexCoord(0.75, 0, 0.75, 1, 1, 0, 1, 1)
tex2:SetPoint("TOP",textframe1,"BOTTOM",0,-5)

local tex3 = textframe3:CreateTexture(nil,"ARTWORK")
tex3:SetWidth(14)
tex3:SetHeight(14)
tex3:SetTexture(icon)
tex3:SetTexCoord(0.25, 0, 0.25, 1, 0.5, 0, 0.5, 1)
tex3:SetPoint("TOPRIGHT",textframe1,"BOTTOMRIGHT",0,-5)


f.frames = {textframe1, textframe2, textframe3}


MCLFRAME = f
