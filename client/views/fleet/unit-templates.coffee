Template.unitTemplates.events =
  'input #templateCode': (e) -> UnitTemplates.update {_id: @_id}, {$set: {source: e.target.value}}
  'input #templateName': (e) -> UnitTemplates.update {_id: @_id}, {$set: {name: e.target.value}}

Template.unitTemplates.helpers
  removeUnitTemplate: -> (id) -> UnitTemplates.remove _id: id
  lastChanged: -> moment(@modifiedAt).fromNow()
  addUnitTemplate: -> (unitTemplateName) ->
    Session.set 'selectedUnitTemplateId', UnitTemplates.insert name: unitTemplateName