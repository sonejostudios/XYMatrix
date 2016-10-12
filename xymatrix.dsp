declare name        "XYMatrix";
declare version     "1.0";
declare author      "Vincent Rateau, GRAME";
declare license     "GPL v3";
declare description	"XY Surround Matrix for one Source (Mono Input) with 4 Outputs (Left, Right, Surround Left, Surround Right) and Position Lock.";


import("stdfaust.lib");


// XY Surround Matrix for one Source (Mono Input) with 4 Outputs (Left, Right, Surround Left, Surround Right) and Position Lock.
// Use an XY controller for best workflow (e.g Cadence XY-Controller)
// Midi Bindings: xpos[midi: ctrl 1] , ypos[midi: ctrl 2]


process = hgroup("XY Surround Matrix (1x4)",xymatrix) ;


xymatrix = _ <: vgroup("Controls", sigx : sigy) : routing <: _,_,_,_, (graphs:>_) : _,_,_, (_,_ : attach)
	with{
		//matrix gains
		sigx = signalx, signalx;
		signalx(a, b) = (a*(1-xpos:sqrt)), (a*(xpos:sqrt));

		sigy(a,b,c,d) = ((a,c) : signaly), ((b,d) : signaly);
		signaly(a, b) = (b*(1-ypos:sqrt)), (b*(ypos:sqrt));

		//gui
		xpos = hslider("xpos[midi: ctrl 1]", 0, 0, 1, 0.001) : ba.sAndH(lock) : si.smooth(0.999) : hbargraph("X", 0, 1);
		ypos = hslider("ypos[midi: ctrl 2]", 0, 0, 1, 0.001) : ba.sAndH(lock) : si.smooth(0.999) : 1-_ : vbargraph("Y", 0, 1) : 1-_ ;
	};


//lock with sAndH (Sample and Hold)
lock = 1-checkbox("Lock Position");

//Re-route signals
routing(a,b,c,d) = a, c, b, d;


// graphs / levels / speakers / ouputs
graphs = vgroup("Outputs", hgroup("[0]Front", boxL, boxR), hgroup("[1]Back",boxSL, boxSR))
	with{
		boxL = an.amp_follower(0.5) : vbargraph("Left (0)", 0, 1);
		boxR = an.amp_follower(0.5) : vbargraph("Right (1)", 0, 1);
		boxSL = an.amp_follower(0.5) : vbargraph("Surround Left (2)", 0, 1);
		boxSR = an.amp_follower(0.5) : vbargraph("Surround Right (3)", 0, 1);
	};
