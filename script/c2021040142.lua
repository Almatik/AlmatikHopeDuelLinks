--Parasite Infestation (2019)
Duel.LoadScript("duellinks.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	aux.DuelLinksStartUp(c,s.flipcon,s.flipop,1)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
	--condition
	return g:Filter(Card.IsRace,nil,RACE_INSECT):GetClassCount(Card.GetCode)>=4
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--Balance
	--Get Cards
	local c=e:GetHandler()
	local n=Duel.RandomNumber(1,2)
	repeat
		Duel.RegisterFlagEffect(ep,id,0,0,0)
		local tc=Duel.CreateToken(tp,27911549)
		Duel.SendtoDeck(tc,1-tp,2,REASON_RULE)
	until Duel.GetFlagEffect(ep,id)==n
end