--Shadow Game
Duel.LoadScript("duellinks.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	aux.DuelLinksTrigger(c,s.flipcon,s.flipop,1,EVENT_PHASE+PHASE_END)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetTurnPlayer()
	--condition
	return Duel.GetFieldGroup(p,LOCATION_GRAVE,0):GetCount()>0
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	--place this card to the field
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--Field Spell
	local p=Duel.GetTurnPlayer()
	local d=Duel.GetFieldGroup(p,LOCATION_GRAVE,0):GetCount()*100
	Duel.Damage(p,d,REASON_RULE)
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(2<<32))
end