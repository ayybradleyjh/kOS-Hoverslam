clearscreen.
set radarOffset to 9.814.					// The value of alt:radar when landed (on gear)
lock trueRadar to alt:radar - radarOffset.			// Offset radar to get distance from gear to ground
lock g to constant:g * body:mass / body:radius^2.		// Gravity (m/s^2)
lock maxDecel to (ship:availablethrust / ship:mass) - g.	// Maximum deceleration possible (m/s^2)
lock stopDist to ship:verticalspeed^2 / (2 * maxDecel).		// The distance the burn will require
lock stopTime to abs(ship:verticalspeed) / maxDecel.		// The time the burn will require
lock idealThrottle to stopDist / trueRadar.			// Throttle required for perfect hoverslam

WAIT UNTIL ship:verticalspeed < -1.
	print "Preparing for hoverslam...".
	rcs on.
	brakes on.
	lock steering to srfretrograde.
	when trueRadar < 1000 then {gear on.}

WAIT UNTIL trueRadar < stopDist.
	print "Performing hoverslam".
	lock throttle to idealThrottle.

WAIT UNTIL ship:verticalspeed > -0.01.
	print "Hoverslam completed".
	set ship:control:pilotmainthrottle to 0.
	rcs off.
