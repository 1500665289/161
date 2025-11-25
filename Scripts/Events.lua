local ZhiYaoZhuo = GameMain:NewMod("ZhiYaoZhuo")
ZhiYaoZhuo.Events = ZhiYaoZhuo.Events or {}
local Events = ZhiYaoZhuo.Events

Events.ItemIDs = {
  Item_CangLongHanXing = 8826,
  Item_ZhenHuangChiYan = 8827,
}

Events.FlagIDs = {
  Modifier_CangLongHanXing = 8826,
  Modifier_ZhenHuangChiYan = 8827,
}

function Events.FuMoEquip(data, thing, objs)
  local equip_item = objs[0]
  local equip_type = objs[1]
  local num = world:GetFlag(equip_item, data.flagID)
  if num ~= 0 then
    if equip_type == 1 then --装备事件
      thing:AddModifier(data.modifier, num)
    elseif equip_type == 3 then --脱下事件
      thing:RemoveModifier(data.modifier)
    end
  end
end