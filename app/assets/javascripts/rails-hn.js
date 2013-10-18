$(document).ready(function () {
    $(".vote-up, .vote-down").click(function (e) {
        e.preventDefault();
        $.ajaxSetup({headers: { 'Accept': 'application/json' }});
        var submission_id = $(this).attr('id')
        var current_vote_value = $('tr#'+submission_id).find("span")
        var vote_up_button = $("tr#"+submission_id).find("button:first")
        var vote_down_button = $("tr#"+submission_id).find("button:last")

        var vote_up_url = "/links/" + submission_id + "/votes/2"
        var vote_down_url = "/links/" + submission_id + "/votes/1"
        var vote_cancel_url = "/links/" + submission_id + "/votes/0"



        function postCallback(data){
            if(data.redirect){
                window.location.href = data.redirect;
            } else{
            }

        }

        function adjust_vote(amount){
            current_vote_value.html(parseInt(current_vote_value.html(), 10) + amount)
        }

        if ($(this).hasClass("vote-up")) {
            if ($(this).hasClass("vote-up-on")) {
                 $.post(vote_cancel_url, postCallback);
                adjust_vote(-1)

            } else {
                $.post(vote_up_url, postCallback)

                if (vote_down_button.hasClass("vote-down-on")) {
                        vote_down_button.toggleClass("vote-down-on")
                        adjust_vote(2)
                    } else {
                        adjust_vote(1)
                    }
            };
            $(this).toggleClass("vote-up-on")

        } else if ($(this).hasClass("vote-down")) {

            if ($(this).hasClass("vote-down-on")) {
                $.post(vote_cancel_url, postCallback)

                adjust_vote(1)

            } else {
                $.post(vote_down_url, postCallback)

                if (vote_up_button.hasClass("vote-up-on")) {
                        vote_up_button.toggleClass("vote-up-on")
                         adjust_vote(-2)
                    } else {
                         adjust_vote(-1)
                    }              
            };
            $(this).toggleClass("vote-down-on")
        };
    });



});
