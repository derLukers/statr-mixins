define 'RoutedState', ['Backbone', 'StateManager'], (Backbone, StateManager)->

  insertParameters = (string, parameters)->
    result = string

    for parameter, value of parameters
      result = result.replace ":#{parameter}", value

    return result

  router = new Backbone.Router()

  class RoutedState
    router: router
    @router = router

    constructor: ->
      @router.route @generateRouteString(), @generateName(), =>
        _arguments = arguments
        parameters = {}
        matches = @generateRouteString().match(/:([a-zA-Z0-9\-_]+)/g)
        if matches
          for name, index in matches
            parameters[name.substring(1)] = _arguments[index]
        StateManager.go @generateName(), parameters

    generateRoute: (parameters) ->
      return insertParameters(@generateRouteString(), parameters)

    generateRouteString: ()->
      if @parent and !@parent.generateRouteString
        @parent.generateRouteString = ->
          unless @parent?.generateRouteString
            @parent.generateRouteString = @generateRouteString
          if @parent
            return @parent.generateRouteString()
          else
            return ''
      parentroutestring = '' + [@parent?.generateRouteString()]
      "#{["#{parentroutestring}#{if @route then '/'}" if parentroutestring.length]}#{[@route]}"