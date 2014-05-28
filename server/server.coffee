Meteor.startup ->

  Containers.remove {}
  Images.remove {}
  Machines.remove {}
  Units.remove {}
  
  Docker.refreshContainers()
  Docker.refreshImages()
  Fleet.listMachines()

  Meteor.setInterval ->
    Docker.refreshContainers()
    Docker.refreshImages()
    Fleet.listMachines()
  , 10000

Meteor.publish 'containers', (endpoint) -> Containers.find {Endpoint: endpoint}
Meteor.publish 'images', (endpoint) -> Images.find {Endpoint: endpoint}
Meteor.publish 'machines', () -> Machines.find {}

Meteor.methods
  startContainer: Docker.startContainer
  stopContainer: Docker.stopContainer
  removeContainer: Docker.removeContainer
  createContainer: Docker.createContainer
  listFleetMachines: -> Fleet.listMachines()