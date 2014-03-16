DEBUG_MODE = false
selectedMealIndex = -1
selectedPlaceIndex = -1
selectedPlaceID = null
nearbyPlaces = null
myFriends = null
currentlySelectedPlaceElement = null
selectedFriends = {}
# DATA

meals = [
  {
    id: "cheeseburger"
    title: "Cheeseburger"
    url: "http://nodescrumptious.azurewebsites.net/meals/cheeseburger"
  }
  {
    id: "chinese"
    title: "Chinese"
    url: "http://nodescrumptious.azurewebsites.net/meals/chinese"
  }
  {
    id: "french"
    title: "French"
    url: "http://nodescrumptious.azurewebsites.net/meals/french"
  }
  {
    id: "hotdog"
    title: "Hot Dog"
    url: "http://nodescrumptious.azurewebsites.net/meals/hotdog"
  }
  {
    id: "indian"
    title: "Indian"
    url: "http://nodescrumptious.azurewebsites.net/meals/indian"
  }
  {
    id: "italian"
    title: "Italian"
    url: "http://nodescrumptious.azurewebsites.net/meals/italian"
  }
  {
    id: "pizza"
    title: "Pizza"
    url: "http://nodescrumptious.azurewebsites.net/meals/pizza"
  }
]


# UTILITIES

# For logging responses
logResponse = (response) ->
  console.log "The response was", response  if typeof console isnt "undefined"

# AUTHENTICATION

# Handle status changes
handleStatusChange = (response) ->
  if response.authResponse
    logResponse response
    window.location.hash = "#menu"
    updateUserInfo response
  else
    window.location.hash = "#login"
updateUserInfo = (response) ->
  FB.api "/me",
    fields: "name,first_name,picture"
  , (response) ->
    logResponse response
    output = ""
    output += "<img src=\"" + response.picture.data.url + "\" width=\"25\" height=\"25\"></img>"
    output += " " + response.first_name
    $("#user-identity").html output


# GRAPH API (OPEN GRAPH)
handleOGSuccess = ->
  logResponse "[handleOGSuccess] done."
  showPublishConfirmation()
  
  # Clear out selections
  selectedMealIndex = -1
  selectedPlaceIndex = -1
  selectedPlaceID = null
  currentlySelectedPlaceElement = null
  selectedFriends = {}
  
  # Reset the placeholders
  $("#select-meal").html "Select one"
  $("#select-location").html "Select one"
  $("#select-friends").html "Select friends"
  
  # Disable the announce button
  $("#announce").addClass "ui-disabled"
handleGenericError = (e) ->
  logResponse "Error ..." + JSON.stringify(e)
handlePublishOGError = (e) ->
  logResponse "Error publishing ..." + JSON.stringify(e)
  errorCode = e.code
  logResponse "Error code ..." + errorCode
  
  # Request publish actions, probably missing piece here
  reauthorizeForPublishPermissions()  if errorCode is "200"
reauthorizeForPublishPermissions = ->
  logResponse "[reauthorizeForPublishPermissions] asking for additional permissions."
  
  # If successful, try publishing action again
  # else, just show error
  FB.login ((response) ->
    if not response or response.error
      handleGenericError response.error
    else
      publishOGAction response
  ),
    scope: "publish_actions"

publishOGAction = (response) ->
  errorHandler = null
  
  # Handle if we came in via a reauth.
  # Also avoid loops, set generic error
  # handler if already reauthed.
  if not response or response.error
    errorHandler = handlePublishOGError
  else
    errorHandler = handleGenericError
  logResponse "Publishing action..."
  params = meal: meals[selectedMealIndex].url
  params.place = selectedPlaceID  if selectedPlaceID
  friendIDArrays = []
  for friendId of selectedFriends
    friendIDArrays.push friendId  if selectedFriends.hasOwnProperty(friendId)
  params.tags = friendIDArrays.join()  if friendIDArrays.length > 0
  logResponse "Publish params " + JSON.stringify(params)
  $.ajax(
    url: "/announce"
    type: "post"
    data: params
  ).success((result) ->
    handleOGSuccess result
  ).error (xhr) ->
    try
      response = JSON.parse(xhr.responseText)
      window.location = response.redirectUri  if response.error and response.redirectUri


# todo: handle error

#	FB.api(";",
#    	"POST",
#    	params,
#    	function (response) {
#    		logResponse(response);
#    		if (!response || response.error) {
#    			errorHandler(response.error);
#    		} else {
#    			handleOGSuccess(response);
#    		}
#    	}
#	);
showPublishConfirmation = ->
  $("#confirmation").append "<p>Publish successful</p>"
  
  # Fade out the message
  $("#confirmation").fadeOut 3000, ->
    $("#confirmation").html ""
    $("#confirmation").show()


# DATA FETCH AND DISPLAY

# Meals
displayMealList = ->
  
  # Meal list
  logResponse "[displayMealList] displaying meal list."
  tmpl = $("#meal_list_tmpl").html()
  output = Mustache.to_html(tmpl, meals)
  $("#meal-list").html(output).listview "refresh"
