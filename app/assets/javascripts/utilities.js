function checkExistingUser(email){
    var $modal = $('#checkExistingUser');

    $.ajax({
        data: JSON.stringify({ email: email }),
        dataType: 'json',
        contentType: 'application/json',
        type: 'POST',
        url: '/users_check_exist.js'
    }).success(function (data) {
        console.log(data)
        if (data.length > 0){
            $('#checkExistingUserEmail').html(data[0].email);
            $modal.foundation('open');
        }
    }).fail(function () {
    });
};
