local config = {
	{
		key = "infoBar",
		name = "��Ϣ��",
		class = "infoBar",
		banRemove = true,
		desc = "��ʾ�ȼ�����ҡ��������ء��������ء����硢ʱ�䡢��ء�������Ϣ",
		fixedX = display.cx,
		fixedY = display.height - 14.5
	},
	{
		key = "btnMode",
		name = "����ģʽ",
		class = "btnFixed",
		banRemove = true,
		fixedX = 18,
		z = 12,
		desc = "�л�����ģʽ",
		fixedY = display.height - 64
	},
	{
		key = "btnDiy",
		name = "����",
		class = "btnFixed",
		banRemove = true,
		fixedX = 18,
		z = 99,
		desc = "�򿪲������",
		fixedY = display.height - 139
	},
	{
		key = "btnPet",
		name = "����",
		class = "btnFixed",
		fixedX = 18,
		desc = "�л�������Ϣ������״̬",
		fixedY = display.height - 214
	},
	{
		key = "btnMap",
		name = "С��ͼ",
		class = "btnFixed",
		banRemove = true,
		desc = "��С��ͼ",
		fixedX = display.width - 17,
		fixedY = display.height - 64
	},
	{
		key = "btnExit",
		name = "�˳�",
		class = "btnFixed",
		banRemove = true,
		desc = "����ѡ���������",
		fixedX = display.width - 17,
		fixedY = display.height - 139
	},
	{
		key = "rocker",
		name = "˫ҡ��",
		class = "rocker",
		z = 5,
		desc = "������·/�ܲ�������ҡ��, Сҡ��Ϊ��, ��ҡ��Ϊ�ܡ�"
	},
	{
		key = "bottom",
		name = "�ײ���Ϣ",
		class = "bottom",
		banRemove = true,
		fixedY = 14,
		desc = "��ʾ��ͼ���ꡢ����ֵ��������",
		fixedX = display.cx
	},
	{
		btntype = "normal",
		key = "btnHide",
		class = "btnMove",
		name = "��ʾ/����",
		z = 12,
		desc = "��ʾ/���� ����������, ���ڹ���Զ�̹�"
	},
	{
		key = "hp",
		name = "Ѫ����Ϣ",
		class = "hp",
		banRemove = true,
		fixedY = 69,
		desc = "Ѫ��չʾ�Լ�Ѫ����ħ��ֵ����, ����ɴ�ѡ��������"
	},
	{
		key = "chat",
		name = "�����",
		class = "chat",
		desc = "���������, ��Ԥ����������Ϣ."
	},
	{
		btntype = "normal",
		key = "btnChat",
		class = "btnMove",
		name = "���찴ť",
		desc = "�������"
	},
	{
		btntype = "normal",
		key = "btnVoice",
		class = "btnMove",
		name = "����",
		desc = "���������ť, ��ס˵��!"
	},
	{
		btntype = "normal",
		key = "btnVoiceJIT",
		class = "btnMove",
		name = "ʵʱ����",
		desc = "ʵʱ�������ư�ť, ָ��ģʽ������/����, ����ģʽ�°�ס˵��"
	},
	{
		btntype = "normal",
		key = "btnGroup",
		class = "btnMove",
		name = "�������",
		desc = "������ӡ�"
	},
	{
		key = "lock",
		name = "������",
		class = "lock",
		banRemove = true,
		fixedX = 21,
		desc = "����/����/���ܵĿ��ؿ�����."
	},
	{
		btntype = "base",
		key = "btnAttack",
		class = "btnMove",
		name = "��ͨ����",
		btnid = "attack",
		desc = "�Զ�������Ļ�ڵĹ��"
	},
	{
		btntype = "normal",
		key = "btnAutoRat",
		class = "btnMove",
		name = "�һ�",
		desc = "�Զ�������Ұ��Χ�ڵĹ��'���ã�����'ҳ������ùһ���Ϊ���һ�������ʹ��ҡ�˽��Զ�ֹͣ�һ�"
	},
	{
		btntype = "base",
		key = "btnBackHome",
		class = "btnMove",
		name = "�س�",
		btnid = "back",
		desc = "�ص���������ĳ���"
	},
	{
		btntype = "base",
		key = "btnLock",
		class = "btnMove",
		name = "�Զ�����",
		btnid = "lock",
		desc = "�Զ�������Ļ�ڵ�������"
	},
	{
		btntype = "base",
		key = "btnShift",
		class = "btnMove",
		name = "ǿ�ƹ���",
		btnid = "shift",
		desc = "ǿ����������Ļ�ķ��򹥻�"
	},
	{
		btntype = "base",
		key = "btnWa",
		class = "btnMove",
		name = "��ȡ",
		btnid = "wa",
		desc = "�����������ڶ���"
	},
	{
		btntype = "setting",
		key = "btnFullname",
		class = "btnMove",
		name = "ȫ������",
		btnid = "allName",
		desc = "��ʾ��Ļ�ϵ������������"
	},
	{
		btntype = "setting",
		key = "btnOnlyname",
		class = "btnMove",
		name = "��ȡ",
		btnid = "onlyName",
		desc = "ֻ��ʾ��Ļ�����������, �����лᡢ���"
	},
	{
		btntype = "setting",
		key = "btnSoundEnable",
		class = "btnMove",
		name = "��Ч",
		btnid = "sound",
		desc = "��/�ر� ��Ϸ��Ч"
	},
	{
		btntype = "setting",
		key = "btnTouchRun",
		class = "btnMove",
		name = "�����ܲ�",
		btnid = "touchRun",
		desc = "�����ڵ���Ļ���ܲ�������·."
	},
	{
		btntype = "setting",
		key = "btnAutoAllSpace",
		class = "btnMove",
		job = 0,
		btnid = "autoAllSpace",
		name = "������ɱ",
		desc = "������ɱ, ������սʿ��Ч��"
	},
	{
		btntype = "setting",
		key = "btnAutoSpace",
		class = "btnMove",
		job = 0,
		btnid = "autoSpace",
		name = "��λ��ɱ",
		desc = "�Զ���λ��ɱ, ������սʿ��Ч��"
	},
	{
		btntype = "setting",
		key = "btnAutoWide",
		class = "btnMove",
		job = 0,
		btnid = "autoWide",
		name = "���ܰ���",
		desc = "�Զ�����/�رհ����䵶, ������սʿ��Ч��"
	},
	{
		btntype = "setting",
		key = "btnAutoFire",
		class = "btnMove",
		job = 0,
		btnid = "autoFire",
		name = "�Զ��һ�",
		desc = "�Զ��һ�, ������սʿ��Ч��"
	},
	{
		btntype = "setting",
		key = "btnAutoDun",
		class = "btnMove",
		job = 1,
		btnid = "autoDun",
		name = "�Զ�ħ����",
		desc = "�Զ�ħ����,  �����ڷ�ʦ��Ч��"
	},
	{
		btntype = "setting",
		key = "btnAutoInvisible",
		class = "btnMove",
		job = 2,
		btnid = "autoInvisible",
		name = "�Զ�����",
		desc = "�Զ�����, �����ڵ�ʿ��Ч��"
	},
	{
		btntype = "setting",
		key = "btnAutoSkill",
		class = "btnMove",
		name = "�Զ�����",
		btnid = "autoSkill",
		desc = "��/�ر� �Զ�����"
	},
	{
		btntype = "panel",
		key = "btnPanelBag",
		class = "btnMove",
		name = "����",
		btnid = "bag",
		desc = "�򿪱������"
	},
	{
		btntype = "panel",
		key = "btnPanelEquip",
		class = "btnMove",
		name = "װ��",
		btnid = "equip",
		desc = "��װ�����"
	},
	{
		btntype = "panel",
		key = "btnPanelSkill",
		class = "btnMove",
		name = "����",
		btnid = "skill",
		desc = "�򿪼������"
	},
	{
		btntype = "panel",
		key = "btnPanelDeal",
		class = "btnMove",
		name = "����",
		btnid = "deal",
		desc = "ʵʱ��ҽ���"
	},
	{
		btntype = "panel",
		key = "btnPanelGroup",
		class = "btnMove",
		name = "���",
		btnid = "group",
		desc = "��������"
	},
	{
		btntype = "panel",
		key = "btnPanelFriend",
		class = "btnMove",
		name = "����",
		btnid = "relation",
		desc = "�򿪺������"
	},
	{
		btntype = "panel",
		key = "btnPanelGuild",
		class = "btnMove",
		name = "�л�",
		btnid = "guild",
		desc = "���л����"
	},
	{
		btntype = "panel",
		key = "btnPanelTop",
		class = "btnMove",
		name = "����",
		btnid = "top",
		desc = "���������"
	},
	{
		btntype = "panel",
		key = "btnPanelShop",
		class = "btnMove",
		name = "�̳�",
		btnid = "shop",
		desc = "���̳����"
	},
	{
		btntype = "panel",
		key = "btnPanelStall",
		class = "btnMove",
		name = "��̯",
		btnid = "stall",
		desc = "�򿪰�̯���"
	},
	{
		btntype = "panel",
		key = "btnPanelMail",
		class = "btnMove",
		name = "�ʼ�",
		btnid = "mail",
		desc = "���ʼ����"
	},
	{
		btntype = "panel",
		key = "btnPanelSetting",
		class = "btnMove",
		name = "����",
		btnid = "setting",
		desc = "���������"
	},
	{
		btntype = "prop",
		key = "btnPropHongyao",
		class = "btnMove",
		name = "��ҩ",
		btnid = "hongyao",
		desc = "��ݵ���ʹ�ð�ť, ֧��: ��ҩ(С��), ��ҩ(����), ǿЧ��ҩ",
		use = {
			"��ҩ(С��)",
			"��ҩ����(��)",
			"��ҩ(����)",
			"ǿЧ��ҩ(��)",
			"ǿЧ��ҩ"
		}
	},
	{
		btntype = "prop",
		key = "btnPropLanyao",
		class = "btnMove",
		name = "��ҩ",
		btnid = "lanyao",
		desc = "��ݵ���ʹ�ð�ť, ֧��: ħ��ҩ(С��), ħ��ҩ(����), ǿЧħ��ҩ",
		use = {
			"ħ��ҩ(С��)",
			"ħ��ҩ����(��)",
			"ħ��ҩ(����)",
			"ǿЧħ��ҩ(��)",
			"ǿЧħ��ҩ"
		}
	},
	{
		btntype = "prop",
		key = "btnPropShunhui",
		class = "btnMove",
		name = "˲��ҩƷ",
		btnid = "shunhui",
		desc = "��ݵ���ʹ�ð�ť, ֧��: ̫��ˮ, ǿЧ̫��ˮ, ����ѩ˪, ����ҩ",
		use = {
			"̫��ˮ",
			"ǿЧ̫��ˮ",
			"����ѩ˪",
			"����ҩ"
		}
	},
	{
		btntype = "prop",
		key = "btnPropSuiji",
		class = "btnMove",
		name = "������;�",
		btnid = "suiji",
		desc = "��ݵ���ʹ�ð�ť, ֧��: ������;�",
		use = {
			"������;�"
		}
	},
	{
		btntype = "prop",
		key = "btnPropDilao",
		class = "btnMove",
		name = "�������Ѿ�",
		btnid = "dilao",
		desc = "��ݵ���ʹ�ð�ť, ֧��: �������Ѿ�",
		use = {
			"�������Ѿ�"
		}
	},
	{
		btntype = "prop",
		key = "btnPropHuicheng",
		class = "btnMove",
		name = "�سǾ�",
		btnid = "huicheng",
		desc = "��ݵ���ʹ�ð�ť, ֧��: �سǾ�",
		use = {
			"�سǾ�"
		}
	},
	{
		btntype = "prop",
		key = "btnPropHanghui",
		class = "btnMove",
		name = "�л�سǾ�",
		btnid = "hanghui",
		desc = "��ݵ���ʹ�ð�ť, ֧��: �л�سǾ�",
		use = {
			"�л�سǾ�"
		}
	},
	{
		btntype = "prop",
		key = "btnPropZhufuyou",
		class = "btnMove",
		name = "ף����",
		btnid = "zhufuyou",
		desc = "��ݵ���ʹ�ð�ť, ֧��: ף����",
		use = {
			"ף����"
		}
	},
	{
		btntype = "prop",
		key = "btnPropMengzhong",
		class = "btnMove",
		name = "���ش���ʯ",
		btnid = "mengzhong",
		desc = "��ݵ���ʹ�ð�ť, ֧��: ���ش���ʯ",
		use = {
			"���ش���ʯ(��)",
			"���ش���ʯ"
		}
	},
	{
		btntype = "prop",
		key = "btnPropBiqi",
		class = "btnMove",
		name = "���洫��ʯ",
		btnid = "biqi",
		desc = "��ݵ���ʹ�ð�ť, ֧��: ���洫��ʯ",
		use = {
			"���洫��ʯ(��)",
			"���洫��ʯ"
		}
	},
	{
		btntype = "prop",
		key = "btnPropSuijishi",
		class = "btnMove",
		name = "�������ʯ",
		btnid = "suijishi",
		desc = "��ݵ���ʹ�ð�ť, ֧��: �������ʯ",
		use = {
			"�������ʯ"
		}
	},
	{
		btntype = "cmd",
		key = "btnCmdChuansong",
		class = "btnMove",
		name = "@����",
		btnid = "chuansong",
		desc = "���Ϳ���"
	},
	{
		btntype = "cmd",
		key = "btnCmdQianlichuanyin",
		class = "btnMove",
		name = "@ǧ�ﴫ��",
		btnid = "qianlichuanyin",
		desc = "ǧ�ﴫ������"
	},
	{
		btntype = "cmd",
		key = "btnCmdShuaxinbeibao",
		class = "btnMove",
		name = "@ˢ�±���",
		btnid = "shuaxinbeibao",
		desc = "ˢ�±�������"
	},
	{
		btntype = "cmd",
		key = "btnCmdJujuesiliao",
		class = "btnMove",
		name = "@�ܾ�˽��",
		btnid = "jujuesiliao",
		desc = "�ܾ�˽�Ŀ���"
	},
	{
		btntype = "cmd",
		key = "btnCmdJinzhijiaoyi",
		class = "btnMove",
		name = "@��ֹ����",
		btnid = "jinzhijiaoyi",
		desc = "��ֹ���׿���"
	},
	{
		btntype = "cmd",
		key = "btnCmdShituchuansong",
		class = "btnMove",
		name = "@ʦͽ����",
		btnid = "shituchuansong",
		desc = "ʦͽ���Ϳ���"
	},
	{
		btntype = "cmd",
		key = "btnCmdFuqichuansong",
		class = "btnMove",
		name = "@���޴���",
		btnid = "fuqichuansong",
		desc = "���޴��Ϳ���"
	},
	{
		btntype = "skill",
		key = "btnSkillTemp",
		class = "btnMove",
		name = "����"
	},
	{
		btntype = "hero",
		key = "btnHeroCall",
		class = "btnMove",
		name = "�ٻ�Ӣ��",
		btnid = "call",
		desc = "�ٻ�һ��Ӣ��"
	},
	{
		btntype = "hero",
		key = "btnHeroBag",
		class = "btnMove",
		name = "Ӣ�۱���",
		btnid = "bag",
		desc = "��/�ر�Ӣ�۱���"
	},
	{
		btntype = "hero",
		key = "btnHeroEquip",
		class = "btnMove",
		name = "״̬",
		btnid = "equip",
		desc = "��Ӣ��״̬��Ϣ"
	},
	{
		btntype = "hero",
		key = "btnHeroSkill",
		class = "btnMove",
		name = "�ϻ�",
		btnid = "skill",
		desc = "�ͷźϻ�����"
	},
	{
		btntype = "hero",
		key = "btnHeroMode",
		class = "btnMove",
		name = "ģʽ",
		btnid = "mode",
		desc = "�л�Ӣ��ģʽ"
	},
	{
		btntype = "hero",
		key = "btnHeroGuard",
		class = "btnMove",
		name = "Ӣ���ػ�",
		btnid = "guard",
		desc = "Ӣ���ػ���һ�����������ڴ��"
	},
	{
		btntype = "hero",
		key = "btnHeroLock",
		class = "btnMove",
		name = "Ӣ������",
		btnid = "lock",
		desc = "Ӣ������һ��Ŀ��"
	},
	{
		btntype = "custom",
		key = "btnCustom1",
		class = "btnMove",
		name = "",
		id = 1,
		btnid = "btnCustom1",
		desc = ""
	},
	{
		btntype = "custom",
		key = "btnCustom2",
		class = "btnMove",
		name = "",
		id = 2,
		btnid = "btnCustom2",
		desc = ""
	},
	{
		btntype = "custom",
		key = "btnCustom3",
		class = "btnMove",
		name = "",
		id = 3,
		btnid = "btnCustom3",
		desc = ""
	},
	{
		btntype = "custom",
		key = "btnCustom4",
		class = "btnMove",
		name = "",
		id = 4,
		btnid = "btnCustom4",
		desc = ""
	},
	{
		btntype = "custom",
		key = "btnCustom5",
		class = "btnMove",
		name = "",
		id = 5,
		btnid = "btnCustom5",
		desc = ""
	},
	{
		btntype = "custom",
		key = "btnCustom6",
		class = "btnMove",
		name = "",
		id = 6,
		btnid = "btnCustom6",
		desc = ""
	}
}

