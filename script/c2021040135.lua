--Cyber Style 1
Duel.LoadScript("duellinks.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	aux.DuelLinksIgnition(c,s.flipcon,s.flipop,1)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--twice per duel check
	if Duel.GetFlagEffect(ep,id)>0 then return end
	--condition
	return aux.CanActivateSkill(tp)
		and Duel.GetLP(tp)<=2000
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	--place this card to the field
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--Field Spell
	local c=e:GetHandler()
	local n=math.floor((2000-Duel.GetLP(tp))/1000)+2
	repeat
		Duel.RegisterFlagEffect(ep,id,0,0,0)
		if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
			and Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
			local tc=Duel.CreateToken(tp,26439287)
			Duel.MoveToField(tc,tp,tp,LOCATION_MZONE,POS_FACEUP_ATTACK,true)
			--cannot release
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCode(EFFECT_UNRELEASABLE_SUM)
			e1:SetValue(1)
			tc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
			tc:RegisterEffect(e2)
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
			e3:SetCode(EFFECT_CANNOT_BE_MATERIAL)
			e3:SetValue(aux.cannotmatfilter(SUMMON_TYPE_SYNCHRO,SUMMON_TYPE_XYZ,SUMMON_TYPE_LINK))
			tc:RegisterEffect(e3)
			--special summon limit
			local e4=Effect.CreateEffect(c)
			e4:SetType(EFFECT_TYPE_FIELD)
			e4:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
			e4:SetRange(LOCATION_MZONE)
			e4:SetTargetRange(LOCATION_MZONE,0)
			e4:SetTarget(s.limit)
			c:RegisterEffect(e4)
			local e5=e4:Clone()
			e5:SetCode(EFFECT_CANNOT_ATTACK)
			tc:RegisterEffect(e5)
	   end
	until Duel.GetFlagEffect(ep,id)==n
end
function s.limit(e,c,tp,sumtp,sumpos)
	return not c:IsType(TYPE_FUSION)
end