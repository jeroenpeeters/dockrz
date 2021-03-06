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
        {unit: m[0], machine: m[1], active: m[2], sub: m[3]})
      , 'unit'

  stopUnit: (unitName) -> controlUnit 'stop', unitName
  startUnit: (unitName) -> controlUnit 'start', unitName
  destroyUnit: (unitName) -> controlUnit 'destroy', unitName
  submitUnit: (name, code, image) ->
    if image then code = generateUnitCode name, image #ignore unit code if docker image is provided
    #escape surrounding double quotes and $ to prevent immediate execution
    cmd = "\"echo -E \\\"#{code.replace(/\"/g, '\\\\\\\"').replace(/\$/g, '\\\\\\$')}\\\" > #{name} && /usr/bin/fleetctl submit #{name}\""
    ssh cmd, refreshUnitList
  getUnitSource: (name) -> fleetctl "cat #{name}", Meteor.bindEnvironment (error, stdout, stderr) ->
    Units.update {unit: name}, {$set: {source: stdout}}

controlUnit = (cmd, unit) -> fleetctl "#{cmd} #{unit}", refreshUnitList

refreshUnitList = Meteor.bindEnvironment (error, stdout, stderr) ->
  console.log error, stdout, stderr
  Fleet.listUnits()
  if error then messages.emit('error', error.reason)

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
ExecStart=/usr/bin/docker run --name %n -P #{dockerImage}
ExecStartPost=/usr/bin/etcdctl set /%n/host $(fleetctl list-units | grep %n | tr '/' '\n' | tail -1)

ExecStop=/usr/bin/docker stop %n
ExecStopPost=/usr/bin/docker rm %n
"""
