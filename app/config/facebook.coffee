module.exports =
#  appId: process.env.FBAPPID
#  appSecret: process.env.FBAPPSECRET
#
  if process.env.OPENSHIFT_APP_DNS?

    rootUrl:        "https://#{process.env.OPENSHIFT_APP_DNS}"
    appId:          process.env.FBAPPID
    appSecret:      process.env.FBAPPSECRET
    appNamespace:   "frodo-demo"
    redirectUri:    "https://#{process.env.OPENSHIFT_APP_DNS}/login/callback"

  else
    rootUrl:        "http://localhost:3000/"
    appId:          "1478930342328388"
    appSecret:      "58e05aa1a2a2909e95676524c4cba73c"
    appNamespace:   "frodo-demo"
    redirectUri:    "http://localhost:3000/login/callback"


