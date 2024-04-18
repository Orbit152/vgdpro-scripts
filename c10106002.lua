--封焰龙 师子贤
local cm,m,o=GetID()
function cm.initial_effect(c)
	vgf.VgCard(c)
	vgd.EffectTypeTrigger(c,m,nil,EFFECT_TYPE_SINGLE,EVENT_SPSUMMON_SUCCESS,cm.operation,nil,cm.condition)
	vgd.EffectTypeTrigger(c,m,LOCATION_MZONE,EFFECT_TYPE_SINGLE,EVENT_ATTACK_ANNOUNCE,cm.op2,nil,cm.con2)
end

function cm.operation(e,tp,eg,ep,ev,re,r,rp)
	local c = VgF.SearchCard(LOCATION_DROP,cm.filter)
end

function cm.condition(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	local mc = VgF.ReturnCard(c:GetMaterial())
	return c:IsSummonType(SUMMON_TYPE_RIDE) and mc:IsCode(10106003)
end

function cm.filter(c)
	return c:IsType(TYPE_EQUIP)
end

function cm.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	VgF.AtkUp(c,c,5000)
	Duel.RaiseEvent(c,EVENT_CUSTOM+m,e,0,tp,tp,0)
end

function cm.con2(e,tp,eg,ep,ev,re,r,rp)
	local c = e:GetHandler()
	return vgf.RMonsterFilter(c) --先导者装备了卡片没写
end