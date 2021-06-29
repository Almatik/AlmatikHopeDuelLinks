--Alternative Evolution
Duel.LoadScript("duellinks.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	aux.DuelLinksIgnition(c,s.flipcon,s.flipop,1)
end
function s.filter(c)
	return c:IsCode(89631139) and c:IsAttackAbove(3000)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--twice per duel check
	if Duel.GetFlagEffect(ep,id)>0 then return end
	--condition
	return aux.CanActivateSkill(tp)
		and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_MZONE,0,1,nil)
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	--place this card to the field
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--Used skill flag register
	Duel.RegisterFlagEffect(ep,id,0,0,0)
	local c=e:GetHandler()
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local pos=g:GetPosition()
	Duel.SendtoDeck(g,tp,-2,REASON_RULE)
	local tc=Duel.CreateToken(tp,38517737)
	Duel.MoveToField(tc,tp,tp,LOCATION_MZONE,pos,true)
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(2<<32))
end
