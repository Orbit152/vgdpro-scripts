--封焰龙 犄角
local cm,m,o=GetID()
function cm.initial_effect(c)
	vgf.VgCard(c)
	vgd.EffectTypeTrigger(c,m,LOCATION_MZONE,EFFECT_TYPE_SINGLE,EVENT_ATTACK_ANNOUNCE,cm.operation,cm.cost,cm.condition)
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(1)
end

function cm.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c = e:GetHandler()
    if chk==0 then return Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_HAND,0,1,nil,TYPE_EQUIP) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
    local g=Duel.SelectMatchingCard(tp,Card.IsType,tp,LOCATION_HAND,0,1,1,nil,TYPE_EQUIP)
    Duel.ConfirmCards(1-tp,g)
end
function cm.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return vgf.RMonsterFilter(c) and c:GetFlagEffect(SupportFlag) > 0
end