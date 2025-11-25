--跳大绳丹
local tbTable = GameMain:GetMod("_ModifierScript");
local tbModifier = tbTable:GetModifier("modifier_tiaodasheng");

local BASE_POP = 100
local BASE_FAITH = 10000

--注意：自定义modidifer要注意离开的时候将自定义效果移除
--进入modifier
function tbModifier:Enter(modifier, npc)
  --神修吃了以后可以增加100信徒数量和10000信仰，可以受到幽淬的加成。
  npc.LuaHelper:AddGodPopulation(math.floor(BASE_POP * modifier.Scale))
  npc.LuaHelper:AddFaith(math.floor(BASE_FAITH * modifier.Scale))
end

--modifier step
function tbModifier:Step(modifier, npc, dt)

end

--层数更新
function tbModifier:UpdateStack(modifier, npc, add)
	
end

--离开modifier
function tbModifier:Leave(modifier, npc)
	
end

--获取存档数据
function tbModifier:OnGetSaveData()
	return nil;
end

--载入存档数据
function tbModifier:OnLoadData(modifier, npc, tbData)

end

