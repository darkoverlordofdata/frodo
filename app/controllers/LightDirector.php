<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Lightdirector extends CI_Controller {

    var $app = 'lightdirector';
    //  rhc set-env LIGHTDIRECTOR_FBAPPID=012345678901234 -a front -n d16a
    //  rhc set-env LIGHTDIRECTOR_FBAPPSECRET=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -a front -n d16a


    function __construct()
    {
        parent::__construct();
    }

    function index() {

        $this->load->library('facebook', array(
            'appId'  => getenv("LIGHTDIRECTOR_FBAPPID"),
            'secret' => getenv("LIGHTDIRECTOR_FBAPPSECRET")
        ));


        // Get the current user
        $user_id = $this->facebook->getUser();
        // If the user has not installed the app, redirect them to the Login Dialog
        if (!$user_id) {
            $loginUrl = $this->facebook->getLoginUrl(array(
                'scope'         => '',
                'redirect_uri'  => 'https://apps.facebook.com/' . $this->app . '/',
            ));
            // Do the redirection
            print('<script> top.location.href=\'' . $loginUrl . '\'</script>');
        }
        // If we are already authorized, get the users profile information
        $data['user_profile'] = $this->facebook->api('/me','GET');

        $this->load->view('lightdirector/view', $data);

    }

   function baseline() {

        $this->load->library('facebook', array(
            'appId'  => getenv("LIGHTDIRECTOR_FBAPPID"),
            'secret' => getenv("LIGHTDIRECTOR_FBAPPSECRET")
        ));


        // Get the current user
        $user_id = $this->facebook->getUser();
        // If the user has not installed the app, redirect them to the Login Dialog
        if (!$user_id) {
            $loginUrl = $this->facebook->getLoginUrl(array(
                'scope'         => '',
                'redirect_uri'  => 'https://apps.facebook.com/' . $this->app . '/',
            ));
            // Do the redirection
            print('<script> top.location.href=\'' . $loginUrl . '\'</script>');
        }
        // If we are already authorized, get the users profile information
        $data['user_profile'] = $this->facebook->api('/me','GET');

        $this->load->view('lightdirector/baseline_view', $data);

    }

    function run() {

        $this->load->library('facebook', array(
            'appId'  => getenv("LIGHTDIRECTOR_FBAPPID"),
            'secret' => getenv("LIGHTDIRECTOR_FBAPPSECRET")
        ));


        // Get the current user
        $user_id = $this->facebook->getUser();
        // If the user has not installed the app, redirect them to the Login Dialog
        if (!$user_id) {
            $loginUrl = $this->facebook->getLoginUrl(array(
                'scope'         => '',
                'redirect_uri'  => 'https://apps.facebook.com/' . $this->app . '/',
            ));
            // Do the redirection
            print('<script> top.location.href=\'' . $loginUrl . '\'</script>');
        }
        // If we are already authorized, get the users profile information
        $data['user_profile'] = $this->facebook->api('/me','GET');

        $this->load->view('lightdirector/run_view', $data);

    }

    function pixelmap() {

        $this->load->library('facebook', array(
            'appId'  => getenv("LIGHTDIRECTOR_FBAPPID"),
            'secret' => getenv("LIGHTDIRECTOR_FBAPPSECRET")
        ));


        // Get the current user
        $user_id = $this->facebook->getUser();
        // If the user has not installed the app, redirect them to the Login Dialog
        if (!$user_id) {
            $loginUrl = $this->facebook->getLoginUrl(array(
                'scope'         => '',
                'redirect_uri'  => 'https://apps.facebook.com/' . $this->app . '/',
            ));
            // Do the redirection
            print('<script> top.location.href=\'' . $loginUrl . '\'</script>');
        }
        // If we are already authorized, get the users profile information
        $data['user_profile'] = $this->facebook->api('/me','GET');

        $this->load->view('lightdirector/pixelmap_view', $data);

    }

    function goodmorning() {

        $this->load->library('facebook', array(
            'appId'  => getenv("LIGHTDIRECTOR_FBAPPID"),
            'secret' => getenv("LIGHTDIRECTOR_FBAPPSECRET")
        ));


        // Get the current user
        $user_id = $this->facebook->getUser();
        // If the user has not installed the app, redirect them to the Login Dialog
        if (!$user_id) {
            $loginUrl = $this->facebook->getLoginUrl(array(
                'scope'         => '',
                'redirect_uri'  => 'https://apps.facebook.com/' . $this->app . '/',
            ));
            // Do the redirection
            print('<script> top.location.href=\'' . $loginUrl . '\'</script>');
        }
        // If we are already authorized, get the users profile information
        $data['user_profile'] = $this->facebook->api('/me','GET');

        $this->load->view('lightdirector/goodmorning_view', $data);

    }

    function fromphone() {

        $this->load->library('facebook', array(
            'appId'  => getenv("LIGHTDIRECTOR_FBAPPID"),
            'secret' => getenv("LIGHTDIRECTOR_FBAPPSECRET")
        ));


        // Get the current user
        $user_id = $this->facebook->getUser();
        // If the user has not installed the app, redirect them to the Login Dialog
        if (!$user_id) {
            $loginUrl = $this->facebook->getLoginUrl(array(
                'scope'         => '',
                'redirect_uri'  => 'https://apps.facebook.com/' . $this->app . '/',
            ));
            // Do the redirection
            print('<script> top.location.href=\'' . $loginUrl . '\'</script>');
        }
        // If we are already authorized, get the users profile information
        $data['user_profile'] = $this->facebook->api('/me','GET');

        $this->load->view('lightdirector/fromphone_view', $data);

    }
}