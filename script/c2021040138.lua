--Titan Showdown
Duel.LoadScript("duellinks.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	aux.DuelLinksStartUp(c,2021040100,nil,s.flipop,1)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(s.value1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_CHANGE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(0,1)
	e2:SetValue(s.value2)
	c:RegisterEffect(e2)
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
end
function s.value1(e,tp,re,dam,r,rp,rc)
	if (r&REASON_BATTLE)~=0 then
		if Duel.GetLP(tp)>Duel.GetLP(1-tp) then
			return dam*2
		else
			return dam
		end
	else
		return dam
	end
end
function s.value2(e,tp,re,dam,r,rp,rc)
	if (r&REASON_BATTLE)~=0 then
		if Duel.GetLP(tp)<Duel.GetLP(1-tp) then
			return dam*2
		else
			return dam
		end
	else
		return dam
	end
end
