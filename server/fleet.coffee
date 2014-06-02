@Fleet =
  exec: Npm.require('child_process').exec
  fleetctl: (cmd, callback) -> Fleet.exec "#{settings.fleet.endpoint} fleetctl #{cmd}", callback
  
  listMachines: ->
    Fleet.fleetctl 'list-machines --full --no-legend', Meteor.bindEnvironment (error, stdout, stderr) -> 
      _updateCollection Machines, _resultSplitter stdout, (m) -> {id: m[0], ip: m[1], meta: m[2]}

  listUnits: ->
    Fleet.fleetctl 'list-units --full --no-legend', Meteor.bindEnvironment (error, stdout, stderr) -> 
      _updateCollection Units, _resultSplitter stdout, (m) -> 
        {unit: m[0], load: m[1], active: m[2], sub: m[3], description: m[4], machine: m[5]}
        
  stopUnit: (unit) -> _controlUnit 'stop', unit
  startUnit: (unit) -> _controlUnit 'start', unit
  destroyUnit: (unit) -> _controlUnit 'destroy', unit
      
_controlUnit = (cmd, unit) -> 
    Fleet.fleetctl "#{cmd} #{unit}", Meteor.bindEnvironment (error, stdout, stderr) -> 
      console.log stdout
      Fleet.listUnits()

_resultSplitter = (stdout, f) -> _.map stdout.trim().split('\n'), (line) -> f line.split('\t')
    
_updateCollection = (collection, data) ->
  collection.remove id: {$nin: _.pluck(data, 'id')}
  _.map data, (item) ->
    if collection.findOne {'id': item.id}
      collection.update {id: item.id}, item
    else
      collection.insert item