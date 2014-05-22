exec = require('child_process').exec
config    = require './config'

exports.machines = (cb) ->
  exec "ssh #{config.fleet.endpoint} fleetctl list-machines --full --no-legend", (error, stdout, stderr) -> 
    machines = stdout.trim().split('\n')
    cb machines.map (machine) -> 
      m = machine.split('\t')
      {id: m[0], ip: m[1], meta: m[2]}
        