--Duel Links Skills
Duel.LoadScript("turboduel.lua")
local s,id=GetID()
function s.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c) 
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_STARTUP)
	e1:SetRange(0x5f)
	e1:SetOperation(s.op)
	c:RegisterEffect(e1)
end
function s.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.DisableShuffleCheck()
	Duel.SendtoDeck(e:GetHandler(),tp,-2,REASON_RULE)
	s.announce_filter={0x1995,OPCODE_ISSETCARD,id,OPCODE_ISCODE,OPCODE_NOT,OPCODE_AND}
	for p=0,1 do
		local ac=Duel.AnnounceCard(p,table.unpack(s.announce_filter))
		local tc=Duel.CreateToken(p,ac)
		Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)
	end
end

