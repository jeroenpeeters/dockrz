Template.applications.events =
  'click #addApplication': ->
    Session.set 'selectedApplicationId', Applications.insert name: '_ Brand new application'

  'input #applicationName': (e) -> Applications.update {_id: @_id}, {$set: {name: e.target.value}}

Template.applications.helpers
  removeApplication: -> (id) -> Applications.remove _id: id
  lastChanged: -> moment(@modifiedAt).fromNow()

Template.appDetails.rendered = -> @$("#templates").select2(tags:[])
Template.appDetails.helpers
  toString: (valueList) ->
    Meteor.defer(-> @$("#templates").trigger('change'))
    _.pluck(valueList, 'name').toString()

Template.appDetails.events =
  'change #templates': (e) ->
    if e.removed then Applications.update {_id: Session.get('selectedApplicationId')}, {"$pull": {templates: {name: e.removed?.text}}}
    if e.added then Applications.update {_id: Session.get('selectedApplicationId')}, {"$push": {templates: {name: e.added?.text}}}