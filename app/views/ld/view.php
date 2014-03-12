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
  <img src="/images/leds.png" width="939" height="323"/>
  <hr>
</div>


<div class="container">
  <!-- Example row of columns -->
  <div class="row">

    <!--This div is the continer of the UL element that Gridster.JS controls.  Gridster is instructed to
        start using KnockoutJS template binding and the afterRender property.  After the element is rendered,
        call initializeGridster on the viewmodel it is bound to... (myViewModel)-->

    <div class="gridster"
         data-bind="
                template: {
                    afterRender: init
                }">

        <!--Knockout foreach -> iterate through the elements in the viewmodel's myData property and
            build something inside this tag using it as the data context to bind to.  and stuff. -->

        <ul data-bind="foreach: myData">

            <!--Knockout binding style attributes for color and size and some elements that Gridster
            uses to position each element most importantly (at the end of this long line)
            call the addGridster function on the Knockout binding's root element ($root)
            afterRendering this new li.  Somehow (not sure how) javascript/knockout knows to
            the appropriate paramenters (namely, the data this LI is bound to.)-->

            <li data-bind="
                        attr:{
                            'data-sizex':sizex,
                            'data-sizey':sizey,
                            'data-row':row,
                            'data-col':col
                        },
                        style: {
                            borderStyle: 'solid',
                            borderWidth: '1px',
                            borderColor: getBorderColor(BGR),
                            backgroundColor: getBackgroundColor(BGR)
                        },
                        template: {
                            afterRender: $root.addItem
                        } ">

                <!--This element holds the text depicting the hex 12 bit representation of color.
            I see two ways one can style this.  I do both in the span below to demonstrate
                the point.  Not sure how presidence is calculated between the two ways.
                (who wins if both set?)

            1. Standard HTML CSS styling

            2. Knockout style binding...http://knockoutjs.com/documentation/style-binding.html

            Knockout uses some odd stuff for binding to the style but it is sure helpful for calling
            JavaScript functions to determine how to style things based on backing data.

                <!--Each list item will have a BGR property with a hex representation of a color -->
                <!--Since the background of this element will have this color, we need to calculate the best font color (black or white)
            This is typical style binding syntax for Knockout-->
                    <span data-bind="
                              text: BGR,
                              style: {
                                color: getBorderColor(BGR)
                              } ">
                    </span>
            </li>
        </ul>
    </div>
  </div>
  <hr>
</div> <!-- /container -->

<!-- Back to start -->
<div class="container">
<p><a class="btn btn-primary btn-lg" href="/lightdirector" role="button">Back &raquo;</a></p>
</div>

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
