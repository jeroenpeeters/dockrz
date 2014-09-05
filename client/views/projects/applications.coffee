Template.applications.events =
  'click .dropdown-menu': (e) -> e.stopPropagation() unless e.target.tagName.toUpperCase() == 'BUTTON'

  'submit form': (e, template) ->
    e.preventDefault()
    Session.set 'selectedApplicationId', Applications.insert(name: template.find('#newApplicationName').value)

  'input #applicationName': (e) -> Applications.update {_id: @_id}, {$set: {name: e.target.value}}

  'input #applicationImage': (e) ->
    Applications.update {_id: @_id}, {$set: {image_url: e.target.value}}

Template.applications.helpers
  removeApplication: ->
    (id) ->
      Applications.remove _id: id
  lastChanged: ->
    moment(@modifiedAt).fromNow()

Template.appDetails.rendered = ->
  Deps.autorun ->
    @$("#templates").select2
      data: UnitTemplates.find({}).map (tpl) -> id: tpl._id, text: tpl.name
      tags: []
      placeholder: "Select a unit template"

Template.appDetails.helpers
  toString: (valueList) ->
    Meteor.defer(-> @$("#templates").trigger('change'))
    _.map(valueList, (item) -> UnitTemplates.findOne(_id: item.id)._id).toString()

Template.appDetails.events =
  'change #templates': (e) ->
    console.log e
    if e.removed then Applications.update {_id: Session.get('selectedApplicationId')}, {"$pull": {templates: {id: e.removed?.id}}}
    if e.added then Applications.update {_id: Session.get('selectedApplicationId')}, {"$push": {templates: {id: e.added?.id}}}
