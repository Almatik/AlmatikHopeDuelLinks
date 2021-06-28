--Parasite Infestation (2017)
Duel.LoadScript("duellinks.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	aux.DuelLinksStartUp(c,s.flipcon,s.flipop,1)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--condition
	return true
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--Balance
	--Get Cards
	local c=e:GetHandler()
	local num=Duel.GetRandomNumber(1,3)
	if num>0 then
		local tc=Duel.CreateToken(tp,27911549)
		Duel.SendtoDeck(tc,1-tp,2,REASON_RULE)
	end
	if num>1 then
		local tc=Duel.CreateToken(tp,27911549)
		Duel.SendtoDeck(tc,1-tp,2,REASON_RULE)
	end
	if num>2 then
		local tc=Duel.CreateToken(tp,27911549)
		Duel.SendtoDeck(tc,1-tp,2,REASON_RULE)
	end
end