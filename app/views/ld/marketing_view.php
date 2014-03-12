<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>light-map</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet" />
    <link href="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.1.1/css/bootstrap-theme.css" rel="stylesheet" />
    <link media="all" rel="stylesheet" href="/css/openshift.css" type="text/css" />
    <link href="//cdnjs.cloudflare.com/ajax/libs/jquery.gridster/0.5.0/jquery.gridster.min.css" rel="stylesheet" />
    <link href="/css/site.css" rel="stylesheet" />
    <link href="/css/jumbotron.css" rel="stylesheet">
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="//oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="//oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div id="fb-root"></div>
<script>
(function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/all.js";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
</script>


<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">Light Director Prototypes Studio ®</a>
    </div>
    <div class="navbar-collapse collapse">
      <form class="navbar-form navbar-right" role="form">
        <div class="form-group">
          <input type="text" placeholder="<?php echo $user_profile['name'];?>" class="form-control">
        </div>
      </form>
    </div><!--/.navbar-collapse -->
  </div>
</div>

<!-- Main jumbotron for a primary marketing message or call to action -->
<div class="container">

  <h1>Pixel Map</h1>
  <p>Consider each square as bound to a piece of data in a backend system. In this example, each
    square represents a 12 bit hex color BGR (blue, green, red). This data is static and in the
    document. In reality, the data would be coming from some back-end system - but the UI and the
    way to access it will feel exactly the same.</p>
  <p><a class="btn btn-primary btn-lg" href="/lightdirector/run/" role="button">Run &raquo;</a></p>

</div>


<div class="container">
  <!-- Example row of columns -->
  <div class="row">
    <div class="col-md-4">

      <h2>Pixel Map</h2>
      <p>A mockup of the Pixel Map application.</p>
      <p><a class="btn btn-default" href="/lightdirector/pixelmap/" role="button">View details &raquo;</a></p>

    </div>
    <div class="col-md-4">

      <h2>Good Morning New York City!</h2>
      <p>In this case, the lights are arranged in a pattern
         allowing one to create an approximation of the sun’s
         position over relative to a map of the earth.
      </p>
      <p><a class="btn btn-default" href="/lightdirector/goodmorning/" role="button">View details &raquo;</a></p>

   </div>
    <div class="col-md-4">

      <h2>House Lights from Phone</h2>
      <p>Software connects to Bluetooth Radio and
         communicates with the lights allowing one to change
         their color and brightness.
      </p>
      <p><a class="btn btn-default" href="/lightdirector/fromphone/" role="button">View details &raquo;</a></p>

   </div>
  </div>
</div> <!-- /container -->
<hr>
<br />
<br />
<br />
<br />
<footer>
<div class="container muted">
    <div class="logo"><a href="https://www.openshift.com/"></a></div>
</div>
</footer>
<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/knockout/3.0.0/knockout-min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.gridster/0.5.0/jquery.gridster.min.js"></script>
<script src="/js/app.min.js"></script>
</body>
</html>
