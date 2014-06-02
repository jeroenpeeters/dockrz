Template.fleet.isActive = -> ~@active.indexOf('active')

Template.fleet.events =
  'click .startUnit': -> Meteor.call 'startUnit', @unit
  'click .stopUnit': -> Meteor.call 'stopUnit', @unit
  'click .destroyUnit': -> Meteor.call 'destroyUnit', @unit