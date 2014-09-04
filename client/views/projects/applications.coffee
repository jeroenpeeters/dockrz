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

  Deps.autorun ->
    if Session.get('selectedApplicationId') then Meteor.defer(-> @$("#templates").trigger('change'))

Template.appDetails.helpers
  toString: (valueList) ->
    _.map(valueList, (item) -> UnitTemplates.findOne(_id: item.id).name).toString()

Template.appDetails.events =
  'change #templates': (e) ->
    console.log e
    if e.removed then Applications.update {_id: Session.get('selectedApplicationId')}, {"$pull": {templates: {id: e.removed?.id}}}
    if e.added then Applications.update {_id: Session.get('selectedApplicationId')}, {"$push": {templates: {id: e.added?.id}}}