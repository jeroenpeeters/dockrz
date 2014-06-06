Template.registry.events =

 'click .newContainer': (e, template)->
    selector =  $(e.currentTarget).closest('tr').find('.tagSelector option:selected')
    $(e.currentTarget).closest('tr').find('.tag').text selector.text()

 'click .dropdown-menu': (e) -> e.stopPropagation() unless e.target.tagName.toUpperCase() == 'BUTTON'

 'click .createContainer': (e, template)->
    name = $('.containerName', e.target.parentNode).val()
    endpoint = $('.endpoint', e.target.parentNode).val()
    tag =  $(e.currentTarget).closest('tr').find('.tagSelector option:selected').text()
    console.log name, endpoint, tag, @name.split('/')[1]
    console.log "#{settings.docker.registry.endpoint}/#{@name.split('/')[1]}:#{tag}"
    Meteor.call 'createContainer', "docker1.rni.org:5000/#{@name.split('/')[1]}:#{tag}", name, endpoint
