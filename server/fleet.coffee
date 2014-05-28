@Fleet =
  exec: Npm.require('child_process').exec
  fleetctl: (cmd) -> "#{settings.fleet.endpoint} fleetctl #{cmd}"
  
  listMachines: ->
    Fleet.exec Fleet.fleetctl('list-machines --full --no-legend'), Meteor.bindEnvironment (error, stdout, stderr) -> 
      _updateCollection Machines, _resultSplitter stdout, (m) -> {id: m[0], ip: m[1], meta: m[2]}

_resultSplitter = (stdout, f) ->
  _.map stdout.split('\n'), (line) ->
    f line.split('\t')
    
_updateCollection = (collection, data) ->
  collection.remove id: {$nin: _.pluck(data, 'id')}
  _.map data, (item) ->
    if collection.findOne {'id': item.id}
      collection.update {id: item.id}, item
    else
      collection.insert item