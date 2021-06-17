--Endless Trap Hell
Duel.LoadScript("duellinks.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	aux.DuelLinksSkill(c,1994,EVENT_FREE_CHAIN,s.flipcon,s.flipop,1)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--condition
	return aux.DLCanIgnition(tp) and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,3,nil,TYPE_SPELL)
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	--place this card to the field
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	local tc1=Duel.GetFieldGroup(tp,LOCATION_GRAVE,0):Filter(Card.IsType,nil,tp,TYPE_SPELL):RandomSelect(tp,1)
	Duel.SendtoHand(tc1,nil,REASON_EFFECT)
	local tc2=Duel.GetFieldGroup(tp,LOCATION_GRAVE,0):Filter(Card.IsType,nil,tp,TYPE_SPELL):RandomSelect(tp,1)
	Duel.SendtoDeck(tc2,nil,0,REASON_EFFECT)
end