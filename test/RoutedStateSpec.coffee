define ['RoutedState', 'State', 'StateManager'], (RoutedState, State, StateManager)->

  describe 'RoutedState', ->

    afterEach ->
      StateManager.clear()

    it 'should generate a simple route', ->
      routeStateA = new class extends State
        mixins: RoutedState
        route: 'a'
        statename: 'routeStateA'
      expect(routeStateA.generateRouteString()).to.equal 'a'

    it 'should generate a cascading route', ->
      cascadingStateA = new class extends State
        mixins: RoutedState
        route: 'a'
        statename: 'cascadingStateA'
      cascadingStateAB = new class extends State
        mixins: RoutedState
        route: 'b'
        statename: 'cascadingStateAB'
        parent: cascadingStateA
      expect(cascadingStateAB.generateRouteString()).to.equal 'a/b'

    it 'should generate a route route with parameters', ->
      parameterStateA = new class extends State
        mixins: RoutedState
        route: 'a'
        statename: 'parameterStateA'
      parameterStateAB = new class extends State
        mixins: RoutedState
        route: ':foo'
        statename: 'parameterStateAB'
        parent: parameterStateA
      expect(parameterStateAB.generateRouteString()).to.equal 'a/:foo'
      expect(parameterStateAB.generateRoute(foo: 'bar')).to.equal 'a/bar'

    it 'should be able to generate routes with a non RoutedState in between routed States', ->
      routedStateA = new class extends State
        mixins: RoutedState
        route: 'a'
        statename: 'routedStateA'
      nonRoutedState = new class extends State
        statename: 'nonRoutedState'
        parent: routedStateA
      routedStateB = new class extends State
        mixins: RoutedState
        route: ':foo'
        statename: 'routedStateB'
        parent: nonRoutedState
      expect(routedStateB.generateRouteString()).to.equal 'a/:foo'
      expect(routedStateB.generateRoute(foo: 'bar')).to.equal 'a/bar'

    it 'should register the routes with the router', ->
      RoutedState.router.route = new sinon.spy
      routedStateA = new class extends State
        mixins: RoutedState
        route: 'a'
        statename: 'routedStateA'
      expect(RoutedState.router.route.called).to.be.true
      expect(RoutedState.router.route.firstCall.args[0]).to.equal 'a'