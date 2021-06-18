--No Mortal Can Resist
Duel.LoadScript("duellinks.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	aux.DuelLinksIgnition(c,2021040100,s.flipcon,s.flipop,1)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--condition
	return aux.CanActivateSkill(tp)
		and Duel.GetMatchingGroup(Card.IsType,tp,0,LOCATION_GRAVE,nil,TYPE_MONSTER):GetCount()>0
		and Duel.GetLP(tp)+1000<=Duel.GetLP(1-tp)
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--cost
	local c=e:GetHandler()
	local sdg=Duel.GetMatchingGroup(Card.IsType,tp,0,LOCATION_GRAVE,nil,TYPE_MONSTER)
	local n=sdg:GetCount()
	Duel.SendtoDeck(sdg,nil,-2,REASON_RULE)
	repeat 
		local code=Duel.CreateToken(1-tp,32274490)
		Duel.SendtoGrave(code,REASON_RULE)
		n=n-1
	until n==0
end