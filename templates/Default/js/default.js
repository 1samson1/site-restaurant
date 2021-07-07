$(function () {

    /* LOGIN PANEL SCRIPTS +++++++++++++++++++++++++++++++++++++++++++++++++++ */
    $('.login-link').on('click',function () {
        $('.bg-login-panel, .login-panel').fadeIn(500)
        $('body').css('overflow','hidden')
    })
    $('.bg-login-panel, .close').on('click',function () {
        $('.bg-login-panel, .login-panel').fadeOut(500)
        $('body').css('overflow','')
    })
    
    /* FORM INPUTS SCRIPTS +++++++++++++++++++++++++++++++++++++++++++++++++++ */
    
    $('.form-group-password .password-show').on('click',function () {        
        $(this).toggleClass('password-show-hidden')
        let input = $(this).siblings('.form-control')
        let type = input.attr('type') == 'password'? 'text' : 'password'
        input.attr('type', type)
    })

    /* TOVARS COUNT */

    $('.tovars').each(function(){
        if($(this).children('.container-body').children().length % 2 == 1){
            $(this).addClass('tovars-odd')
        }
        else {
            $(this).addClass('tovars-even')
        }
    });

    $('.opener').opener();
})
