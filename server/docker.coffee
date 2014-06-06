@Docker =

  refreshContainers: ->
    for endpoint in settings.docker.endpoints
      @loadContainers endpoint

  loadContainers: (endpoint) ->
    HTTP.get "#{endpoint}/containers/json?all=true", (err, result) ->
      _updateCollection Containers, result.data, endpoint if result?.data

  refreshImages: ->
    for endpoint in settings.docker.endpoints
      @loadImages endpoint

  loadImages: (endpoint) ->
    HTTP.get "#{endpoint}/images/json", (err, result) ->
      _updateCollection Images, result.data, endpoint if result?.data

  loadRegistry: ->
    reg = []
    result = HTTP.get "#{settings.docker.registry.endpoint}/v1/search"
    for r in result.data.results
      tags = HTTP.get "#{settings.docker.registry.endpoint}/v1/repositories/#{r.name}/tags"
      reg.push
        Id: r.name
        name: r.name
        description: r.description
        tags: ({tag: tag, id: id} for tag, id of tags.data)
    _updateCollection Registry, reg, settings.docker.registry.endpoint

  startContainer: (containerId, endpoint) =>
    HTTP.post "#{endpoint}/containers/#{containerId}/start", data: {'PublishAllPorts':true}, -> Docker.loadContainers(endpoint)

  stopContainer: (containerId, endpoint) =>
    HTTP.post "#{endpoint}/containers/#{containerId}/stop"
    HTTP.post "#{endpoint}/containers/#{containerId}/wait", -> Docker.loadContainers(endpoint)

  removeContainer: (containerId, endpoint) =>
    console.log 'remove', containerId, endpoint
    HTTP.del "#{endpoint}/containers/#{containerId}", -> Docker.loadContainers(endpoint)

  createContainer: (imageId, name, endpoint) =>
    HTTP.post "#{endpoint}/containers/create?name=#{name}", data: {'Image': imageId}, (err, res)->
      console.log err, res
      Docker.loadContainers(endpoint)

_updateCollection = (collection, data, endpoint) ->
  collection.remove Id: {$nin: _.pluck(data, 'Id')}, Endpoint: endpoint
  _.map data, (item) ->
    item.Endpoint = endpoint
    if collection.findOne(Id: item.Id, Endpoint: item.Endpoint)
      collection.update {Id: item.Id, Endpoint: item.Endpoint}, item
    else
      collection.insert item

