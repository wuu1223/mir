local tip = class("centerTopTip", function ()
	return display.newNode()
end)

table.merge(tip, {
	configs,
	curNode
})

function tip:ctor()
	self.configs = {
		resumePos = {
			"�ǲ��ǿ�λ�ˣ�",
			"�ָ�ԭλ",
			def.cmds.custom["��λ�ָ�"]
		},
		relive = {
			"�Ƿ��������",
			"�سǸ���",
			def.cmds.custom["�سǸ���"]
		}
	}
	self.curNode = nil
end

function tip:show(type)
	local config = self.configs[type]

	if not config then
		return
	end

	if self.curNode then
		self.curNode:removeSelf()

		self.curNode = nil
	end

	local reliveBtn = an.newBtn(res.gettex2("pic/common/relive0.png"), function ()
		sound.playSound("103")
		net.send({
			CM_SAY
		}, {
			config[3]
		})
		self.curNode:removeSelf()

		self.curNode = nil
	end, {
		pressImage = res.gettex2("pic/common/relive1.png")
	}):anchor(0, 0)
	self.curNode = display.newNode():size(reliveBtn:getw(), reliveBtn:geth()):anchor(0.5, 0.5):opacity(0):add2(self)
	local ntime = 180
	local timeLabel = nil
	timeLabel = an.newLabel("180�����������Ͽ�����", 20, 1, {
		color = cc.c3b(0, 255, 0)
	}):anchor(0.5, 0.5):pos(self.curNode:getw() * 0.5, -10):opacity(0):add2(self.curNode):run(cc.RepeatForever:create(transition.sequence({
		cc.DelayTime:create(5),
		cc.CallFunc:create(function ()
			ntime = ntime - 5

			if ntime <= 0 then
				self.curNode:removeSelf()

				self.curNode = nil
			else
				timeLabel:setString(ntime .. "�����������Ͽ�����")
			end
		end)
	})))

	self.curNode:pos(display.cx, display.height - 120)
	self.curNode:moveTo(0.3, display.cx, display.height - 80)
end

return tip
