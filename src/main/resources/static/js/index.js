/**
 * login.js
 */

$(document).ready(function(){
    $('.header-button').css("color","#ffffff")
    $('.header-button').css("border-color","#ffffff")
    $('.health_button').on('click', function(){
        console.log("sdfsadf");
        $('#disease').css("height", "100px")
        $('#listSlider1').css("height", "100px")
        $('#disease').css("transition-duration","500ms")
        $('#listSlider1').css("transition-duration","500ms")
    });
});
