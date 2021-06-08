--No Mortal Can Resist
local s,id=GetID()
function s.initial_effect(c)
	aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop,1)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--condition
	return aux.CanActivateSkill(tp)
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--cost
	Duel.PayLPCost(tp,3000)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(s.filter,tp,0,LOCATION_GRAVE,nil)
	local n=g:GetCount()
	Duel.SendToDeck(g,nil,-2,REASON_EFFECT)
	local total=0
	repeat
		code=Duel.CreateToken(tp,32274490)
		Duel.MoveToField(code,tp,1-tp,LOCATION_GRAVE,POS_FACEUP,true)
		total=total+1
	until total==n
end