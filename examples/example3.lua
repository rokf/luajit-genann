
local genann = require 'genann'
local serpent = require 'serpent'

local function dump(t)
  print(serpent.line(t,{comment=false}))
end

local ann = genann.init(2,1,2,1)

local function leaky(x)
  if x >= 0 then return x end
  return 0.01 * x
end

local function threshold(x)
  if x > 0 then return 1 else return 0 end
end

local function linear(x)
  return x
end

local function sigmoid(x)
  return 1 / (1 + math.exp(-x))
end

ann.activation_hidden = sigmoid
ann.activation_output = sigmoid

local inputs = genann.trans({
  {0,0},
  {0,1},
  {1,0},
  {1,1}
})

local outputs = genann.trans({
  {0},
  {1},
  {1},
  {0}
})

genann.workout(ann,inputs,outputs,5000,3)

dump(genann.run(ann,{0,0}))
dump(genann.run(ann,{0,1}))
dump(genann.run(ann,{1,0}))
dump(genann.run(ann,{1,1}))

genann.free(ann)
