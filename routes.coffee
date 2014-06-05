Router.map ->
  @route 'apiStopUnit',
    path: '/api/unit/:name/'
    where: 'server'
    action: ->
      if @request.method == 'PUT'
        [unitName, action] = [@params.name, @request.body.action]
        Fleet["#{action}Unit"] unitName
        @response.writeHead 200, 'Content-Type': 'text/plain'
        @response.end "Scheduled to #{action} #{unitName}."
      else
        @response.writeHead 405, 'Content-Type': 'text/plain'
        @response.end "#{@request.method} requests are not allowed for this resource."