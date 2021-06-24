--Light & Dark (2019)
Duel.LoadScript("duellinks.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	aux.DuelLinksIgnition(c,2021040100,s.flipcon,s.flipop,1)
end
function s.filter(c)
	return c:IsAbleToDeck() and (c:IsAttribute(ATTRIBUTE_DARK) or c:IsAttribute(ATTRIBUTE_LIGHT))
end
function s.filter1(c)
	return c:IsAbleToDeck() and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function s.filter2(c)
	return c:IsAbleToDeck() and c:IsAttribute(ATTRIBUTE_DARK)
end
function s.filterl(c)
	return c:IsAbleToHand() and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function s.filterd(c)
	return c:IsAbleToHand() and c:IsAttribute(ATTRIBUTE_DARK)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--twice per duel check
	if Duel.GetFlagEffect(ep,id)>1 then return end
	--condition
	return aux.CanActivateSkill(tp)
		and (Duel.IsExistingMatchingCard(s.filter1,tp,LOCATION_HAND,0,1,nil)
		and Duel.IsExistingMatchingCard(s.filterd,tp,LOCATION_DECK,0,1,nil))
		or (Duel.IsExistingMatchingCard(s.filter2,tp,LOCATION_HAND,0,1,nil)
		and Duel.IsExistingMatchingCard(s.filterl,tp,LOCATION_DECK,0,1,nil))
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	--place this card to the field
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--Used skill flag register
	Duel.RegisterFlagEffect(ep,id,0,0,0)
	local c=e:GetHandler()
	local g=Duel.SelectMatchingCard(tp,filter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoDeck(g,nil,1,REASON_EFFECT)
	if g:IsAttribute(ATTRIBUTE_LIGHT) then
		local tc=Duel.SelectMatchingCard(tp,filterd,tp,LOCATION_DECK,0,1,1,nil)
		Duel.SendtoHand(tc,tp,REASON_RULE)
	else
		local tc=Duel.SelectMatchingCard(tp,filterl,tp,LOCATION_DECK,0,1,1,nil)
		Duel.SendtoHand(tc,tp,REASON_RULE)
	end
end
