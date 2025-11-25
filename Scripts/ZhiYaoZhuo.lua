--以下内容请不要修改。
local ZhiYaoZhuo = GameMain:NewMod("ZhiYaoZhuo")


function ZhiYaoZhuo:OnInit()
  --将NPC的灵气上限、法宝强度、术法强度全部改为100倍。
  local maxling = CS.XiaWorld.PropertyMgr.Instance:GetDef("NpcLingMaxValue")
  local fabaopower = CS.XiaWorld.PropertyMgr.Instance:GetDef("NpcFight_FabaoPowerAddP")
  local spellpower = CS.XiaWorld.PropertyMgr.Instance:GetDef("NpcFight_SpellPowerAddP")
  maxling.MaxValue = maxling.MaxValue * 100
  fabaopower.MaxValue = maxling.MaxValue * 100
  spellpower.MaxValue = maxling.MaxValue * 100
end

function ZhiYaoZhuo:OnEnter()
  --注册附魔物品的装脱事件。
  for mod, id in pairs(self.Events.FlagIDs) do
    local modif = GameMain:GetMod("_ModifierScript"):GetModifier(mod)
    if modif then modif:Register() end
    GameMain:GetMod("_Event"):RegisterEvent(CS.XiaWorld.g_emEvent.EquipUpdate, self.Events.FuMoEquip, {flagID = id, modifier = mod})
  end
  --注册灵气护盾事件。
  local barrier = GameMain:GetMod("_ModifierScript"):GetModifier("modifier_boss_barrier")
  barrier:Register()
end

function ZhiYaoZhuo:OnSetHotKey()

end

function ZhiYaoZhuo:OnHotKey(ID,state)

end

function ZhiYaoZhuo:OnStep(dt)

end

function ZhiYaoZhuo:OnLeave()
  --反注册灵气护盾事件。
  local barrier = GameMain:GetMod("_ModifierScript"):GetModifier("modifier_boss_barrier")
  barrier:Unregister()
end

function ZhiYaoZhuo:OnSave()

end

function ZhiYaoZhuo:OnLoad(tbLoad)

end

function ZhiYaoZhuo.GetPrivateField(obj, member_name)
  local member = obj:GetType():GetField(member_name, CS.System.Reflection.BindingFlags.NonPublic | CS.System.Reflection.BindingFlags.Instance)
  if member and obj then
    return member:GetValue(obj)
  else
    return nil
  end
end

function ZhiYaoZhuo.SetPrivateField(obj, member_name, value)
  local member = obj:GetType():GetField(member_name, CS.System.Reflection.BindingFlags.NonPublic | CS.System.Reflection.BindingFlags.Instance)
  if member and obj then
    member:SetValue(obj, value)
  end
end

function ZhiYaoZhuo.SetPrivateProperty(obj, member_name, value)
  local member = obj:GetType():GetProperty(member_name)
  if member and obj then
    member:SetValue(obj, value)
  end
end

function ZhiYaoZhuo.AddDrop(key, itemname, count, rate)
  if CS.XiaWorld.World.RandomRate(rate) then
    item = ItemRandomMachine.RandomItem(itemname, nil, 0, 12, 1, count)
    ThingMgr:AddThing(item)
    Map:DropItem(item, key)
  end
end

function ZhiYaoZhuo.StrengthenItem(item, t_type, t_parent, msg, name, desc)
  local tbInfo = {
		KC = "Item",
		Line = {StartObj = item},
		HeadMsg = msg,
		Apply =
      function (a, map, k, tbMode)
        local t = tbMode:GetThing(g_emThingType.Item, k, map)
        if t then
          world:SetFlag(t, ZhiYaoZhuo.Events.ItemIDs[item.def.Name], 1)
          t.Rate = 12
          t:SetName(name)
          t:SetDesc(desc)
          t:SetQuality(1)
          ThingMgr:RemoveThing(item, false, false)
        end
      end,
		Check = 
			function(_, map, k, tbMode)
				local t = tbMode:GetThing(g_emThingType.Item, k, map)
        if t_parent then
          return t.def.Parent == t_type
        else
          return t.def.Name == t_type
        end
			end,
	}
  world:EnterUILuaMode("TableCtrl", tbInfo)
end

function ZhiYaoZhuo.deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[ZhiYaoZhuo.deepcopy(orig_key)] = ZhiYaoZhuo.deepcopy(orig_value)
        end
        setmetatable(copy, ZhiYaoZhuo.deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end