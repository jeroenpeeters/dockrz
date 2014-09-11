Template.projects.events =
  'click #addProject': (e, template) ->
    Session.set 'selectedProjectId', Projects.insert name: template.find('#newProjectName').value

  'click .dropdown-menu': (e) -> e.stopPropagation() unless e.target.tagName.toUpperCase() == 'BUTTON'

Template.projects.helpers
  removeApplication: -> (id) ->Projects.remove _id: id
  active: -> if @_id == Session.get('selectedProjectId') then "active" else ""

Template.projectDetails.events =
  'input #projectName': (e, template) -> Projects.update {_id: @_id}, {$set: {name: e.target.value}}
  'drop #projectApps': (e, template, ui) ->
    Projects.update {_id: Session.get 'selectedProjectId'}, {"$push": {applications: _.omit ui.draggable.data('app'), '_id'}}

Template.projectDetails.helpers
  lastChanged: -> moment(@modifiedAt).fromNow()

Template.projectDetails.rendered = ->
  @$('#projectApps').droppable accept: ".app-item"

Template.appItem.rendered = ->
  draggable = @$('.app-item').draggable
    revert: "invalid"
    helper: "clone"
  draggable.data 'app', @data

Template.projectAppDetail.rendered = ->
  @$('.app-item').hide().fadeIn 250
