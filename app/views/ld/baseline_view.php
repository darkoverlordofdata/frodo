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
</head>
<body>
<div id="fb-root"></div>
<script>(function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/all.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));</script>

<div id="welcome">
    Light Director Prototypes Studio ® [<?php echo $user_profile['name'];?>]
</div>
<br />
<br />
<br />
<br />
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


<br />
<br />
<br />
<br />
<a href="/lightdirector/">Back</a>

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/knockout/3.0.0/knockout-min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.gridster/0.5.0/jquery.gridster.min.js"></script>
<script src="/js/app.min.js"></script>
</body>
</html>
