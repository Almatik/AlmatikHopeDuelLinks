--Extra Extra
Duel.LoadScript("c20201040105.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	DuelLinks.AddSkillProcedure(c,1994,EVENT_DRAW,s.flipcon,s.flipop,1)
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
	Duel.Hint(HINT_CARD,tp,id)
	local code=eg:GetFirst():GetCode()
	local tc=Duel.CreateToken(tp,code)
	Duel.SendtoHand(tc,nil,REASON_EFFECT)
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(2<<32))
end
