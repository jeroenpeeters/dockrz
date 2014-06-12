exec = Npm.require('child_process').exec
ssh = (cmd, callback) -> exec "#{settings.coreos.ssh} #{cmd}", callback
fleetctl = (cmd, callback) -> ssh "fleetctl #{cmd}", callback
  
@Fleet =
  listMachines: ->
    fleetctl 'list-machines --full --no-legend', Meteor.bindEnvironment (error, stdout, stderr) -> 
      updateCollection Machines, resultSplitter stdout, (m) -> {id: m[0], ip: m[1], meta: m[2]}

  listUnits: ->
    fleetctl 'list-units --full --no-legend', Meteor.bindEnvironment (error, stdout, stderr) -> 
      updateCollection Units, resultSplitter( stdout, (m) -> 
        {unit: m[0], state: m[1], load: m[2], active: m[3], sub: m[4], description: m[5], machine: m[6]})
      , 'unit'
      
  stopUnit: (unit) -> controlUnit 'stop', unit
  startUnit: (unit) -> controlUnit 'start', unit
  destroyUnit: (unit) -> controlUnit 'destroy', unit
  submitUnit: (name, code, image) -> 
    if image then code = generateUnitCode name, image #ignore unit code if docker image is provided
    ssh "\"echo \\\"#{code}\\\" > #{name} && fleetctl submit #{name}\"", refreshUnitList
  getUnitSource: (name) -> fleetctl "cat #{name}", Meteor.bindEnvironment (error, stdout, stderr) -> 
    Units.update {unit: name}, {$set: {source: stdout}}
      
controlUnit = (cmd, unit) -> fleetctl "#{cmd} #{unit}", refreshUnitList

refreshUnitList = Meteor.bindEnvironment (error, stdout, stderr) -> 
  console.log error, stdout, stderr
  Fleet.listUnits()
  if error then throw new Meteor.Error(500, error.reason)
      
resultSplitter = (stdout, f) -> _.map stdout.trim().split('\n'), (line) -> f line.trim().split(/\t+/)
    
updateCollection = (collection, data, key) ->
  key = if key then key else 'id'
  opts = {}
  opts[key] = {$nin: _.pluck(data, key)}
  collection.remove opts
  _.map data, (item) ->
    opts[key] = item[key]
    if collection.findOne opts
      collection.update opts, item
    else
      collection.insert item
      
generateUnitCode = (unitName, dockerImage) -> """[Unit]
Description=Automatically generated unit from #{dockerImage}
Requires=docker.service

[Service]
ExecStart=/usr/bin/docker run --name #{unitName}%i -P #{dockerImage}
ExecStop=/usr/bin/docker stop #{unitName}%i
ExecStopPost=/usr/bin/docker rm #{unitName}%i
"""