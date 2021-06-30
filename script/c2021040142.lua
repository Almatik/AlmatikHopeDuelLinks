--Parasite Infestation (2019)
Duel.LoadScript("duellinks.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	aux.DuelLinksPreDraw(c,s.flipcon,s.flipop,1)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND+LOCATION_DECK,0)
	--condition
	return Duel.GetTurnCount()==1
		and g:Filter(Card.IsRace,nil,RACE_INSECT):GetClassCount(Card.GetCode)>=4
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--Balance
	--Get Cards
	local c=e:GetHandler()
	local num=Duel.GetRandomNumber(1,2)
	repeat
		num = num-1
		local tc=Duel.CreateToken(tp,27911549)
		Duel.SendtoDeck(tc,1-tp,2,REASON_RULE)
		tc:ReverseInDeck()
	until num==0
	Duel.ShuffleDeck(1-tp)
end