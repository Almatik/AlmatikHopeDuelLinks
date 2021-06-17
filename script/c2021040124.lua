--Extra Extra
local s,id=GetID()
function s.initial_effect(c)
	Duel.Hint(HINT_SKILL_COVER,tp,1994|(1994<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--Activate
	local e1=Effect.CreateEffect(c) 
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_STARTUP)
	e1:SetRange(0x5f)
	e1:SetOperation(Auxiliary.SetSkillOp(1,s.flipcon,s.flipop,1,EVENT_DRAW))
	c:RegisterEffect(e1)
	aux.GlobalCheck(s,function()
		s[0]=nil
		s[1]=nil
		s[2]=0
		s[3]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetOperation(s.checkop)
		Duel.RegisterEffect(ge1,0)
	end)
end
function s.checkop(e,tp,eg,ep,ev,re,r,rp)
	if not s[tp] then s[tp]=Duel.GetLP(tp) end
	if s[tp]>Duel.GetLP(tp) then
		s[2+tp]=s[2+tp]+(s[tp]-Duel.GetLP(tp))
		s[tp]=Duel.GetLP(tp)
	end
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--condition
	return s[2+tp]>=0 and ep==tp and Duel.GetCurrentPhase()==PHASE_DRAW
		and Duel.GetTurnPlayer()==tp
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	--place this card to the field
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	local code=eg:GetFirst():GetCode()
	local tc=Duel.CreateToken(tp,code)
	Duel.SendtoHand(tc,nil,REASON_EFFECT)
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(2<<32))
end
