--Light & Dark (2019)
Duel.LoadScript("duellinks.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	aux.DuelLinksIgnition(c,2021040100,s.flipcon,s.flipop,1)
end
	--Return filter
function s.tgfilter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsAttribute(ATTRIBUTE_DARK+ATTRIBUTE_LIGHT) and c:IsAbleToDeck()
		and Duel.IsExistingMatchingCard(s.filter1,tp,LOCATION_DECK,0,1,nil,c:GetAttribute())
end
	--Filter to send 1 monster with opposite attribute of discard monster
function s.filter1(c,att)
	return c:IsAbleToHand() and c:IsType(TYPE_MONSTER) and c:IsAttribute(ATTRIBUTE_DARK+ATTRIBUTE_LIGHT) and not c:IsAttribute(att)
end
	--TO Hand filter
function s.filter2(c)
	return c:IsAttribute(ATTRIBUTE_DARK+ATTRIBUTE_LIGHT) and c:IsAbleToHand()
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--twice per duel check
	if Duel.GetFlagEffect(ep,id)>1 then return end
	--condition
	return aux.CanActivateSkill(tp)
		and Duel.IsExistingMatchingCard(s.tgfilter,tp,LOCATION_HAND,0,1,nil,tp)
		and  Duel.IsExistingMatchingCard(s.filter2,tp,LOCATION_DECK,0,1,nil,tp)
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	--place this card to the field
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--Used skill flag register
	Duel.RegisterFlagEffect(ep,id,0,0,0)
	local c=e:GetHandler()
	local g=Duel.SelectMatchingCard(tp,tgfilter,tp,LOCATION_HAND,0,1,1,nil)
	local att=g:GetFirst():GetAttribute()
	Duel.SendtoDeck(g,nil,1,REASON_EFFECT)
	local tc=Duel.SelectMatchingCard(tp,filter1,tp,LOCATION_DECK,0,1,1,nil,att)
	Duel.SendtoHand(tc,tp,REASON_RULE)
end
