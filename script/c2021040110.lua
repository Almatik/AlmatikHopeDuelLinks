--Harpies' Hunting Ground
Duel.LoadScript("duellinks.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	aux.DuelLinksStartUp(c,2021040100,s.flipcon,s.flipop,1)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--condition
	return Duel.GetCurrentChain()==0 and Duel.GetTurnCount()==1
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--Field Spell
	local c=e:GetHandler()
	local code=Duel.CreateToken(tp,75782277)
	Duel.MoveToField(code,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
end