include <field.scad>;
include <parts.scad>;

// Chassis parameters
CHASSIS_WIDTH = 28;
CHASSIS_LENGTH = 28;
CHASSIS_CUTOUT_WIDTH = 16;
CHASSIS_FRONT_BUMPER_WIDTH = (CHASSIS_WIDTH-CHASSIS_CUTOUT_WIDTH) / 2;
CHASSIS_CUTOUT_DEPTH = 9;

// Chassis box tube parameters
BOX_TUBE_WIDTH = 1;
BOX_TUBE_HEIGHT = 2;

// Superstructure box tube parameters
SUPER_TUBE_WIDTH = 1;
SUPER_TUBE_HEIGHT = 1;
SUPER_HEIGHT = 3;

// Bumper parameters
BUMPER_THICK = 3.25;
BUMPER_HEIGHT = 5;

// Wheel parameters
WHEEL_DIAMETER = 6;
WHEEL_WIDTH = 1.5;
WHEEL_X_SPACING = 0.125; // Distance from edge of wheel to left and right box tubing.
WHEEL_Y_SPACING = 0.1875; // Distance from wheel to front and rear box tubing.
WHEEL_CENTER_OFFSET = 0.375; // Vertical offset for the wheels into the box tube.

// Climber parameters
CLIMBER_Y_LOC = 8.85;
CLIMBER_Z_OFFSET = SUPER_HEIGHT-2.5;
CLIMBER_CENTER_WIDTH = 2.5;
CLIMBER_WINCH_DIAMETER = 1.5;

// Extra bar parameters
BAR_DIAMETER = 1;
BAR_HEIGHT = 4;

// Other derived, useful parameters
BASE_CHASSIS_HEIGHT = (WHEEL_DIAMETER-BOX_TUBE_HEIGHT)/2-WHEEL_CENTER_OFFSET;
BUMPER_WIDTH = (CHASSIS_WIDTH-CHASSIS_CUTOUT_WIDTH)/2;

module bumpers(width, length, cutout_width, thick, height) {
    translate([-thick,-thick,0]) cube([thick,length+2*thick,height]);
    translate([-thick,-thick,0]) cube([width+2*thick,thick,height]);
    translate([width,-thick,0])  cube([thick,length+2*thick,height]);
    
    translate([-thick,length,0])cube([thick+(width-cutout_width)/2,thick,height]);
    translate([(width+cutout_width)/2,length,0])cube([thick+(width-cutout_width)/2,thick,height]);
}

module box_chassis(width, length, cutout_width, cutout_depth, climber_y_loc, climber_center_width) {
    
    bumper_width = (width-cutout_width)/2;
    
    // ---- CHASSIS ----
    
    // Outer 3 beams
    cube([width,BOX_TUBE_WIDTH,BOX_TUBE_HEIGHT]);
    translate([0,0,0]) cube([BOX_TUBE_WIDTH,length,BOX_TUBE_HEIGHT]);
    translate([width-BOX_TUBE_WIDTH,0,0]) cube([BOX_TUBE_WIDTH,length,BOX_TUBE_HEIGHT]);

    // Front 2 bumpers
    translate([0,length-BOX_TUBE_WIDTH,0]) cube([bumper_width,BOX_TUBE_WIDTH,BOX_TUBE_HEIGHT]);
    translate([width-bumper_width,length-BOX_TUBE_WIDTH,0]) cube([bumper_width,BOX_TUBE_WIDTH,BOX_TUBE_HEIGHT]);
    
    // Inner two channels
    translate([bumper_width-BOX_TUBE_WIDTH,0,0]) cube([BOX_TUBE_WIDTH,length,BOX_TUBE_HEIGHT]);
    translate([width-bumper_width,0,0]) cube([BOX_TUBE_WIDTH,length,BOX_TUBE_HEIGHT]);

    // Cutout bridge
    translate([bumper_width,length-cutout_depth-BOX_TUBE_WIDTH,0]) cube([cutout_width,BOX_TUBE_WIDTH,BOX_TUBE_HEIGHT]);
    
