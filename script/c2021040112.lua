--No Mortal Can Resist
local s,id=GetID()
function s.initial_effect(c)
	aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop,1)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--condition
	return aux.CanActivateSkill(tp)
end
function s.filter(c)
	return c:IsAbleToRemove() and c:IsType(TYPE_MONSTER)
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--cost
	local c=e:GetHandler()
	local g=Duel.GetFieldGroup(tp,LOCATION_GRAVE,0)
	Duel.SendToDeck(g,nil,-2,REASON_EFFECT)
end