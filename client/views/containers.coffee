Template.containers.events =
  'click .startContainer': -> Meteor.call 'startContainer', @Id
  'click .stopContainer': -> Meteor.call 'stopContainer', @Id
  'click .removeContainer': -> Meteor.call 'removeContainer', @Id
  
Template.containers.isUp = -> ~@Status.indexOf('Up')
    