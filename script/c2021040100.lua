--Duel Links Skills
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
	local skill={2021040101,2021040102,2021040103,2021040104,2021040105,2021040106,2021040107,2021040108,2021040109,2021040110}
	for p=0,1 do
		Duel.Hint(HINT_SELECTMSG,p,aux.Stringid(id,1))
		local code=Duel.SelectCardsFromCodes(p,1,1,false,false,table.unpack(skill))
		Duel.SendtoDeck(code,p,2,REASON_RULE)
	end
end