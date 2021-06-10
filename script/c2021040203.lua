--Destiny Calling
local s,id=GetID()
function s.initial_effect(c)
	--skill
	aux.AddSkillProcedure(c,id,false,s.flipcon,s.flipop,1)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--twice per duel check
	if Duel.GetFlagEffect(ep,id)>1 then return end
	--condition
	return aux.CanActivateSkill(tp) and Duel.GetLP(tp)<=3000
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	--place this card to the field
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--Used skill flag register
	Duel.RegisterFlagEffect(ep,id,0,0,0)
	local g=Duel.GetFieldGroup(tp,LOCATION_FZONE,0)
	if #g>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
	end
	local code=Duel.CreateToken(tp,53527835)
	Duel.MoveToField(code,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
end

