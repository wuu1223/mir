local zArr = {
	19,
	24,
	30,
	37,
	44,
	52,
	60,
	69,
	79,
	89,
	100,
	111,
	123,
	136,
	149,
	163,
	177,
	192,
	208,
	224,
	241,
	258,
	276,
	295,
	314,
	334,
	354,
	375,
	397,
	419,
	442,
	465,
	489,
	514,
	539,
	565,
	591,
	618,
	646,
	674,
	703,
	732,
	762,
	793,
	824,
	856,
	888,
	921,
	955,
	989,
	1024,
	1059,
	1095,
	1132,
	1169,
	1207,
	1245,
	1284,
	1324,
	1364,
	1405,
	1446,
	1488,
	1531,
	1574,
	1618,
	1662,
	1707,
	1753,
	1799,
	1846,
	1893,
	1941,
	1990,
	2039,
	2089,
	2139,
	2190,
	2242,
	2294,
	2347,
	2400,
	2454,
	2509,
	2564,
	2620,
	2676,
	2733,
	2791,
	2849,
	2908,
	2967,
	3027,
	3088,
	3149,
	3211,
	3273,
	3336,
	3400,
	3464
}
local dArr = {
	17,
	20,
	23,
	27,
	31,
	35,
	40,
	45,
	50,
	56,
	62,
	68,
	75,
	82,
	89,
	97,
	105,
	113,
	122,
	131,
	140,
	150,
	160,
	170,
	181,
	192,
	203,
	215,
	227,
	239,
	252,
	265,
	278,
	292,
	306,
	320,
	335,
	350,
	365,
	381,
	397,
	413,
	430,
	447,
	464,
	482,
	500,
	518,
	537,
	556,
	575,
	595,
	615,
	635,
	656,
	677,
	698,
	720,
	742,
	764,
	787,
	810,
	833,
	857,
	881,
	905,
	930,
	955,
	950,
	1006,
	1032,
	1058,
	1085,
	1112,
	1139,
	1167,
	1195,
	1223,
	1252,
	1281,
	1310,
	1370,
	1400,
	1431,
	1462,
	1493,
	1525,
	1557,
	1589,
	1622,
	1655,
	1688,
	1722,
	1756,
	1790,
	1825,
	1860,
	1860,
	1895,
	1931
}
local fArr = {
	16,
	18,
	20,
	22,
	24,
	27,
	30,
	33,
	36,
	39,
	42,
	45,
	48,
	52,
	56,
	60,
	64,
	68,
	72,
	77,
	81,
	86,
	91,
	96,
	101,
	106,
	111,
	117,
	122,
	128,
	134,
	140,
	146,
	152,
	159,
	165,
	172,
	179,
	186,
	193,
	200,
	207,
	215,
	222,
	230,
	238,
	246,
	254,
	262,
	271,
	279,
	288,
	297,
	306,
	315,
	324,
	333,
	343,
	352,
	362,
	372,
	382,
	392,
	402,
	413,
	423,
	434,
	445,
	456,
	467,
	478,
	489,
	501,
	512,
	524,
	536,
	548,
	560,
	572,
	585,
	597,
	610,
	623,
	636,
	649,
	662,
	675,
	689,
	702,
	716,
	730,
	744,
	758,
	772,
	787,
	801,
	816,
	831,
	846,
	861
}
local z = {}
local d = {}
local f = {}

for i, v in ipairs(zArr) do
	z[v] = "Z" .. i
end

for i, v in ipairs(dArr) do
	d[v] = "D" .. i
end

for i, v in ipairs(fArr) do
	f[v] = "M" .. i
end

fArr = nil
dArr = nil
zArr = nil
local jobs = {
	z,
	f,
	d
}
local def = {
	hp2level = function (hp, job)
		hp = tonumber(hp)

		if job then
			return (jobs[job + 1] or {})[hp] or "?"
		else
			local zstr = z[hp]
			local dstr = d[hp]
			local fstr = f[hp]
			local ret = ""

			if zstr then
				ret = ret .. zstr
			end

			if dstr then
				if zstr then
					ret = ret .. "/"
				end

				ret = ret .. dstr
			end

			if fstr then
				if dstr or zstr then
					ret = ret .. "/"
				end

				ret = ret .. fstr
			end

			if ret == "" then
				ret = "?"
			end

			return ret
		end
	end
}

return def