    // Climber bottom beam
    translate([bumper_width,climber_y_loc-BOX_TUBE_HEIGHT/2,CLIMBER_Z_OFFSET]) cube([cutout_width,BOX_TUBE_HEIGHT,BOX_TUBE_WIDTH]);
    
    // ---- SUPER ----
    translate([0,0,BOX_TUBE_HEIGHT]) {
        // -- Pillars --
        
        // Back pillars
        cube([SUPER_TUBE_WIDTH,SUPER_TUBE_HEIGHT,SUPER_HEIGHT]);
        translate([CHASSIS_WIDTH-BOX_TUBE_WIDTH,0,0]) cube([SUPER_TUBE_WIDTH,SUPER_TUBE_HEIGHT,SUPER_HEIGHT]);
        translate([(CHASSIS_WIDTH-BOX_TUBE_WIDTH)/2,0,0]) cube([SUPER_TUBE_WIDTH,SUPER_TUBE_HEIGHT,SUPER_HEIGHT]);
        
        FRONT_PILLAR_Y = 9.25; //length-cutout_depth-2*SUPER_TUBE_WIDTH;
        
        // Front outer pillars
        translate([0,FRONT_PILLAR_Y,0]) cube([SUPER_TUBE_WIDTH,SUPER_TUBE_HEIGHT,SUPER_HEIGHT]);
        translate([CHASSIS_WIDTH-SUPER_TUBE_WIDTH,FRONT_PILLAR_Y,0]) cube([SUPER_TUBE_WIDTH,SUPER_TUBE_HEIGHT,SUPER_HEIGHT]);
        
        // Front inner pillars
        translate([bumper_width-SUPER_TUBE_WIDTH,FRONT_PILLAR_Y,0]) cube([SUPER_TUBE_WIDTH,SUPER_TUBE_HEIGHT,SUPER_HEIGHT+BAR_HEIGHT]);
        translate([width-bumper_width,FRONT_PILLAR_Y,0]) cube([SUPER_TUBE_WIDTH,SUPER_TUBE_HEIGHT,SUPER_HEIGHT+BAR_HEIGHT]);
        
        // Side beams
        translate([width-SUPER_TUBE_WIDTH,0,SUPER_HEIGHT-SUPER_TUBE_HEIGHT]) cube([SUPER_TUBE_WIDTH,FRONT_PILLAR_Y,SUPER_TUBE_HEIGHT]);
        translate([0,0,SUPER_HEIGHT-SUPER_TUBE_HEIGHT]) cube([SUPER_TUBE_WIDTH,FRONT_PILLAR_Y,SUPER_TUBE_HEIGHT]);
        
        // Back beam
        translate([0,0,SUPER_HEIGHT-SUPER_TUBE_HEIGHT]) cube([width,SUPER_TUBE_WIDTH,SUPER_TUBE_HEIGHT]);
        
        // Front beams
        translate([0,FRONT_PILLAR_Y,SUPER_HEIGHT-SUPER_TUBE_HEIGHT]) cube([(width-CLIMBER_CENTER_WIDTH)/2,SUPER_TUBE_WIDTH,SUPER_TUBE_HEIGHT]);
        translate([(width+CLIMBER_CENTER_WIDTH)/2,FRONT_PILLAR_Y,SUPER_HEIGHT-SUPER_TUBE_HEIGHT]) cube([(width-CLIMBER_CENTER_WIDTH)/2,SUPER_TUBE_WIDTH,SUPER_TUBE_HEIGHT]);
        
        // Inner beams
        translate([(width-CLIMBER_CENTER_WIDTH)/2-SUPER_TUBE_WIDTH,0,SUPER_HEIGHT-SUPER_TUBE_HEIGHT]) cube([SUPER_TUBE_WIDTH,FRONT_PILLAR_Y,SUPER_TUBE_HEIGHT]);
        translate([(width+CLIMBER_CENTER_WIDTH)/2,0,SUPER_HEIGHT-SUPER_TUBE_HEIGHT]) cube([SUPER_TUBE_WIDTH,FRONT_PILLAR_Y,SUPER_TUBE_HEIGHT]);
        
        // Upper beams
        translate([BUMPER_WIDTH-SUPER_TUBE_HEIGHT,0,SUPER_HEIGHT]) cube([SUPER_TUBE_WIDTH,SUPER_TUBE_HEIGHT,BAR_HEIGHT]);
        translate([width-BUMPER_WIDTH,0,SUPER_HEIGHT]) cube([SUPER_TUBE_WIDTH,SUPER_TUBE_HEIGHT,BAR_HEIGHT]);
        
        // Upper beams
        translate([BUMPER_WIDTH-SUPER_TUBE_HEIGHT,0,SUPER_HEIGHT+BAR_HEIGHT-SUPER_TUBE_HEIGHT]) cube([SUPER_TUBE_WIDTH,FRONT_PILLAR_Y,SUPER_TUBE_HEIGHT]);
        translate([width-BUMPER_WIDTH,0,SUPER_HEIGHT+BAR_HEIGHT-SUPER_TUBE_HEIGHT]) cube([SUPER_TUBE_WIDTH,FRONT_PILLAR_Y,SUPER_TUBE_HEIGHT]);
        
        // Cross tube
        translate([BUMPER_WIDTH,SUPER_TUBE_WIDTH/2,SUPER_HEIGHT+BAR_HEIGHT-SUPER_TUBE_HEIGHT/2]) rotate([0,90,0]) cylinder(CHASSIS_CUTOUT_WIDTH,d=BAR_DIAMETER, $fn=60);
    }
}

