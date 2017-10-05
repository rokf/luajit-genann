
local genann = require 'genann'

local ann = genann.init(2,1,2,1)

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

-- for _ = 1, 500 do
--   genann.train(ann,inputs[1],outputs[1],3)
--   genann.train(ann,inputs[2],outputs[2],3)
--   genann.train(ann,inputs[3],outputs[3],3)
--   genann.train(ann,inputs[4],outputs[4],3)
-- end

genann.workout(ann,inputs,outputs,10000,3)

print(genann.run(ann,{0,0})[1])
print(genann.run(ann,{0,1})[1])
print(genann.run(ann,{1,0})[1])
print(genann.run(ann,{1,1})[1])

genann.write(ann,"xornet.nn")

genann.free(ann)
