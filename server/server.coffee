Meteor.startup ->
  Meteor.setInterval ->
    Docker.loadContainers()
    Docker.loadImages()
  , 1000
  
Meteor.publish 'containers', -> Containers.find {}
Meteor.publish 'images', -> Images.find {}

Meteor.methods
  startContainer: Docker.startContainer
  stopContainer: Docker.stopContainer
  removeContainer: Docker.removeContainer
  createContainer: Docker.createContainer