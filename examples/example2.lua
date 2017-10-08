
--[[
  find max of 5 elements
]]

local genann = require 'genann'

-- 5 inputs
-- 1 hidden layer with 5 nodes
-- 5 outputs
local ann = genann.init(5,1,5,5)

-- return table with 1 at max, otherwise 0
local function one_at_max(i)
  local o = {0,0,0,0,0}
  local maxi = 1
  for c=1,#i do
    if i[c] > i[maxi] then maxi = c end
  end
  o[maxi] = 1
  return o
end

local inp = {}
local outp = {}

for _=1,100 do -- generate learning data
  local i = {}
  for _ = 1,5 do
    table.insert(i,math.random() * math.random(-100,100))
  end
  table.insert(inp,i)
  table.insert(outp,one_at_max(i))
end

local inputs = genann.trans(inp) -- transform inputs
local outputs = genann.trans(outp) -- transform outputs

genann.workout(ann,inputs,outputs,500,0.1) -- teach

local function rap_pair(nn,i) -- run and print
  local o = one_at_max(genann.run(nn,i)) -- output max
  local r = one_at_max(i) -- correct max
  print('R O Input')
  print(string.format('%d %d %f',r[1],o[1],i[1]))
  print(string.format('%d %d %f',r[2],o[2],i[2]))
  print(string.format('%d %d %f',r[3],o[3],i[3]))
  print(string.format('%d %d %f',r[4],o[4],i[4]))
  print(string.format('%d %d %f',r[5],o[5],i[5]))
  print('---------------')
end


for _=1,3 do -- examples
  local i = {}
  for _ = 1,5 do
    table.insert(i,math.random() * math.random(-100,100))
  end
  rap_pair(ann,i)
end
