Template.applications.events =
  'click #addApplication': ->
    Session.set 'selectedApplicationId', Applications.insert name: '_ Brand new application'

  'input #applicationName': (e) ->
    Applications.update {_id: @_id}, {$set: {name: e.target.value}}

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
    _.pluck(valueList, 'id').toString()

Template.appDetails.events =
  'change #templates': (e) ->
    if e.removed
      Applications.update {_id: Session.get('selectedApplicationId')}, {"$pull": {templates: {id: e.removed?.id}}}
    else if e.added
      Applications.update {_id: Session.get('selectedApplicationId')}, {"$push": {templates: {id: e.added?.id}}}
    else
      console.log "simple change"