--Light & Dark (2019)
Duel.LoadScript("duellinks.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	aux.DuelLinksIgnition(c,2021040100,s.flipcon,s.flipop,1)
end
function s.filter(c,lv,race,att)
	return c:IsAbleToHand() and c:IsType(TYPE_MONSTER)
		and c:IsAttribute(ATTRIBUTE_LIGHT+ATTRIBUTE_DARK)
		and c:IsLevel(lv)
		and c:IsRace(race)
		and not c:IsAttribute(att)
end
function s.tgtfilter(c,tp)
	return c:IsAbleToDeck() and c:IsType(TYPE_MONSTER)
		and c:IsAttribute(ATTRIBUTE_LIGHT+ATTRIBUTE_DARK)
		and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_DECK,0,1,nil,c:GetLevel(),c:GetRace(),c:GetAttribute())
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--twice per duel check
	if Duel.GetFlagEffect(ep,id)>1 then return end
	--condition
	return aux.CanActivateSkill(tp)
		and Duel.IsExistingMatchingCard(s.tgtfilter,tp,LOCATION_HAND,0,1,nil,tp)
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	--place this card to the field
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--Used skill flag register
	Duel.RegisterFlagEffect(ep,id,0,0,0)
	local c=e:GetHandler()
	local tc=Duel.SelectMatchingCard(tp,s.tgtfilter,tp,LOCATION_HAND,0,1,1,nil,tp)
	Duel.SendtoDeck(tc,nil,1,REASON_EFFECT)
	local lv=tc:GetFirst():GetLevel()
	local race=tc:GetFirst():GetRace()
	local att=tc:GetFirst():GetAttribute()
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_DECK,0,1,1,nil,lv,race,att)
	Duel.SendtoHand(g,tp,REASON_RULE)
end
