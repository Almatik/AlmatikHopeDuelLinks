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
	local c=e:GetHandler()
	local sdg=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_HAND,0,nil,TYPE_MONSTER)
	local n=sdg:GetCount()
	Duel.SendtoDeck(sdg,nil,-2,REASON_RULE)
	repeat 
		local code=Duel.CreateToken(tp,32274490)
		Duel.MoveToField(code,tp,tp,LOCATION_GRAVE,POS_FACEUP,true)
		n=n-1
	until n=0
end