--白眼狼丹
local tbTable = GameMain:GetMod("_ModifierScript")
local tbModifier = tbTable:GetModifier("modifier_baiyanlang")
local ZhiYaoZhuo = GameMain:GetMod("ZhiYaoZhuo")


--注意：自定义modidifer要注意离开的时候将自定义效果移除
--进入modifier
function tbModifier:Enter(modifier, npc)
  local tbInfo = {
		KC = "Item",
		Line = {StartObj = npc},
		HeadMsg = "请选择要策反的白眼狼。。。啊不对，秘宝",
		Apply = 
			function(_, map, k, tbMode) 
				local t = tbMode:GetThing(g_emThingType.Item, k, map)
        if t.IsGodFabao then
          local owner = t:CheckSpecialFlag(CS.XiaWorld.g_emNpcSpecailFlag.GodFabaoOwnerID)
          local npc = CS.XiaWorld.ThingMgr.Instance:FindThingByID(owner)
          if npc then
            npc:RemoveSpecialFlag(CS.XiaWorld.g_emNpcSpecailFlag.GodFabaoID)
          end
          t:RemoveSpecialFlag(CS.XiaWorld.g_emNpcSpecailFlag.GodFabaoOwnerID)
        else
          t:BindItem2Npc(npc)
        end
			end,
		Check = 
			function(_, map, k, tbMode) 
				local t = tbMode:GetThing(g_emThingType.Item, k, map)
				return t.IsMiBao or t.IsGodFabao
			end,
	}

	world:EnterUILuaMode("TableCtrl", tbInfo)
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
	return nil
end

--载入存档数据
function tbModifier:OnLoadData(modifier, npc, tbData)

end

