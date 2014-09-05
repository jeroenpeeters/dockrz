Template.applications.events =
  'click .dropdown-menu': (e) -> e.stopPropagation() unless e.target.tagName.toUpperCase() == 'BUTTON'

  'submit form': (e, template) ->
    e.preventDefault()
    Session.set 'selectedApplicationId', Applications.insert(name: template.find('#newApplicationName').value)

  'input #applicationName': (e) -> Applications.update {_id: @_id}, {$set: {name: e.target.value}}

Template.applications.helpers
  removeApplication: ->
    (id) ->
      Applications.remove _id: id
  lastChanged: ->
    moment(@modifiedAt).fromNow()

Template.appDetails.rendered = ->
  Tracker.autorun ->
    @$('#templates').select2
      data: UnitTemplates.find({}).map (tpl) -> id: tpl._id, text: tpl.name
      tags: []
      placeholder: 'Select a unit template'
    @$('ul.select2-choices').addClass('form-control')
    
Template.appDetails.helpers
  toString: (valueList) ->
    Meteor.defer(-> @$('#templates').trigger('change'))
    _.pluck(valueList, 'id').toString()

Template.appDetails.events =
  'change #templates': (e) ->
    if e.removed
      Applications.update {_id: Session.get('selectedApplicationId')}, {'$pull': {templates: {id: e.removed?.id}}}
    else if e.added
      Applications.update {_id: Session.get('selectedApplicationId')}, {'$push': {templates: {id: e.added?.id}}}
    else
      console.log 'simple change'