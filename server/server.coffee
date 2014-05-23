Meteor.startup ->
  Images.remove {}
  Containers.remove {}
  HTTP.get "#{settings.docker.endpoint}/images/json", (err, result) ->
    _.map result.data, (image) -> Images.insert image
  HTTP.get "#{settings.docker.endpoint}/containers/json", (err, result) ->
    _.map result.data, (container) -> Containers.insert container