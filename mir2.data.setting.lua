local setting = {
	base = {
		touchRun = true,
		guild = false,
		firePeral = false,
		lockColor = true,
		showNameOnly = false,
		showExpValue = 20000,
		autoUnpack = true,
		showExpEnable = false,
		soundEnable = true,
		hiBlood = false,
		showOutHP = false,
		levelShow = true,
		heroShowName = true,
		hideCorpse = false,
		NPCShowName = true,
		petShowName = true,
		monShowName = true,
		quickexit = false,
		warningDura = true
	},
	protected = {
		role = {
			hp = {
				isPercent = false,
				space = 10000,
				value = 0,
				uses = "������;�",
				lastTime = 0,
				enable = false
			},
			mp = {
				isPercent = false,
				space = 10000,
				value = 0,
				uses = "������;�",
				lastTime = 0,
				enable = false
			},
			jiu = {
				value = 10,
				space = 500,
				isPercent = true,
				lastTime = 0,
				enable = false
			},
			yaojiu = {
				value = 10,
				space = 9000,
				isPercent = false,
				lastTime = 0,
				enable = false
			}
		},
		hero = {
			hp = {
				isPercent = false,
				space = 10000,
				value = 0,
				uses = "������;�",
				lastTime = 0,
				enable = false
			},
			mp = {
				isPercent = false,
				space = 10000,
				value = 0,
				uses = "������;�",
				lastTime = 0,
				enable = false
			},
			jiu = {
				value = 10,
				space = 500,
				isPercent = true,
				lastTime = 0,
				enable = false
			},
			yaojiu = {
				value = 10,
				space = 9000,
				isPercent = false,
				lastTime = 0,
				enable = false
			},
			miss = {
				value = 40,
				space = 9000,
				isPercent = false,
				lastTime = 0,
				enable = true
			}
		}
	},
	drugs = {
		roleSetting = {
			withNumber = false,
			withPercent = true
		},
		heroSetting = {
			withNumber = false,
			withPercent = true
		},
		role = {
			percentDrug = {
				normalHP = {
					lastTime = 0,
					space = 2000,
					isPercent = true,
					value = 0.75,
					enable = true
				},
				normalMP = {
					lastTime = 0,
					space = 2000,
					isPercent = true,
					value = 0.75,
					enable = true
				},
				quickHP = {
					lastTime = 0,
					space = 500,
					isPercent = true,
					value = 0.5,
					enable = true
				},
				quickMP = {
					lastTime = 0,
					space = 500,
					isPercent = true,
					value = 0.25,
					enable = true
				}
			},
			numberDrug = {
				normalHP = {
					value = 10,
					space = 4000,
					lastTime = 0,
					enable = false
				},
				normalMP = {
					value = 10,
					space = 4000,
					lastTime = 0,
					enable = false
				},
				quickHP = {
					value = 10,
					space = 4000,
					lastTime = 0,
					enable = false
				},
				quickMP = {
					value = 10,
					space = 4000,
					lastTime = 0,
					enable = false
				}
			}
		},
		hero = {
			percentDrug = {
				normalHP = {
					lastTime = 0,
					space = 500,
					isPercent = true,
					value = 0.75,
					enable = true
				},
				normalMP = {
					lastTime = 0,
					space = 500,
					isPercent = true,
					value = 0.75,
					enable = true
				},
				quickHP = {
					lastTime = 0,
					space = 500,
					isPercent = true,
					value = 0.5,
					enable = true
				},
				quickMP = {
					lastTime = 0,
					space = 500,
					isPercent = true,
					value = 0.25,
					enable = true
				}
			},
			numberDrug = {
				normalHP = {
					value = 10,
					space = 4000,
					lastTime = 0,
					enable = false
				},
				normalMP = {
					value = 10,
					space = 4000,
					lastTime = 0,
					enable = false
				},
				quickHP = {
					value = 10,
					space = 4000,
					lastTime = 0,
					enable = false
				},
				quickMP = {
					value = 10,
					space = 4000,
					lastTime = 0,
					enable = false
				}
			}
		}
	},
	autoUnpack = {
		newbee = {
			pack = "���ֽ�ҩ��",
			name = "���ֽ�ҩ",
			min = 0,
			enable = true
		},
		hpMid = {
			pack = "��ҩ���У���",
			name = "��ҩ(����)",
			min = 0,
			enable = true
		},
		hpSmall = {
			pack = "��ҩ(С)��",
			name = "��ҩ(С��)",
			min = 0,
			enable = true
		},
		hpMid = {
			pack = "��ҩ(��)��",
			name = "��ҩ(����)",
			min = 0,
			enable = true
		},
		hpBig = {
			pack = "������ҩ",
			name = "ǿЧ��ҩ",
			min = 0,
			enable = true
		},
		hpMidz = {
			pack = "��ҩ�а�(��)",
			name = "��ҩ����(��)",
			min = 0,
			enable = true
		},
		hpBigz = {
			pack = "������ҩ(��)",
			name = "ǿЧ��ҩ(��)",
			min = 0,
			enable = true
		},
		mpSmall = {
			pack = "ħ��ҩ(С)��",
			name = "ħ��ҩ(С��)",
			min = 0,
			enable = true
		},
		mpMid = {
			pack = "ħ��ҩ(��)��",
			name = "ħ��ҩ(����)",
			min = 0,
			enable = true
		},
		mpBig = {
			pack = "����ħ��ҩ",
			name = "ǿЧħ��ҩ",
			min = 0,
			enable = true
		},
		mpMidz = {
			pack = "ħ��ҩ�а�(��)",
			name = "ħ��ҩ����(��)",
			min = 0,
			enable = true
		},
		mpBigz = {
			pack = "����ħ��ҩ(��)",
			name = "ǿЧħ��ҩ(��)",
			min = 0,
			enable = true
		},
		quick1 = {
			pack = "ǿЧ̫����",
			name = "ǿЧ̫��ˮ",
			min = 0,
			enable = true
		},
		quick2 = {
			pack = "ѩ˪��",
			name = "����ѩ˪",
			min = 0,
			enable = true
		},
		quick3 = {
			pack = "����ҩ��",
			name = "����ҩ",
			min = 0,
			enable = true
		},
		quick4 = {
			pack = "����ҩ��(����)",
			name = "����ҩ(����)",
			min = 0,
			enable = true
		},
		reel1 = {
			pack = "������;��",
			name = "������;�",
			min = 0,
			enable = true
		},
		reel2 = {
			pack = "�������Ѿ��",
			name = "�������Ѿ�",
			min = 0,
			enable = true
		},
		reel3 = {
			pack = "�سǾ��",
			name = "�سǾ�",
			min = 0,
			enable = true
		},
		reel4 = {
			pack = "�л�سǾ��",
			name = "�л�سǾ�",
			min = 0,
			enable = true
		}
	},
	job = {
		autoDun = false,
		autoFire = false,
		autoZhanjiashu = false,
		autoAllSpace = false,
		autoSword = false,
		autoWide = true,
		autoInvisible = false,
		autoSpace = false,
		autoDunHero = false,
		autoYoulingDun = false,
		autoSkill = {
			enable = false,
			space = 10
		}
	},
	autoRat = {
		noPickUpItem = false,
		autoPoison = false,
		pickUpRatting = true,
		ignoreCripple = true,
		autoSpaceMove = {
			space = 10,
			use = "������;�",
			enable = false
		},
		autoRoar = {
			space = 10,
			cnt = 5,
			enable = false
		},
		atkMagic = {},
		areaMagic = {
			cnt = 5,
			enable = false
		},
		autoPet = {
			enable = false
		},
		autoCure = {
			percent = 70,
			enable = false
		},
		autoCurePet = {
			percent = 60,
			enable = false
		}
	},
	display = {
		showHeroOutHP = false,
		showMonOutHP = true,
		mapScale = 1.5
	},
	cpu = {
		speedMode = false,
		loadMons = false,
		normalFont = false
	},
	help = {
		count = 7,
		looked = 0
	},
	chat = {
		alwaysTranslate = false,
		whisperLimit = 1,
		opens = {
			["���"] = true,
			["ս��"] = true
		},
		autoLoadVoice = {
			enable = false
		},
		autoPlayVoice = {
			["˽��"] = false,
			["���"] = false,
			["����"] = false,
			["ս��"] = false,
			["�л�"] = false,
			["����"] = false
		}
	},
	item = {
		pickUp = false,
		hindGood = false,
		showName = true,
		pickOnRatting = false,
		filt = {}
	},
	other = {
		buyNotTip = false
	}
}

function setting.initEnd()
	sound.setEnable(setting.base.soundEnable)

	an.label.normal = setting.cpu.normalFont
	local filt = setting.item.filt

	if not filt["��Ʒ���Ե���"] then
		filt["��Ʒ���Ե���"] = {
			hintName = true,
			pickUp = true,
			isGood = true,
			pickOnRatting = true
		}
	end

	setmetatable(filt, {
		__index = _G.def.items.filt
	})
end

function setting.getGoodAttItemSetting()
	return setting.item.filt["��Ʒ���Ե���"]
end

function setting.resetItemFilt()
	setting.item.filt = {}

	setmetatable(setting.item.filt, {
		__index = _G.def.items.filt
	})
end

local default = clone(setting)

function setting.reset()
	for k, v in pairs(default) do
		setting[k] = clone(v)
	end

	setting.initEnd()
end

function setting.init(playerName)
	setting.reset()

	for k, v in pairs(setting) do
		local saved = cache.getSetting(playerName, k)

		if saved then
			for k2, v2 in pairs(saved) do
				v[k2] = v2
			end
		end
	end

	setting.initEnd()
end

return setting
