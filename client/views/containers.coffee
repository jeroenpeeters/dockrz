Template.containers.events =
  'click .startContainer': -> Meteor.call 'startContainer', @Id, Session.get('dockerEndpoint')
  
  'click .stopContainer': -> Meteor.call 'stopContainer', @Id, Session.get('dockerEndpoint')
  
  'click .removeContainer': -> Meteor.call 'removeContainer', @Id, Session.get('dockerEndpoint')
  
  'input #containerFilter': (e, tpl) -> Session.set 'containerFilter', tpl.$('#containerFilter').val()
  
  'click #clearContainerFilter': -> Session.set 'containerFilter', ''
  
Template.containers.isUp = -> ~@Status.indexOf('Up')
