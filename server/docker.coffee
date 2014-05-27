@Docker = 
  loadContainers: ->
    HTTP.get "#{settings.docker.endpoint}/containers/json?all=true", (err, result) ->
      _updateCollection Containers, result.data

  loadImages: ->
    HTTP.get "#{settings.docker.endpoint}/images/json", (err, result) ->
      _updateCollection Images, result.data
  
  startContainer: (containerId) ->
    HTTP.post "#{settings.docker.endpoint}/containers/#{containerId}/start", @loadContainers

  stopContainer: (containerId) ->
    HTTP.post "#{settings.docker.endpoint}/containers/#{containerId}/stop"      
    HTTP.post "#{settings.docker.endpoint}/containers/#{containerId}/wait", @loadContainers      

  removeContainer: (containerId) ->
    HTTP.del "#{settings.docker.endpoint}/containers/#{containerId}", @loadContainers      
    
  createContainer: (imageId) ->
    HTTP.post "#{settings.docker.endpoint}/containers/create", data: {'Image': imageId}, @loadContainers
    
_updateCollection = (collection, data) ->
  console.log 
  collection.remove Id: {$nin: _.pluck(data, 'Id')}
  _.map data, (item) -> 
    if collection.findOne(Id: item.Id)
      collection.update {Id: item.Id}, item
    else
      collection.insert item

  