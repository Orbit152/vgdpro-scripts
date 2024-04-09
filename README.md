# vgdpro的卡片脚本编写文档

本游戏的脚本基于lua。使用自定义库：`VgD.lua`,`VgDefinition.Lua`,`VgFuncLib.lua`来涵括大部分需要的内容。
大家写脚本基本只需要一些基础的逻辑整理和调用对应的库就能完成编写。以下是一些最基础的教程
如果还有不懂可以加群：721095458
## 默认白板卡片脚本（即默认脚本）

```lua
    local cm,m,o=GetID()
    
    function cm.initial_effect(c)--这个函数下面用于注册效果
         vgf.VgCard(c)
         --在这之后插入自定义函数或者代码块
         cm.sample(x)
    end
    
    --可以在这之后自定义函数来调用（函数必须是cm.函数名）
    function cm.sample(x)
    	    --代码
    end
```
## 关于vgd的效果分类以及增加效果
### vg常见的效果类型
-  **【起】启动效果**
    -  这就是最基本的手动开启的效果（类似游戏王里的茉莉②效果那样的主动效果）
-  **【自】诱发效果**
    -  有费用的自能力为诱发选发效果而无费用的为诱发必发效果（类似游戏王里xxx的效果）
-  **【永】永续效果**
    -  类似于游戏王里肿头龙的持续类效果
-  **以及指令能力**
    - 等价于游戏王中的魔法卡的发动 

**==vg的效果是允许空发的，所以vgdpro的脚本大多不需要为效果注册Target函数（后面会提到）==**

### 如何给卡片注册效果
那既然现在知道了有哪些种类的效果，就可以开始介绍如何给卡片增加对应的效果了
比如我们这里要给某一张卡写一个效果
> 【自】：这个单位被RIDE时，你是后攻的话，抽1张卡。


```lua
--默认内容
local cm,m,o=GetID()
function cm.initial_effect(c)
	vgf.VgCard(c)
	--在这之后加入需要注册的效果
	local e1=Effect.CreateEffect(c)--创建一个效果
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)--效果的类型
    e1:SetCode(EVENT_BE_MATERIAL)--什么情况下会发动这个效果
    e1:SetProperty(EFFECT_FLAG_EVENT_PLAYER)--我也不懂这是干啥的
    e1:SetCondition(cm.condition)--效果的条件
    e1:SetOperation(cm.operation)--效果的具体内容
    c:RegisterEffect(e1)--把这个效果绑定到这张卡
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)--效果的具体内容
	Duel.Draw(tp,1,REASON_EFFECT)
end
function cm.condition(e,tp,eg,ep,ev,re,r,rp)--效果的条件
	return tp==1 and Duel.GetTurnPlayer()==tp
end
```
但是就如我们之前所说。我们使用自定义库涵括了大部分需要的内容，所以这个效果也可以直接简写成这样：
```lua
--默认内容
local cm,m,o=GetID()
function cm.initial_effect(c)
	vgf.VgCard(c)
	vgd.BeRidedByCard(c,m,nil,cm.operation,nil,cm.condition)--只要这一句就完成了上面7行的内容
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)--效果的具体内容
	Duel.Draw(tp,1,REASON_EFFECT)
end
function cm.condition(e,tp,eg,ep,ev,re,r,rp)--效果的条件
	return tp==1 and Duel.GetTurnPlayer()==tp
end
```
而函数里传入的e,tp,eg,ep,ev,re,r,rp分别是
- `e`:
- `tp`:当前回合玩家的编号()
## type、code、property都具体有啥

 那我怎么知道这些常量的具体意义呢？可以直接在编辑器里鼠标悬停在这些常量上查看所有常量
 ![image](https://i.postimg.cc/GmFVmkpB/Clip-2024-04-09-11-11-23.png)
 
## 目前所有的函数库
- VgD.SpellActivate(c,m,operation,condition,code,num1,num2,num3,num4,num5)
    - 因为魔合成的不向下兼容而生的函数，用于通常指令的注册，如效果：==通过【费用】[计数爆发1]施放！选择你的1个单位，这个回合中，力量+5000。选择你的弃牌区中的1张「瓦尔里纳」，加入手牌==
    - `c`:
    - `m`:
