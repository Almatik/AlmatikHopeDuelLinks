HINT_SKILL = 200
HINT_SKILL_COVER = 201
HINT_SKILL_FLIP  = 202
HINT_SKILL_REMOVE = 203
--function that return if the player (tp) can activate the skill

-- Proc for basic skill
-- c: the card (card)
-- coverNum: the Number of the cover (int)
-- skillcon: condition to activate the skill (function)
-- skillop: operation related to the skill activation (function)
-- countlimit: number of times you can use this skill
-- skilltype: the type of the skill
-- setcode: the EVENT code

function Auxiliary.DuelLinksStartUp(c,skillcon,skillop,countlimit)
	local e1=Effect.CreateEffect(c) 
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_STARTUP)
	e1:SetRange(0x5f)
	e1:SetOperation(Auxiliary.DLSkillOp())
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c) 
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_STARTUP)
	e2:SetCountLimit(countlimit)
	e2:SetRange(0x5f)
	e2:SetOperation(skillcon)
	e2:SetOperation(skillop)
	c:RegisterEffect(e2)
end
function Auxiliary.DuelLinksPredraw(c,skillcon,skillop,countlimit)
	local e1=Effect.CreateEffect(c) 
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_STARTUP)
	e1:SetRange(0x5f)
	e1:SetOperation(Auxiliary.DLSkillOp(skillcon,skillop,countlimit,EVENT_PREDRAW))
	c:RegisterEffect(e1)
end
function Auxiliary.DuelLinksIgnition(c,skillcon,skillop,countlimit)
	--activate
	local e1=Effect.CreateEffect(c) 
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_STARTUP)
	e1:SetRange(0x5f)
	e1:SetOperation(Auxiliary.DLSkillOp(skillcon,skillop,countlimit,EVENT_FREE_CHAIN))
	c:RegisterEffect(e1)
end
function Auxiliary.DuelLinksTrigger(c,skillcon,skillop,countlimit,setcode)
	--activate
	local e1=Effect.CreateEffect(c) 
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_STARTUP)
	e1:SetRange(0x5f)
	e1:SetOperation(Auxiliary.DLSkillOp(skillcon,skillop,countlimit,setcode))
	c:RegisterEffect(e1)
end

-- Skill Ignition
function Auxiliary.DLSkillOp(skillcon,skillop,countlimit,setcode)
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
		--generate a cover for a card
		local coverid=Duel.GetRandomNumber(0,6)+2021040100
		Duel.Hint(HINT_SKILL_COVER,c:GetControler(),coverid)
		--generate the skill in the "skill zone"
		Duel.Hint(HINT_SKILL,c:GetControler(),c:GetCode())
		--generate random cover for your deck
		local g=Duel.GetFieldGroup(tp,LOCATION_DECK+LOCATION_EXTRA,0)
		local tc=g:GetFirst()
		local coverid=Duel.GetRandomNumber(7,62)+2021040100
		for tc in aux.Next(g) do
			--generate a cover for a card
			tc:Cover(coverid)
		end
		Duel.Remove(g,POS_FACEDOWN,REASON_RULE)
		local rm=Duel.GetFieldGroup(tp,LOCATION_REMOVED,0)
		Duel.SendtoDeck(rm,nil,2,REASON_EFFECT)
		Duel.ShuffleDeck(tp)
		--send to limbo then draw 1 if the skill was in the hand
		if e:GetHandler():IsPreviousLocation(LOCATION_HAND) then 
			Duel.Draw(p,1,REASON_RULE)
		end
	end
end

