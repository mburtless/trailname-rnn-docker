require 'torch'
require 'nn'
cjson = require 'cjson'
require 'LanguageModel'

-- model
modelPath = '/root/torch-rnn/cv/trailnamemodel.t7'
-- torch options
opt = {}
opt.gpu = -1
opt.length = 100

-- read model
local checkpoint = torch.load(modelPath)
local model = checkpoint.model

--[[local msg
if opt.gpu >= 0 and opt.gpu_backend == 'cuda' then
  require 'cutorch'
  require 'cunn'
  cutorch.setDevice(opt.gpu + 1)
  model:cuda()
  msg = string.format('Running with CUDA on GPU %d', opt.gpu)
elseif opt.gpu >= 0 and opt.gpu_backend == 'opencl' then
  require 'cltorch'
  require 'clnn'
  model:cl()
  msg = string.format('Running with OpenCL on GPU %d', opt.gpu)
else
  msg = 'Running in CPU mode'
end
if opt.verbose == 1 then print(msg) end]]

model:evaluate()

-- our end point function
-- this function is called by the ngx server
-- accepts a json body
function Sample(json)
print("starting")
-- decode and extract starttext field
print(json)
local data = cjson.decode(json)
opt.start_text = data.starttext

local response = {}
-- If starttext field is empty, return nothing
if opt.start_text == nil then
	print("No starttext given")
else
	-- evaluate the input and create a response
	local output = model:sample(opt)
	for s in output:gmatch("[^\r\n]+") do
    		table.insert(response, s)
	end
end
-- return response
return response
end
