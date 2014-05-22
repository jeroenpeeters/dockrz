exec = require('child_process').exec
config    = require './config'

exports.machines = (cb) ->
  exec "ssh #{config.fleet.endpoint} fleetctl list-machines --full --no-legend", (error, stdout, stderr) -> 
    cb stdout
        