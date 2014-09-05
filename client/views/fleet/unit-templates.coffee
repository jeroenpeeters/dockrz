Template.unitTemplates.events =
  'click .dropdown-menu': (e) -> e.stopPropagation() unless e.target.tagName.toUpperCase() == 'BUTTON'

  'submit form': (e, template) ->
    e.preventDefault()
    Session.set 'selectedUnitTemplateId', UnitTemplates.insert(name: template.find('#newUnitTemplateName').value)

  'input #templateCode': (e) -> UnitTemplates.update {_id: @_id}, {$set: {source: e.target.value}}

  'input #templateName': (e) -> UnitTemplates.update {_id: @_id}, {$set: {name: e.target.value}}

Template.unitTemplates.helpers
  removeUnitTemplate: -> (id) -> UnitTemplates.remove _id: id
  lastChanged: -> moment(@modifiedAt).fromNow()
