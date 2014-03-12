# https://apps.facebook.com/lightdirector/
# 100007901950326
# nikki_vwydyhk_sixx@tfbnw.net

#
# getContrastingColor
#
#   Choose the best text color to draw on a color
#
# @param hexcolor
# @returns 'black' or 'white'
#
getContrastingColor = (hexcolor) ->
  if parseInt(hexcolor, 16) > 0x7FFFFF then 'black' else 'white'

#
# define global helpers
#
do ->

  @getBorderColor = ($bgr) ->
    getContrastingColor($bgr.charAt(1) + '0' + $bgr.charAt(2) + '0' + $bgr.charAt(0) + '0')

  @getBackgroundColor = ($bgr) ->
    '#' + $bgr.charAt(2) + '0' + $bgr.charAt(1) + '0' + $bgr.charAt(0) + '0'

  return

#
# new up a viewmodel object where a bunch of stuff is done in the
# contstructor to fill it with data, then databind it to knockout
#
$ ->
  Viewmodel = require('./Viewmodel')

  myViewModel = new Viewmodel(require('./data')())
  ko.applyBindings myViewModel

