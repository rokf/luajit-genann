local ffi = require 'ffi'

ffi.cdef [[
typedef struct
{
 short level;
 short token;
 short bsize;
 char fd;
 unsigned flags;
 unsigned char hold;
 unsigned char *buffer;
 unsigned char * curp;
 unsigned istemp;
} FILE;

typedef double (*genann_actfun)(double a);

typedef struct genann {
  int inputs, hidden_layers, hidden, outputs;
  genann_actfun activation_hidden;
  genann_actfun activation_output;
  int total_weights;
  int total_neurons;
  double *weight;
  double *output;
  double *delta;
} genann;

genann *genann_init(int inputs, int hidden_layers, int hidden, int outputs);
genann *genann_read(FILE *in);
void genann_randomize(genann *ann);
genann *genann_copy(genann const *ann);
void genann_free(genann *ann);
double const *genann_run(genann const *ann, double const *inputs);
void genann_train(genann const *ann, double const *inputs, double const *desired_outputs, double learning_rate);
void genann_write(genann const *ann, FILE *out);
double genann_act_sigmoid(double a);
double genann_act_sigmoid_cached(double a);
double genann_act_threshold(double a);
double genann_act_linear(double a);
]]

local genann = ffi.load('genann')

local M = {}

function M.init(inputs,hidden_layers,hidden,outputs)
  return genann.genann_init(inputs,hidden_layers,hidden,outputs)
end

function M.read(file)
  if type(file) == "string" then
    local f = io.open(file,'rb')
    local ann = genann.genann_read(f)
    f:close()
    return ann
  end
  return genann.genann_read(file)
end

function M.copy(nn)
  return genann.genann_copy(nn)
end

function M.free(nn)
  genann.genann_free(nn)
end

function M.run(nn,inputs)
  local o
  if type(inputs) == 'table' then
    local i = ffi.new(('const double[%d]'):format(#inputs),inputs)
    o = genann.genann_run(nn,i)
  else
    o = genann.genann_run(nn,inputs)
  end
  local modified_o = {}
  for k=1,nn.outputs do
    table.insert(modified_o,o[k-1])
  end
  return modified_o
end

function M.train(nn,i,o,rate)
  genann.genann_train(nn,i,o,rate)
end

function M.write(nn,file)
  if type(file) == "string" then
    local f = io.open(file,'wb')
    genann.genann_write(nn,f)
    f:close()
  else
    genann.genann_write(nn,file)
  end
end

-- activation functions

M.act = {
  sigmoid = genann.genann_act_sigmoid,
  sigmoid_cached = genann.genann_act_sigmoid_cached,
  linear = genann.genann_act_linear,
  threshold = genann.genann_act_threshold
}

-- additional functions

function M.trans(t)
  local out = {}
  for _,v in ipairs(t) do
    table.insert(out,ffi.new(('const double[%d]'):format(#v),v))
  end
  return out
end

function M.trans1(t)
  return ffi.new(('const double[%d]'):format(#t),t)
end

function M.workout(nn,inputs,outputs,loops,rate)
  for _=1,loops do
    for k=1, #inputs do
      genann.genann_train(nn,inputs[k],outputs[k],rate)
    end
  end
end

return M
