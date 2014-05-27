@Docker =

  refreshContainers: ->
    for endpoint in settings.docker.endpoints
      @loadContainers endpoint

  loadContainers: (endpoint) ->
    HTTP.get "#{endpoint}/containers/json?all=true", (err, result) ->
      _updateCollection Containers, result.data, endpoint

  refreshImages: ->
    for endpoint in settings.docker.endpoints
      @loadImages endpoint

  loadImages: (endpoint) ->
    HTTP.get "#{endpoint}/images/json", (err, result) ->
      _updateCollection Images, result.data, endpoint

  startContainer: (containerId, endpoint) ->
    HTTP.post "#{endpoint}/containers/#{containerId}/start" #, @loadContainers

  stopContainer: (containerId, endpoint) ->
    HTTP.post "#{endpoint}/containers/#{containerId}/stop"
    HTTP.post "#{endpoint}/containers/#{containerId}/wait" #, @loadContainers

  removeContainer: (containerId, endpoint) ->
    console.log 'remove', containerId, endpoint
    HTTP.del "#{endpoint}/containers/#{containerId}" #, @loadContainers

  createContainer: (imageId, endpoint) ->
    HTTP.post "#{endpoint}/containers/create", data: {'Image': imageId} #, @loadContainers

_updateCollection = (collection, data, endpoint) ->
  collection.remove Id: {$nin: _.pluck(data, 'Id')}, Endpoint: endpoint
  _.map data, (item) ->
    item.Endpoint = endpoint
    if collection.findOne(Id: item.Id, Endpoint: item.Endpoint)
      collection.update {Id: item.Id, Endpoint: item.Endpoint}, item
    else
      collection.insert item

