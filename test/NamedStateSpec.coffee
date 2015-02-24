define ['NamedState', 'State', 'StateManager'], (NamedState, State, StateManager)->

  describe 'NamedState', ->

    afterEach ->
      StateManager.clear()

    it 'should use the constructors name', ->
      namedStateA = new class NamedStateA extends State
        mixins: NamedState
      expect(namedStateA.generateName()).to.equal 'NamedStateA'