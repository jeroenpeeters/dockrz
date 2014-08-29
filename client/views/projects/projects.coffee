Template.projects.events =
  'click .project': -> Session.set 'selectedProjectId', @_id

  'click #addProject': ->
    Session.set 'selectedProjectId', Projects.insert {name: "_ New Project"}

  'click .remove-project': -> Projects.remove _id: @_id

  'input #projectName': (e, template) -> Projects.update {_id: @_id}, {$set: {name: e.target.value}}

  #'input #templateName': (e, template) -> UnitTemplates.update {_id: @_id}, {$set: {name: e.target.value}}

Template.projects.helpers
  active: -> if @_id == Session.get('selectedProjectId') then "active" else ""
  lastChanged: -> moment(@modifiedAt).fromNow()
