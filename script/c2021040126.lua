--Endless Trap Hell
Duel.LoadScript("duellinks.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	aux.DuelLinksSkill(c,1994,EVENT_FREE_CHAIN,s.flipcon,s.flipop,1)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--twice per duel check
	if Duel.GetFlagEffect(ep,id)>0 then return end
	--condition
	return aux.DLCanIgnition(tp) and Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_TRAP):GetCount()>=3
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	--Used skill flag register
	Duel.RegisterFlagEffect(ep,id,0,0,0)
	--place this card to the field
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	local tc1=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_TRAP):RandomSelect(tp,1)
	Duel.SendtoHand(tc1,nil,REASON_EFFECT)
	local tc2=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_TRAP):RandomSelect(tp,1)
	Duel.SendtoDeck(tc2,nil,2,REASON_EFFECT)
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(2<<32))
end