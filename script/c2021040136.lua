--Cyber Style 1
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
	--Field Spell
	local c=e:GetHandler()
	local n=math.floor((4000-Duel.GetLP(tp))/1000)
	repeat
		Duel.RegisterFlagEffect(ep,id,0,0,0)
		if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
			then
			local tc=Duel.CreateToken(tp,26439287)
			Duel.MoveToField(tc,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
			
		end
	until Duel.GetFlagEffect(ep,id)==n
end