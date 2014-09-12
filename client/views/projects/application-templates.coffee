Template.applicationTemplates.events =
  'click .dropdown-menu': (e) -> e.stopPropagation() unless e.target.tagName.toUpperCase() == 'BUTTON'

  'submit form#newAppTemplate': (e, template) ->
    e.preventDefault()
    Session.set 'selectedApplicationTemplateId', ApplicationTemplates.insert(name: template.find('#newApplicationTemplateName').value)

  'input #applicationName': (e) -> ApplicationTemplates.update {_id: @_id}, {$set: {name: e.target.value}}

  'input #applicationImage': (e) ->
    ApplicationTemplates.update {_id: @_id}, {$set: {image_url: e.target.value}}

Template.applicationTemplates.helpers
  removeApplicationTemplate: ->
    (id) ->
      ApplicationTemplates.remove _id: id
  lastChanged: ->
    moment(@modifiedAt).fromNow()

Template.applicationTemplateDetails.rendered = ->
  console.log 'look Im rendered'
  Tracker.autorun -> _initSelect2 @

Template.applicationTemplateDetails.destroyed = ->
  console.log 'look Im destoyed'
  @$('.select2-container').context.remove()
  _initSelect2 @

Template.applicationTemplateDetails.helpers
  toString: (valueList) ->
    Meteor.defer(-> @$('#templates').trigger('change'))
    _.pluck(valueList, 'id').toString()

Template.applicationTemplateDetails.events =
  'change #templates': (e) ->
    console.log e
    if e.removed
      ApplicationTemplates.update {_id: Session.get('selectedApplicationTemplateId')}, {"$pull": {unitTemplates: {id: e.removed?.id}}}
    else if e.added
      ApplicationTemplates.update {_id: Session.get('selectedApplicationTemplateId')}, {"$push": {unitTemplates: {id: e.added?.id}}}
    else
      console.log 'simple change'

  'submit form': (e, template) ->
    e.preventDefault()
    Meteor.call 'createApplication', Session.get('selectedApplicationTemplateId'), template.find('#newApplicationName').value, (err, appId) ->
      Meteor.setTimeout () ->
        Meteor.call 'startApplication', appId
      , 1000

_initSelect2 = (tpl) ->
  tpl.$('#templates').select2
    data: UnitTemplates.find({}).map (tpl) -> id: tpl._id, text: tpl.name
    tags: []
    placeholder: 'Select a unit template'
  tpl.$('ul.select2-choices').addClass('form-control')
