--Grit
Duel.LoadScript("duellinks.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	aux.DuelLinksPredraw(c,s.flipcon,s.flipop,1)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--condition
	return Duel.GetCurrentChain()==0 and tp==Duel.GetTurnPlayer()
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	--random
	local lp=4000
	if Duel.GetLP(tp)<=4000 then
		local lp=Duel.GetLP(tp)
	end
	local n=Duel.GetRandomNumber(1,4000)
	if n>lp then return end
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_LOSE_LP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetLabelObject(c)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e1,tp)
	--flip during End phase
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCountLimit(1)
	e2:SetOperation(s.EPop)
	e2:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e2,tp)
end
function s.EPop(e,tp,eg,ep,ev,re,r,rp)
	if tp~=Duel.GetTurnPlayer() then
		Duel.Hint(HINT_SKILL_FLIP,tp,id|(2<<32))
	end
end