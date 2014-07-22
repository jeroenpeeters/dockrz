@DbVersion = new Meteor.Collection 'db_version'

DbVersion.patch = (version, f) ->
  if DbVersion.find({version: version}).fetch().length == 0
    if f()
      DbVersion.insert {version: version}
      console.log "  patch #{version} installed"
    else
      console.log "  patch #{version} failed to install"
  else
    console.log "  patch #{version} is already installed"
