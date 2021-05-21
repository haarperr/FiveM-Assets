Config = {}

-- only use MultiNameJobs for if you need to check total number of both jobs in 1 export - like the example below

Config.MultiNameJobs = {
   cops = {'police'},
   ems = {'ambualnce'},  
}


-- example of how to check for police online - using the multiname list above 
--  if  exports["gr8rp_jobnumbers"]:jobonline('cops') > PoliceNeeded then   --  this would return the total number of police/sheriff on the server

--  without the multi line would just check as 
--  if  exports["gr8rp_jobnumbers"]:jobonline('police') > PoliceNeeded then   -- this would return only police online if not using multiline.