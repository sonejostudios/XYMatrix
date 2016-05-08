declare name        "XYMatrix";
declare version     "1.0";
declare author      "Vincent Rateau, GRAME";
declare license     "GPL v3";
declare reference   "www.sonejo.net";
declare description	"XY Surround Matrix for one Source (Mono Input) with 4 Outputs (Left, Right, Surround Left, Surround Right) and Position Lock.";


import("effect.lib");


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
	xpos = hslider("xpos[midi: ctrl 1]", 0, 0, 1, 0.01) : SH(lock) : smooth(0.999) : hbargraph("X", 0, 1);
	ypos = hslider("ypos[midi: ctrl 2]", 0, 0, 1, 0.01) : SH(lock) : smooth(0.999) : 1-_ : vbargraph("Y", 0, 1) : 1-_ ;
};


//lock with S&H
SH(trig,x) = (*(1 - trig) + x * trig) ~_;
lock = 1-checkbox("Lock Position");

//Re-route signals
routing(a,b,c,d) = a, c, b, d;


// graphs / levels / speakers / ouputs
graphs = vgroup("Outputs", hgroup("[0]Front", boxL, boxR), hgroup("[1]Back",boxSL, boxSR)) 
with{
	boxL = amp_follower(0.5) : vbargraph("Left (0)", 0, 0.5);
	boxR = amp_follower(0.5) : vbargraph("Right (1)", 0, 0.5);
	boxSL = amp_follower(0.5) : vbargraph("Surround Left (2)", 0, 0.5);
	boxSR = amp_follower(0.5) : vbargraph("Surround Right (3)", 0, 0.5);
};





