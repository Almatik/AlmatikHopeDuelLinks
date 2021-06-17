HINT_SKILL = 200
HINT_SKILL_COVER = 201
HINT_SKILL_FLIP  = 202
HINT_SKILL_REMOVE = 203
--function that return if the player (tp) can activate the skill
function DuelLinks.CanStartup(tp)
	return Duel.GetCurrentTurn()==1 and Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_DRAW
end
function DuelLinks.IsAbletoDraw(tp)
	return Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_DRAW and Duel.GetDrawCount()>0
end
function DuelLinks.CanIgnition(tp)
	return Duel.GetCurrentChain()==0 and Duel.GetTurnPlayer()==tp and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
end
-- Proc for basic skill
-- c: the card (card)
-- coverNum: the Number of the cover (int)
-- setcode: the 
-- skillcon: condition to activate the skill (function)
-- skillop: operation related to the skill activation (function)
-- countlimit: number of times you can use this skill
function DuelLinks.AddSkillProcedure(c,coverid,setcode,skillcon,skillop,countlimit)
	if event==nil then local event=EVENT_FREE_CHAIN end
	--activate
	local e1=Effect.CreateEffect(c) 
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_STARTUP)
	e1:SetRange(0x5f)
	e1:SetOperation(DuelLinks.SetSkillOp(coverid,setcode,skillcon,skillop,countlimit))
	c:RegisterEffect(e1)
end

-- Duel.Hint(HINT_SKILL_COVER,1,coverID|(BackEntryID<<32))
-- Duel.Hint(HINT_SKILL,1,FrontID)
function DuelLinks.SetSkillOp(coverid,setcode,skillcon,skillop,countlimit)
	return function(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		if skillop~=nil then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(setcode)
			if type(countlimit)=="number" then
				e1:SetCountLimit(countlimit)
			end
			e1:SetCondition(skillcon)
			e1:SetOperation(skillop)
			Duel.RegisterEffect(e1,e:GetHandlerPlayer())
		end
		Duel.DisableShuffleCheck(true)
		Duel.SendtoDeck(c,tp,-2,REASON_RULE)
		--generate the skill in the "skill zone"
		Duel.Hint(HINT_SKILL_COVER,c:GetControler(),coverid|(coverid<<32))
		Duel.Hint(HINT_SKILL,c:GetControler(),c:GetCode())
		--send to limbo then draw 1 if the skill was in the hand
		if e:GetHandler():IsPreviousLocation(LOCATION_HAND) then 
			Duel.Draw(p,1,REASON_RULE)
		end
		e:Reset()
	end
end