module full_chassis() {
    
    // Box tube chassis
    color([.2,.2,.2]) {
        translate([0,0,BASE_CHASSIS_HEIGHT]) box_chassis(CHASSIS_WIDTH, CHASSIS_LENGTH, CHASSIS_CUTOUT_WIDTH, CHASSIS_CUTOUT_DEPTH, CLIMBER_Y_LOC, CLIMBER_CENTER_WIDTH);
    }
    
    // Bumpers
    color([0.7,0,0]) {
        translate([0,0,WHEEL_DIAMETER/2-BOX_TUBE_HEIGHT/2-WHEEL_CENTER_OFFSET]) bumpers(CHASSIS_WIDTH, CHASSIS_LENGTH, CHASSIS_CUTOUT_WIDTH, BUMPER_THICK, BUMPER_HEIGHT);
    }
    
    // (Lots) of wheels
    color([0,0,.3]) {
        translate([BOX_TUBE_WIDTH+WHEEL_X_SPACING,WHEEL_DIAMETER/2+BOX_TUBE_WIDTH+WHEEL_Y_SPACING,0]) wheel(WHEEL_DIAMETER, WHEEL_WIDTH);
        translate([BOX_TUBE_WIDTH+WHEEL_X_SPACING,CHASSIS_LENGTH-(WHEEL_DIAMETER/2+BOX_TUBE_WIDTH+WHEEL_Y_SPACING),0]) wheel(WHEEL_DIAMETER, WHEEL_WIDTH);
        translate([BOX_TUBE_WIDTH+WHEEL_X_SPACING,WHEEL_DIAMETER/2+BOX_TUBE_WIDTH+WHEEL_Y_SPACING+(CHASSIS_LENGTH-(WHEEL_DIAMETER+2.5))/2,0]) wheel(WHEEL_DIAMETER, WHEEL_WIDTH);
        
        translate([CHASSIS_WIDTH-WHEEL_WIDTH-BOX_TUBE_WIDTH-WHEEL_X_SPACING,WHEEL_DIAMETER/2+BOX_TUBE_WIDTH+WHEEL_Y_SPACING,0]) wheel(WHEEL_DIAMETER, WHEEL_WIDTH);
        translate([CHASSIS_WIDTH-WHEEL_WIDTH-BOX_TUBE_WIDTH-WHEEL_X_SPACING,CHASSIS_LENGTH-(WHEEL_DIAMETER/2+BOX_TUBE_WIDTH+WHEEL_Y_SPACING),0]) wheel(WHEEL_DIAMETER, WHEEL_WIDTH);
        translate([CHASSIS_WIDTH-WHEEL_WIDTH-BOX_TUBE_WIDTH-WHEEL_X_SPACING,WHEEL_DIAMETER/2+BOX_TUBE_WIDTH+WHEEL_Y_SPACING+(CHASSIS_LENGTH-(WHEEL_DIAMETER+2.5))/2,0]) wheel(WHEEL_DIAMETER, WHEEL_WIDTH);
    }
    
