--封焰龙 贫瘠
local cm,m,o=GetID()
function cm.initial_effect(c)
	vgf.VgCard(c)
	vgd.EffectTypeTrigger(c,m,LOCATION_MZONE,SUMMON_TYPE_NORMAL,nil,cm.operation,vgf.DamageCost(1))
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
	vgf.SearchCard(LOCATION_DROP,cm.filter)
end
function cm.filter(c)
	return c:IsType(TYPE_EQUIP)
end