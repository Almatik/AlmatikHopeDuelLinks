--Master of Destiny (2021)
Duel.LoadScript("duellinks.lua")
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	aux.DuelLinksTrigger(c,s.flipcon,s.flipop,nil,EVENT_TOSS_COIN_NEGATE)
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
function s.checkfilter(c)
	return c.toss_coin
end
function s.checkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroup(s.checkfilter,tp,LOCATION_DECK,0,nil):GetClassCount(Card.GetCode)>=7
end
function s.checkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RegisterFlagEffect(ep,id,0,0,0)
	local dt=Duel.GetDrawCount(tp)
	if dt~=0 then
		_replace_count=0
		_replace_max=dt
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_DRAW_COUNT)
		e1:SetTargetRange(1,0)
		e1:SetReset(RESET_PHASE+PHASE_DRAW,2)
		e1:SetValue(0)
		Duel.RegisterEffect(e1,tp)
	end
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--condition
	return ep==tp
		and Duel.GetFlagEffect(ep,id)>0
		and Duel.GetFlagEffect(ep,id)<4
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	--place this card to the field
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--Field Spell
	local res={Duel.GetCoinResult()}
	local ct=ev
	for i=1,ct do
		if Duel.GetFlagEffect(ep,id)<4 then
			res[i]=1
		end
		Duel.RegisterFlagEffect(ep,id,0,0,0)
	end
	Duel.SetCoinResult(table.unpack(res))
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(2<<32))
end