    // Corresponding (lots of pulleys)
    color([0,0.6,1.0]) {
        translate([BOX_TUBE_WIDTH+WHEEL_X_SPACING+WHEEL_WIDTH,WHEEL_DIAMETER/2+BOX_TUBE_WIDTH+WHEEL_Y_SPACING,WHEEL_DIAMETER/2]) pulley_30t();
    }
    
    color([0,0.4,0]) {
        GEARBOX_STYLE = "shifting";
        if(GEARBOX_STYLE == "shifting") {
            // Add dog-shifting gearboxes (tentatively)
            translate([CHASSIS_FRONT_BUMPER_WIDTH,CHASSIS_LENGTH/2,WHEEL_DIAMETER/2]) shifting_gearbox();
            translate([CHASSIS_WIDTH-CHASSIS_FRONT_BUMPER_WIDTH,CHASSIS_LENGTH/2,WHEEL_DIAMETER/2]) mirror([1,0,0]) shifting_gearbox();
        }
        else {
            // Add non-shifting gearboxes (tentatively)
            translate([CHASSIS_FRONT_BUMPER_WIDTH,CHASSIS_LENGTH/2,WHEEL_DIAMETER/2]) non_shifting_gearbox();
            translate([CHASSIS_WIDTH-CHASSIS_FRONT_BUMPER_WIDTH,CHASSIS_LENGTH/2,WHEEL_DIAMETER/2]) mirror([1,0,0]) non_shifting_gearbox();
        }
    }
    
    // Add in a battery?
    color([0.15,0.15,0.15]) {
        translate([CHASSIS_WIDTH/2,CHASSIS_LENGTH-CHASSIS_CUTOUT_DEPTH-BOX_TUBE_WIDTH-6.58-.25,(WHEEL_DIAMETER-BOX_TUBE_HEIGHT)/2-WHEEL_CENTER_OFFSET]) battery();
    }
    
    // And compressor?
    COMPRESSOR_TYPE = "little";
    COMPRESSOR_WIDTH = (COMPRESSOR_TYPE == "little") ? 2.11 : 3.27;
    color([0.2,0.2,0.2]) {
        translate([(CHASSIS_WIDTH+CHASSIS_CUTOUT_WIDTH)/2-BOX_TUBE_WIDTH-.5,BOX_TUBE_WIDTH+0.25,(WHEEL_DIAMETER-BOX_TUBE_HEIGHT)/2-WHEEL_CENTER_OFFSET]) if(COMPRESSOR_TYPE == "little") little_compressor();
        else big_compressor();
    }
    
    // Add in air tanks, too (config 1)
    color([0.4,0.4,0.4]) {
        translate([(CHASSIS_WIDTH-CHASSIS_CUTOUT_WIDTH)/2+.5,BOX_TUBE_WIDTH+.25+2.75/2,BASE_CHASSIS_HEIGHT]) tank();
        translate([(CHASSIS_WIDTH-CHASSIS_CUTOUT_WIDTH)/2+.5,BOX_TUBE_WIDTH+.5+3*2.75/2,BASE_CHASSIS_HEIGHT]) tank();
    }
    
