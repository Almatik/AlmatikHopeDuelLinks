--Cyber Style 2
Duel.LoadScript("duellinks.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	aux.DuelLinksIgnition(c,2021040100,s.flipcon,s.flipop,1)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--twice per duel check
	if Duel.GetFlagEffect(ep,id)>0 then return end
	--condition
	return aux.CanActivateSkill(tp)
		and Duel.GetLP(tp)<=3000
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	--place this card to the field
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--Used skill flag register
	Duel.RegisterFlagEffect(ep,id,0,0,0)
	--Field Spell
	local c=e:GetHandler()
	local n=4000-Duel.GetLP(tp)
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and n>=1000 then
		Duel.MoveToField(Duel.CreateToken(tp,26439287),tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	end
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and n>=2000 then
		Duel.MoveToField(Duel.CreateToken(tp,26439287),tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	end
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and n>=3000 then
		Duel.MoveToField(Duel.CreateToken(tp,26439287),tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	end
end