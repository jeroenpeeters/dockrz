request   = require 'request'
config    = require './config'

exports.containers = (cb) ->
  request "#{config.docker.endpoint}/containers/json?all=true", (err, response, body) ->
    cb JSON.parse body

exports.stop = (container, cb) ->
  request.post "#{config.docker.endpoint}/containers/#{container.Id}/stop"
  request.post "#{config.docker.endpoint}/containers/#{container.Id}/wait", (err, response, body) =>
    cb()

exports.start = (container, cb) ->
  request.post "#{config.docker.endpoint}/containers/#{container.Id}/start", (err, response, body) =>
    cb()

exports.remove = (container, cb) ->
  request.del "#{config.docker.endpoint}/containers/#{container.Id}", (err, response, body) =>
    cb()

exports.images = (cb) ->
  request "#{config.docker.endpoint}/images/json", (err, response, body) ->
    cb JSON.parse body
