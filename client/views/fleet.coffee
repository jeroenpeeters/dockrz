Template.fleet.isActive = -> ~@active.indexOf('active')

Template.fleet.events =
  'click .startUnit': -> Meteor.call 'startUnit', @unit
  'click .stopUnit': -> Meteor.call 'stopUnit', @unit
  'click .destroyUnit': -> Meteor.call 'destroyUnit', @unit
  'click #submitUnit': (e, template)->
    name = $('#unitName', e.target.parentNode).val()
    code = $('#unitCode', e.target.parentNode).val()
    Meteor.call 'submitUnit', name, code

  'click .dropdown-menu': (e) -> e.stopPropagation() unless e.target.tagName.toUpperCase() == 'BUTTON'