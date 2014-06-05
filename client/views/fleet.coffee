Template.fleet.rendered = -> 
  @$('#unitCodeChoiceTabs a').click (e) ->
    e.preventDefault()
    $(@).tab('show')

Template.fleet.isActive = -> @active != null && ~@active.indexOf('active')

Template.fleet.events =
  'click .startUnit': -> Meteor.call 'startUnit', @unit
  'click .stopUnit': -> Meteor.call 'stopUnit', @unit
  'click .destroyUnit': -> Meteor.call 'destroyUnit', @unit
  'click #submitUnit': (e, template)->
    name = $('#unitName', e.target.parentNode).val()
    code = $('#unitCode', e.target.parentNode).val()
    image = $('#dockerImage', e.target.parentNode).val()
    Meteor.call 'submitUnit', name, code, image

  'click .dropdown-menu': (e) -> e.stopPropagation() unless e.target.tagName.toUpperCase() == 'BUTTON'
