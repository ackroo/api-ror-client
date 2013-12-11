/* Create timer */
var inactiveTimer = $.timer(showInactiveDialog, 600000, false);
var logoutTimer = $.timer(inactiveLogout, 650000, false);

/* Adds mouse-move listener for body, to reset inactive timer */
$(document).mousemove(startInactiveTimer);

/* Adds listener for when modal is shown */
$('#inactiveModal').on('show', function () {
    logoutTimer.play(true);
    console.log("Starting logout timer");
})

/* Adds a listener for when the modal is hidden */
$('#inactiveModal').on('hide', function () {
    logoutTimer.stop();
})

/* Starts timer */
startInactiveTimer();


/* FUNCTIONS */
/* Starts the timer to see if a user is inactive */
function startInactiveTimer()
{
	inactiveTimer.play(true);
}

/* Shows the inactive dialog and starts the logout timer */
function showInactiveDialog() 
{
	$("#inactiveModal").modal('show');
	$("#inactiveClose").focus();
}

/* Perform logout when user does not respond */
function inactiveLogout()
{
	window.location = "/login/logout";
}