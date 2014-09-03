Template.projects.events =
  'click .project': -> Session.set 'selectedProjectId', @_id

  'click #addProject': (e, template) ->
    Session.set 'selectedProjectId', Projects.insert name: template.find('#newProjectName').value

  'click .remove-project': -> Projects.remove _id: @_id

  'input #projectName': (e, template) -> Projects.update {_id: @_id}, {$set: {name: e.target.value}}

  'click .dropdown-menu': (e) -> e.stopPropagation() unless e.target.tagName.toUpperCase() == 'BUTTON'

  #'input #templateName': (e, template) -> UnitTemplates.update {_id: @_id}, {$set: {name: e.target.value}}

Template.projects.helpers
  active: -> if @_id == Session.get('selectedProjectId') then "active" else ""
  lastChanged: -> moment(@modifiedAt).fromNow()
