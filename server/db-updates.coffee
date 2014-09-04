Meteor.startup ->
  console.log "this should run only on the server"
  if Meteor.isServer

    # Run the database update scripts

    console.log 'Applying database patches'

    # How to create a database patch?
    #
    # A database patch is simply a registered function execution.
    # If the function succeeds (doesn't return false/null/undefined)
    # the execution is registered in the database. An executed patch
    # will not be installed again, unless the execution yields a negative
    # result.
    # The version number doesn't imply a sequential relation, patches
    # are executed in the order in which they appear in this script.
    # Therefore, patches should be added at the end of the file.
    # A patch can basically do anything, its up to you to respect semantics
    # and data integrity.

    DbVersion.patch 1.0, () ->
      Activity.remove {} #older activities are incompatible with current schema
