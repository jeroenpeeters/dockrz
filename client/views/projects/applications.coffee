Template.applications.events =
  'click .application': -> Session.set 'selectedApplicationId', @_id

  'click #addApplication': (e, template)->
    Session.set 'selectedApplicationId', Applications.insert name: template.find('#appName').value

  'click .remove-application': -> Applications.remove _id: @_id

  'input #applicationName': (e, template) -> Applications.update {_id: @_id}, {$set: {name: e.target.value}}

  'click .dropdown-menu': (e) -> e.stopPropagation() unless e.target.tagName.toUpperCase() == 'BUTTON'

Template.applications.helpers
  active: -> if @_id == Session.get('selectedApplicationId') then "active" else ""
  lastChanged: -> moment(@modifiedAt).fromNow()
