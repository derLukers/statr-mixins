# Statr-Mixins
[ ![Codeship Status for derLukers/statr-mixins](https://codeship.com/projects/d38ef340-9e3b-0132-452a-6e77ea26735b/status?branch=master)](https://codeship.com/projects/64723)
These are (or will soon be) a bunch of mixins for statr.
## Usage
When using the mixins the are to be included in the `mixins` list of the new state like so:
```coffeescript
new class fooState extends State
    mixins: [RoutedState, NamedState]
    route: 'foo'
```

If you are only using a single mixin you can also use it like this:
```coffeescript
new class fooState extends State
    mixins: RoutedState
    route: 'foo'
    statename: 'foo'
```
