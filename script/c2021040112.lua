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
	Duel.SendtoDeck(sdg,nil,-2,REASON_RULE)
end