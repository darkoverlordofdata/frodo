MyApp = new Backbone.Marionette.Application()
MyApp.addRegions mainRegion: "#content"


class AngryCat extends Backbone.Model
  defaults:
    votes: 0

  addVote: ->
    @set "votes", @get("votes") + 1

  rankUp: ->
    @set rank: @get("rank") - 1

  rankDown: ->
    @set rank: @get("rank") + 1


class AngryCats extends Backbone.Collection
  model: AngryCat
  initialize: (cats) ->
    rank = 1
    for cat in cats
      cat.set "rank", rank++


    @on "add", (cat) =>
      unless cat.get("rank")
        error = Error("Cat must have a rank defined before being added to the collection")
        error.name = "NoRankError"
        throw error

    MyApp.on "rank:up", (cat) =>
      
      # can't increase rank of top-ranked cat
      return true  if cat.get("rank") is 1
      @rankUp cat
      @sort()
      @trigger "reset"

    MyApp.on "rank:down", (cat) =>
      
      # can't decrease rank of lowest ranked cat
      return true  if cat.get("rank") is @size()
      @rankDown cat
      @sort()
      @trigger "reset"

    MyApp.on "cat:disqualify", (cat) =>

      disqualifiedRank = cat.get("rank")
      catsToUprank = @filter((cat) ->
        cat.get("rank") > disqualifiedRank
      )
      catsToUprank.forEach (cat) ->
        cat.rankUp()

      @trigger "reset"


  comparator: (cat) ->
    cat.get "rank"

  rankUp: (cat) ->
    
    # find the cat we're going to swap ranks with
    rankToSwap = cat.get("rank") - 1
    otherCat = @at(rankToSwap - 1)
    
    # swap ranks
    cat.rankUp()
    otherCat.rankDown()

  rankDown: (cat) ->
    
    # find the cat we're going to swap ranks with
    rankToSwap = cat.get("rank") + 1
    otherCat = @at(rankToSwap - 1)
    
    # swap ranks
    cat.rankDown()
    otherCat.rankUp()


class AngryCatView extends Backbone.Marionette.ItemView
  template: "#angry_cat-template"
  tagName: "tr"
  className: "angry_cat"
  events:
    "click .rank_up img": "rankUp"
    "click .rank_down img": "rankDown"
    "click a.disqualify": "disqualify"

  initialize: ->
    @listenTo @model, "change:votes", @render

  rankUp: ->
    @model.addVote()
    MyApp.trigger "rank:up", @model

  rankDown: ->
    @model.addVote()
    MyApp.trigger "rank:down", @model

  disqualify: ->
    MyApp.trigger "cat:disqualify", @model
    @model.destroy()


class AngryCatsView extends Backbone.Marionette.CompositeView
  tagName: "table"
  id: "angry_cats"
  className: "table-striped table-bordered"
  template: "#angry_cats-template"
  itemView: AngryCatView
  initialize: ->
    @listenTo @collection, "sort", @renderCollection

  appendHtml: (collectionView, itemView) ->
    collectionView.$("tbody").append itemView.el


MyApp.addInitializer (options) ->
  angryCatsView = new AngryCatsView(collection: options.cats)
  MyApp.mainRegion.show angryCatsView

$ ->
  cats = new AngryCats([
    new AngryCat(
      name: "Wet Cat"
      image_path: "images/cat2.jpg"
    )
    new AngryCat(
      name: "Bitey Cat"
      image_path: "images/cat1.jpg"
    )
    new AngryCat(
      name: "Surprised Cat"
      image_path: "images/cat3.jpg"
    )
    new AngryCat(
      name: "Cranky Cat"
      image_path: "images/cat4.jpg"
    )
  ])
  MyApp.start cats: cats
  
