@Fleet =
  exec: Npm.require('child_process').exec
  ssh: (cmd, callback) -> Fleet.exec "#{settings.fleet.endpoint} #{cmd}", callback
  fleetctl: (cmd, callback) -> Fleet.ssh "fleetctl #{cmd}", callback
  
  listMachines: ->
    Fleet.fleetctl 'list-machines --full --no-legend', Meteor.bindEnvironment (error, stdout, stderr) -> 
      _updateCollection Machines, _resultSplitter stdout, (m) -> {id: m[0], ip: m[1], meta: m[2]}

  listUnits: ->
    Fleet.fleetctl 'list-units --full --no-legend', Meteor.bindEnvironment (error, stdout, stderr) -> 
      _updateCollection Units, _resultSplitter( stdout, (m) -> 
        {unit: m[0], load: m[1], active: m[2], sub: m[3], description: m[4], machine: m[5]})
      , 'unit'
      
  stopUnit: (unit) -> _controlUnit 'stop', unit
  startUnit: (unit) -> _controlUnit 'start', unit
  destroyUnit: (unit) -> _controlUnit 'destroy', unit
  submitUnit: (name, code) -> 
    Fleet.ssh "\"echo '#{code}' > #{name} && fleetctl submit #{name}\"", _refreshUnitList
      
_controlUnit = (cmd, unit) -> 
    Fleet.fleetctl "#{cmd} #{unit}", _refreshUnitList

_refreshUnitList = Meteor.bindEnvironment (error, stdout, stderr) -> 
    console.log error, stdout, stderr
    Fleet.listUnits()
      
_resultSplitter = (stdout, f) -> _.map stdout.trim().split('\n'), (line) -> f line.trim().split(/\t+/)
    
_updateCollection = (collection, data, key) ->
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