displaySelectedMeal = ->
  logResponse "[displaySelectedMeal] displaying selected meal."
  meal = meals[selectedMealIndex]
  
  # Set up meal display
  tmpl = $("#selected_meal_tmpl").html()
  output = Mustache.to_html(tmpl, meal)
  $("#selected_meal").html output

# Nearby Places
window.getNearby = ->
  
  # Check for and use cached data
  return  if nearbyPlaces
  logResponse "[getNearby] get nearby data."
  
  # First use browser's geolocation API to obtain location
  navigator.geolocation.getCurrentPosition (location) ->
    
    #curLocation = location;
    logResponse location
    $.ajax(
      url: "/search"
      data:
        type: "place"
        q: "restaurant"
        center: location.coords.latitude + "," + location.coords.longitude
        distance: 1000
        fields: "id,name,picture"
    ).success((response) ->
      nearbyPlaces = response.data
      logResponse nearbyPlaces
      displayPlaces nearbyPlaces
    ).error (err) ->
      logResponse "Error fetching nearby place data."


displayPlaces = (places) ->
  
  # Places list
  logResponse "[displayPlaces] displaying nearby list."
  tmpl = $("#places_list_tmpl").html()
  output = Mustache.to_html(tmpl, places)
  $("#places-list").html(output).listview "refresh"

# Friends
window.getFriends = ->
  
  # Check for and use cached data
  return  if myFriends
  logResponse "[getFriends] get friend data."
  $.ajax(url: "/friends").success((response) ->
    myFriends = response.data
    logResponse myFriends
    displayFriends myFriends
  ).error (err) ->
    logResponse "Error fetching friend data."

displayFriends = (friends) ->
  
  # Friends list
  logResponse "[displayFriends] displaying friend list."
  tmpl = $("#friends_list_tmpl").html()
  output = Mustache.to_html(tmpl, friends)
  $("#friends-list").html(output).listview "refresh"

# DOCUMENT-READY FUNCTIONS
$ ->
  # Click handlers

  # Logout click handler
  $("#logout").click ->
    window.location = "/logout"
    false

  # Announce click handler
  $("#announce").click ->
    publishOGAction null

  # Meal selection click handler
  $("#meal-list").on "click", "li", ->
    selectedMealIndex = $(this).index()
    logResponse "Link in meal listview clicked... " + selectedMealIndex
    displaySelectedMeal()

  $("#detail-meal-select").click ->
    $("#announce").removeClass "ui-disabled"
    $("#select-meal").html meals[selectedMealIndex].title

  # Place selection click handler
  $("#places-list").on "click", "li", ->
    selectionId = $(this).attr("data-name")
    logResponse "Selected place " + selectionId
    selectionStatus = $(this).attr("data-icon")
    if selectionStatus is "false"
      # De-select any previously selected place
      currentlySelectedPlaceElement.buttonMarkup icon: false  if currentlySelectedPlaceElement
      # Place has been selected.
      $(this).buttonMarkup icon: "check"
      # Set the selected place info
      selectedPlaceID = selectionId
      selectedPlaceIndex = $(this).index()
      $("#select-location").html nearbyPlaces[selectedPlaceIndex].name
      # Set the currently selected place element
      currentlySelectedPlaceElement = $(this)
    else
      # Previously selected place has been deselected
      $(this).buttonMarkup icon: false
      # Reset the selected place info
      selectedPlaceID = null
      selectedPlaceIndex = -1
      $("#select-location").html "Select one"

  # Friend selection click handler
  $("#friends-list").on "click", "li", ->
    selectionId = $(this).attr("data-name")
    logResponse "Selected friend " + selectionId
    selectedIndex = $(this).index()
    selectionStatus = $(this).attr("data-icon")
    if selectionStatus is "false"
      # Friend has been selected.
      $(this).buttonMarkup icon: "check"
      # Add to friend ID to selectedFriends associative array
      selectedFriends[selectionId] = myFriends[selectedIndex].name
    else
      # Previously selected friend has been deselected
      $(this).buttonMarkup icon: false
      # Remove the friend id
      delete selectedFriends[selectionId]
    friendNameArray = []
    for friendId of selectedFriends
      friendNameArray.push selectedFriends[friendId]  if selectedFriends.hasOwnProperty(friendId)
    if friendNameArray.length > 2
      otherFriends = friendNameArray.length - 1
      $("#select-friends").html friendNameArray[0] + " and " + otherFriends + " others"
    else if friendNameArray.length is 2
      $("#select-friends").html friendNameArray[0] + " and " + friendNameArray[1]
    else if friendNameArray.length is 1
      $("#select-friends").html friendNameArray[0]
    else
      $("#select-friends").html "Select friends"
    logResponse "Current select friends list: " + selectedFriends


$(document).delegate "#meals", "pageinit", ->
  displayMealList()

$("body").bind "hideOpenMenus", ->
  $("ul:jqmData(role='menu')").find("li > ul").hide()

menuHandler = (e) ->
  $("body").trigger "hideOpenMenus"
  $(this).find("li > ul").show()
  e.stopPropagation()

$("ul:jqmData(role='menu') li > ul li").click (e) ->
  $("body").trigger "hideOpenMenus"
  e.stopPropagation()

$("body").delegate "ul:jqmData(role='menu')", "click", menuHandler
$("body").click (e) ->
  $("body").trigger "hideOpenMenus"