    // Put in the climber winch
    color([0.6,0,1]) {
        translate([0,0,CLIMBER_Z_OFFSET]) {
            // P80s
            translate([CHASSIS_WIDTH/2+CLIMBER_CENTER_WIDTH/2,CLIMBER_Y_LOC,(WHEEL_DIAMETER-BOX_TUBE_HEIGHT)/2+BOX_TUBE_WIDTH-WHEEL_CENTER_OFFSET]) p80_minicim();
            translate([CHASSIS_WIDTH/2-CLIMBER_CENTER_WIDTH/2,CLIMBER_Y_LOC,(WHEEL_DIAMETER-BOX_TUBE_HEIGHT)/2+BOX_TUBE_WIDTH-WHEEL_CENTER_OFFSET]) mirror([1,0,0]) p80_minicim();
            // Winch
            translate([CHASSIS_WIDTH/2,CLIMBER_Y_LOC,(WHEEL_DIAMETER-BOX_TUBE_HEIGHT)/2+BOX_TUBE_WIDTH-WHEEL_CENTER_OFFSET+1.25]) rotate([0,90,0]) cylinder(CLIMBER_CENTER_WIDTH, d=CLIMBER_WINCH_DIAMETER, center=true, $fn=60);
        }
        // Hex shaft
        translate([CHASSIS_WIDTH/2,CLIMBER_Y_LOC-5,BASE_CHASSIS_HEIGHT+BOX_TUBE_HEIGHT+SUPER_HEIGHT-SUPER_TUBE_HEIGHT/2]) rotate([0,90,0]) cylinder(CLIMBER_CENTER_WIDTH, r=.5/sqrt(3), center=true, $fn=6);
        // Mechanism on that shaft
        translate([CHASSIS_WIDTH/2,CLIMBER_Y_LOC-5,BASE_CHASSIS_HEIGHT+BOX_TUBE_HEIGHT+SUPER_HEIGHT-SUPER_TUBE_HEIGHT/2]) rotate([0,90,0]) cylinder(.75, r=.75, center=true, $fn=60);
        translate([CHASSIS_WIDTH/2-.5,CLIMBER_Y_LOC-5,BASE_CHASSIS_HEIGHT+BOX_TUBE_HEIGHT+SUPER_HEIGHT-SUPER_TUBE_HEIGHT/2]) rotate([0,90,0]) cylinder(.2, r=1, center=true, $fn=60);
        translate([CHASSIS_WIDTH/2+.5,CLIMBER_Y_LOC-5,BASE_CHASSIS_HEIGHT+BOX_TUBE_HEIGHT+SUPER_HEIGHT-SUPER_TUBE_HEIGHT/2]) rotate([0,90,0]) cylinder(.2, r=1, center=true, $fn=60);
    }
    
    // Add in the climber's ratcheting mechanism
    
    // Build the arm
    ARM_ANGLE = 0;
    PIVOT_POINT_Y = 0.5; //4.25;
    PIVOT_POINT_Z = 9; //3;
    translate([0,PIVOT_POINT_Y,PIVOT_POINT_Z])
    rotate([ARM_ANGLE,0,0])
    translate([0,-PIVOT_POINT_Y,-PIVOT_POINT_Z])
    {
        // Mark the axis of rotation for convenience
        color([1,1,1]) {
            translate([0,PIVOT_POINT_Y,PIVOT_POINT_Z]) rotate([0,90,0]) cylinder(CHASSIS_WIDTH,d=0.5, $fn=60);
        }
        
        // Piston
        color([1,0.5,0]) {
            translate([CHASSIS_WIDTH/2,6.8,6])
            rotate([-90,0,0]) cylinder(12,d=1.5, $fn=60);
        } 
        
        // Put in the arm itself
        color([0,0.6,1]) {}
    
        // Put a pretty box there for visualization
        color([.9,1,0.2]) {
            translate([CHASSIS_WIDTH/2,25.5,1]) box();
        }
    }
}

// ---- ROBOT STUFF ----

// Robot chassis
full_chassis();

// For determining the height of the chassis
// cube([1,1,1.625]);

// ---- FIELD ELEMENTS ----

// Can we shoot to the switch?
 translate([0,32]) fence();

// Can we pass over the wire protector?
// translate([0,25.5]) bump();