request = require 'request'

exports.containers = (cb) ->
  request 'http://docker1.rni.org:4243/containers/json?all=true', (err, response, body) ->
    cb JSON.parse body

exports.stop = (container, cb) ->
  request.post "http://docker1.rni.org:4243/containers/#{container.Id}/stop"
  request.post "http://docker1.rni.org:4243/containers/#{container.Id}/wait", (err, response, body) =>
    cb()

exports.images = (cb) ->
  request 'http://docker1.rni.org:4243/images/json', (err, response, body) ->
    cb JSON.parse body
