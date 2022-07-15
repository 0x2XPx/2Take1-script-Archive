Config = {}
Config.__index = Config

function Config:create(path,create)
   local conf = {}             -- our new object
   setmetatable(conf,Config)  -- make Account handle lookup
   self.path = path
   self.config = {}
   
   
   if create == true and not utils.file_exists(path) then
    file = io.open(path, "w")
    file:write("#Created using 1337Zeros config.lua\n")
    file:close()
  end
  if utils.file_exists(path)then
    file = path
    
    for line in io.lines(file) do 
      --if not tostring(line:sub(1,1)) == '#' then
      if not self.starts_with(self,line,'#') then
        for k, v in string.gmatch(line, "(%w+)=(%w+)") do
          self.config[k] = v  
        end
       end     
    end    
  else
    return false;
  end
   self.config["path"] = path
   return conf
end

function Config:starts_with(str, start)
   return str:sub(1, #start) == start
end

function Config:isFeatureEnabled(feature)
  if self.config[feature] ~= nil then
    if self.config[feature] == 'true' or self.config[feature] == '1' or self.config[feature] == 1 then
      return true
    end
  end
  return false
end

function Config:getValue(key)
 -- print("load value for key " .. key)
  if self.config[key] ~= nil then
    return self.config[key]
  end
  return nil
end

function Config:saveConfig()
    os.remove(self.config["path"])
    file = io.open(self.path, "w")
    file:write("#Created using 1337Zeros config.lua\n")
    for k, v in pairs(self.config) do
      if k ~= "path" then
        file:write(tostring(k) .. "=" .. tostring(v) .."\n");
      end
    end
    file:close()
end

function Config:storeValue(key,value)
  self.config[key] = value 
end
function Config:saveIfNotExist(key,value)
  if self.getValue(self,key) == nil then
     self.storeValue(self,key,value)
     self.saveConfig(self,self.path)
  end
end