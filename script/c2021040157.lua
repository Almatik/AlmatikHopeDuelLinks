--Transcedent Crystals (2021)
Duel.LoadScript("duellinks.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	aux.DuelLinksIgnition(c,s.flipcon,s.flipop,1)
	local e1=Effect.CreateEffect(c) 
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_STARTUP)
	e1:SetCountLimit(1)
	e1:SetRange(0x5f)
	e1:SetCondition(s.checkcon)
	e1:SetOperation(s.checkop)
	c:RegisterEffect(e1)
end
function s.checkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroup(s.filter,tp,LOCATION_DECK,0,nil):GetClassCount(Card.GetCode)>=7
end
function s.checkop(e,tp,eg,ep,ev,re,r,rp)
	return Duel.RegisterFlagEffect(ep,id+1,0,0,0)
end
function s.filter(c)
	return c:IsSetCard(0x1034) and c:IsType(TYPE_MONSTER)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--twice per duel check
	if Duel.GetFlagEffect(ep,id)>1 then return end
	local n=3
	if Duel.GetFLagEffect(ep,id+1)>1 then local n=1 end
	--condition
	return aux.CanActivateSkill(tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_HAND,0,1,nil)
		and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_DECK,0,1,nil)
		and Duel.GetTurnCount()>=n
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	--place this card to the field
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--Used skill flag register
	Duel.RegisterFlagEffect(ep,id,0,0,0)
	local c=e:GetHandler()
	local ft=Duel.GetMatchingGroupCount(s.filter,tp,LOCATION_DECK,0,nil)
	if ft>3 then local ft=3 end
	local ct=Duel.DiscardHand(tp,Card.IsAbleToGrave,1,ft,REASON_EFFECT)
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_DECK,0,ct,ct,nil)
	if #g>0 then
		local tc=g:GetFirst()
		for tc in aux.Next(g) do
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetCode(EFFECT_CHANGE_TYPE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
			e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
			tc:RegisterEffect(e1)
		end
		Duel.RaiseEvent(g,EVENT_CUSTOM+id,e,0,tp,0,0)
	end
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(2<<32))
	s[2+tp]=0
end