if VERSION_REVIEW then
	for i = #config, 1, -1 do
		if checkExist(config[i].key, "btnAutoRat", "btnHelper", "btnGroup", "btnPanelStall", "btnPanelMail") then
			table.remove(config, i)
		end
	end
end

local default = {
	{
		key = "infoBar"
	},
	{
		key = "btnMode"
	},
	{
		key = "btnPet"
	},
	{
		key = "btnDiy"
	},
	{
		key = "btnMap"
	},
	{
		key = "btnExit"
	},
	{
		key = "rocker",
		x = 150,
		y = 150
	},
	{
		key = "bottom"
	},
	{
		key = "hp",
		x = display.cx - 185
	},
	{
		y = 85,
		key = "chat",
		x = display.cx + 60
	},
	{
		y = 144,
		key = "btnChat",
		x = display.cx - 110
	},
	{
		key = "lock",
		y = 310
	},
	{
		y = 180,
		key = "btnPanelEquip",
		x = display.cx + 60 - 120
	},
	{
		y = 180,
		key = "btnPanelBag",
		x = display.cx + 60 - 40
	},
	{
		y = 180,
		key = "btnPanelSkill",
		x = display.cx + 60 + 40
	},
	{
		y = 180,
		key = "btnBackHome",
		x = display.cx + 60 + 120
	},
	{
		key = "btnAttack",
		btnpos = "1-1"
	},
	{
		key = "btnLock",
		btnpos = "1-2"
	},
	{
		key = "btnShift",
		btnpos = "1-3"
	},
	{
		key = "btnPropHongyao",
		btnpos = "2-1"
	},
	{
		key = "btnPropLanyao",
		btnpos = "2-2"
	},
	{
		key = "btnPropShunhui",
		btnpos = "2-3"
	}
}
local default_pc = {
	{
		y = 200,
		key = "btnCustom1",
		x = display.cx + 50 - 150
	},
	{
		y = 200,
		key = "btnCustom2",
		x = display.cx + 50 - 90
	},
	{
		y = 200,
		key = "btnCustom3",
		x = display.cx + 50 - 30
	},
	{
		y = 200,
		key = "btnCustom4",
		x = display.cx + 50 + 30
	},
	{
		y = 200,
		key = "btnCustom5",
		x = display.cx + 50 + 90
	},
	{
		y = 200,
		key = "btnCustom6",
		x = display.cx + 50 + 150
	}
}

local function getData(key)
	for i, v in ipairs(default) do
		if v.key == key then
			return v
		end
	end
end

local function getConfig(data)
	local key = data.key2 or data.key

	for i, v in ipairs(config) do
		if v.key == key then
			return v
		end
	end
end

return {
	config = config,
	default = default,
	getData = getData,
	getConfig = getConfig,
	default_pc = default_pc
}
