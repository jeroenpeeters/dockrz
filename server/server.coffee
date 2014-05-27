Meteor.startup ->

  Containers.remove {}
  Images.remove {}

  Meteor.setInterval ->
    Docker.refreshContainers()
    Docker.refreshImages()
  , 1000

Meteor.publish 'containers', (endpoint) -> Containers.find {Endpoint: endpoint}
Meteor.publish 'images', (endpoint) -> Images.find {Endpoint: endpoint}

Meteor.methods
  startContainer: Docker.startContainer
  stopContainer: Docker.stopContainer
  removeContainer: Docker.removeContainer
  createContainer: Docker.createContainer
