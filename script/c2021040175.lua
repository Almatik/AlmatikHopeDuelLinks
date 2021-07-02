--Baggy Sleeves
Duel.LoadScript("duellinks.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	aux.DuelLinksPredraw(c,s.flipcon,s.flipop,1)
	local e1=Effect.CreateEffect(c) 
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(s.checkcon)
	e1:SetOperation(s.checkop)
	c:RegisterEffect(e1)
end
function s.checkfilter(c)
	return c:IsReason(REASON_BATTLE) and c:IsPreviousControler(tp) and c:IsLevelAbove(1)
end
function s.checkcon(e,tp,eg,ep,ev,re,r,rp)
   return eg:IsExists(s.checkfilter,1,nil,tp) 
end
function s.checkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RegisterFlagEffect(tp,id,0,0,0)
	Duel.Damage(tp,100,REASON_RULE)
end
function s.filter(c)
	return c:IsAttribute(ATTRIBUTE_DARK)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--condition
	return Duel.GetCurrentChain()==0 and tp==Duel.GetTurnPlayer()
		and Duel.GetDrawCount(tp)==1 and Duel.GetFlagEffect(tp,id)>0
		and not Duel.GetFlagEffect(tp,id+1)>0
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	--ask if you want to activate the skill or not
	if not Duel.SelectYesNo(tp,aux.Stringid(id,0)) then return end
	Duel.RegisterFlagEffect(tp,id+1,0,0,0)
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--Draw
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DRAW_COUNT)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(2)
	e1:SetReset(RESET_PHASE+PHASE_DRAW)
	Duel.RegisterEffect(e1,tp)
end
