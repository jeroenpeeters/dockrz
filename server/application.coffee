Helper =
  control: (operation) -> (applicationId) ->
    console.log applicationId
    app = Applications.findOne _id: applicationId
    console.log app
    _.each app.unitNames, (unitName) ->
      Fleet[operation + 'Unit'] unitName

@Application =

  create: (appTemplateId, instanceName) ->
    appTemplate = ApplicationTemplates.findOne _id: appTemplateId
    unitTemplates = UnitTemplates.find  _id: $in: _.pluck(appTemplate.unitTemplates, 'id')

    unitNames = _.map unitTemplates.fetch(), (template) ->
      unitName = "#{appTemplate.name}-#{template.name}@#{instanceName}"
      Fleet.submitUnit unitName, template.source
      unitName

    console.log unitNames

    appId = Applications.insert
      name: instanceName
      template: appTemplate
      unitNames: unitNames

    appId

  start: Helper.control('start')

  stop: Helper.control('stop')

  #status: (applicationId) ->
  #  app = Applications.findOne _id: applicationId



