allTestFiles = []
TEST_REGEXP = /(spec|test)(\.coffee)?(\.js)?$/i
pathToModule = (path) ->
  path.replace(/^\/base\//, "").replace(/\.js$/, "").replace(/\.coffee$/, "")

Object.keys(window.__karma__.files).forEach (file) ->
  # Normalize paths to RequireJS module names.
  allTestFiles.push pathToModule(file)  if TEST_REGEXP.test(file)
  return

require.config
# Karma serves files under /base, which is the basePath from your config file
  baseUrl: "/base/"

# dynamically load all test files
  deps: allTestFiles

# we have to kickoff jasmine, as it is asynchronous
  callback: window.__karma__.start

  paths:
    jquery: 'bower_components/jquery/dist/jquery'
    underscore: 'bower_components/underscore/underscore'
    Backbone: 'bower_components/backbone/backbone'
    'es6-promise': 'bower_components/es6-promise/index'
    State: 'bower_components/statr/src/State'
    StateManager: 'bower_components/statr/src/StateManager'
    RoutedState: 'src/RoutedState'
    NamedState: 'src/NamedState'

  shim:
    underscore:
      exports: '_'