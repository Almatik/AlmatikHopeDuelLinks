--Grit (2018)
Duel.LoadScript("duellinks.lua")
local s,id=GetID()
function s.initial_effect(c)
	aux.DuelLinksTrigger(c,s.checkcon,s.checkop,1,EVENT_PREDRAW)
	local e1=Effect.CreateEffect(c) 
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(s.flipcon1)
	e1:SetOperation(s.flipop1)
	c:RegisterEffect(e1)
end
function s.checkcon(e,tp,eg,ep,ev,re,r,rp)
	--condition
	return Duel.GetLP(tp)>=4000
end
function s.checkop(e,tp,eg,ep,ev,re,r,rp)
	--random
	Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,0)
end
function s.flipcon1(e,tp,eg,ep,ev,re,r,rp)
	--condition
	return Duel.GetBattleDamage(tp)>=Duel.GetLP(tp)
end
function s.flipop1(e,tp,eg,ep,ev,re,r,rp)
	--random
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(s.damop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,Duel.GetLP(tp)-1)
end
