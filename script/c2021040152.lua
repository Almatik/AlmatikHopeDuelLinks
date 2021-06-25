--Master of Destiny
Duel.LoadScript("duellinks.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	aux.DuelLinksTrigger(c,2021040100,s.flipcon,s.flipop,nil,EVENT_TOSS_COIN_NEGATE)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--condition
	return ep==tp and Duel.GetFlagEffect(ep,id)<3
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	--place this card to the field
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--Field Spell
	local res={Duel.GetCoinResult()}
	local ct=ev
	for i=1,ct do
		if Duel.GetFlagEffect(ep,id)<3 then
			res[i]=1
		end
		Duel.RegisterFlagEffect(ep,id,0,0,0)
	end
	Duel.SetCoinResult(table.unpack(res))
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(2<<32))
end