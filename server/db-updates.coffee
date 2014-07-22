Meteor.startup ->
  if Meteor.isServer

    # Run the database update scripts

    console.log 'Applying database patches'

    DbVersion.patch 1.0, () ->
      Activity.remove {} #older activities are incompatible with current schema
