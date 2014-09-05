Template.projects.events =
  'click .dropdown-menu': (e) -> e.stopPropagation() unless e.target.tagName.toUpperCase() == 'BUTTON'

  'submit form': (e, template) ->
    e.preventDefault()
    Session.set 'selectedProjectId', Projects.insert(name: template.find('#newProjectName').value)

  'input #projectName': (e) -> Projects.update {_id: @_id}, {$set: {name: e.target.value}}

Template.projects.helpers
  removeProject: -> (id) -> Projects.remove _id: id
  lastChanged: -> moment(@modifiedAt).fromNow()