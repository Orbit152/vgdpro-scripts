--封焰之巫女 婆缚娑伽罗
local cm,m,o=GetID()
function cm.initial_effect(c)
	vgf.VgCard(c)
	vgd.EffectTypeTrigger(c,m,LOCATION_MZONE,EFFECT_TYPE_EQUIP,nil,cm.operation,nil,cm.condition,nil,1)
	vgd.EffectTypeIgnition(c,m,LOCATION_MZONE)
end

function cm.condition(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	return vgf.VMonsterFilter(c)
end

--灵魂填充1，选择你的弃牌区中的1张等级1以下的卡，CALL到R上。
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
    local rc=Duel.GetMatchingGroup(vgf.VMonsterFilter,tp,LOCATION_MZONE,0,nil):GetFirst()
	local mg=rc:GetOverlayGroup()
    local g=Duel.GetDecktopGroup(tp,1)
	Duel.Overlay(g,mg)
	vgf.SearchCardSpecialSummon(LOCATION_DROP,cm.filter)
end
function cm.filter(c)
	return c:IsLevel(0,1)
end
