request   = require 'request'
config    = require './config'

exports.containers = (cb) ->
  request "#{config.docker.endpoint}/containers/json?all=true", (err, response, body) ->
    cb JSON.parse body

exports.images = (cb) ->
  request "#{config.docker.endpoint}/images/json", (err, response, body) ->
    cb JSON.parse body

exports.container =   
  stop: (container, cb) ->
    request.post "#{config.docker.endpoint}/containers/#{container.Id}/stop"
    request.post "#{config.docker.endpoint}/containers/#{container.Id}/wait", (err, response, body) =>
      cb()

  start: (container, cb) ->
    request.post "#{config.docker.endpoint}/containers/#{container.Id}/start", (err, response, body) =>
      cb()

  remove: (container, cb) ->
    request.del "#{config.docker.endpoint}/containers/#{container.Id}", (err, response, body) =>
      cb()

  create: (imageId, cb) ->
    request.post {url: "#{config.docker.endpoint}/containers/create", body: JSON.stringify({'Image': imageId})}, (err, response, body) ->
      cb JSON.parse body
