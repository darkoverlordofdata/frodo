require('coffee-script');
require('coffee-script/register');
var muninn = require('muninn');
muninn.init(__dirname);

fb = require('fb');
fb.options({
    appId:          muninn.config.fb.appId,
    appSecret:      muninn.config.fb.appSecret,
    redirectUri:    muninn.config.fb.redirectUri
});
fb.authenticate = function($code, $next) {
    return fb.api('oauth/access_token', {
        client_id: fb.options('appId'),
        client_secret: fb.options('appSecret'),
        redirect_uri: fb.options('redirectUri'),
        code: $code
    }, function($result) {
        if (!$result || $result.error) {
            $next($result.error);
        }
        return fb.api('oauth/access_token', {
            client_id: fb.options('appId'),
            client_secret: fb.options('appSecret'),
            grant_type: 'fb_exchange_token',
            fb_exchange_token: $result.access_token
        }, function($result) {
            if (!$result || $result.error) {
                return $next($result.error);
            } else {
                return $next(null, $result);
            }
        });
    });
};

muninn.start();