Template.unitTemplates.events =
  'click #addUnitTemplate': ->
    Session.set 'selectedUnitTemplateId', UnitTemplates.insert {name: '_ Brand new unit', source: 'Put unit code here'}

  'input #templateCode': (e) -> UnitTemplates.update {_id: @_id}, {$set: {source: e.target.value}}

  'input #templateName': (e) -> UnitTemplates.update {_id: @_id}, {$set: {name: e.target.value}}

Template.unitTemplates.helpers
  removeUnitTemplate: -> (id) -> UnitTemplates.remove _id: id
  lastChanged: -> moment(@modifiedAt).fromNow()
