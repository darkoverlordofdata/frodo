# The viewmodel contains an observable array of gridData (hex colors) and
# a reference to a gridster object which is created using the initializeGridster
# function.  The addGridster function allows one to add a new element to the gridster
#  object.

class Viewmodel

  myData: null
  gridster: null

  constructor: (data) ->
    @myData = ko.observableArray(data)

  init: ->
    @gridster = $(".gridster ul").gridster(
      widget_margins: [5, 5]
      widget_base_dimensions: [30, 30]
    ).data('gridster')


  addItem: (data, object) ->
    if @gridster?

      $item = $(data[0].parentNode)
      if not $item.hasClass("gs-w")
        ko.cleanNode data[0].parentNode
        $item.remove()
        @gridster.add_widget $item

module.exports = Viewmodel



