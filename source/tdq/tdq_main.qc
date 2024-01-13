//=============================================================================
//
// MIT License
//
// Copyright (c) 2023 erysdren
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.
//
//=============================================================================

//=============================================================================
//
// Project: TopDownQuake
//
// File: /source/tdq/tdq_main.qc
//
// Authors: erysdren
//
// Modified: January 22 2023
//
// Description: Main TDQ game functions.
//
//=============================================================================

// TDQ header
#include "tdq.qh"

//=============================================================================
//
// Function:
// - void TDQ_Render_Main(float vwidth, float vheight, float notmenu)
//
// Description:
// - Called every single frame, for rendering.
//
// Parameters:
// - vwidth: A float containing the virtual screen width.
// - vheight: A float containing the virtual screen height.
// - notmenu: Will be true if the user is not in an engine menu.
//
void TDQ_Render_Main(float vwidth, float vheight, float notmenu)
{
	// Update globals
	tdq_origin = getentity(player_localentnum, GE_ORIGIN);
	tdq_screen_size = [vwidth, vheight];
	tdq_screen_center = TDQ_Div_Vector(tdq_screen_size, 2);
	tdq_paused = notmenu ? FALSE : TRUE;
	tdq_halo_pos = tdq_screen_center - (TDQ_Div_Vector(tdq_halo_size, 2) * tdq_halo_scale);

	// Clear background
	drawfill([0, 0], tdq_screen_size, tdq_clear, 1, 0);

	// Perform rendering
	clearscene();
	setviewprop(VF_DRAWENGINESBAR, 1);
	setviewprop(VF_DRAWCROSSHAIR, 0);
	setviewprop(VF_DRAWWORLD, 1);
	setviewprop(VF_PERSPECTIVE, FALSE);
	setviewprop(VF_ANGLES, [90, 90, 0]);
	setviewprop(VF_FOV, tdq_screen_size * tdq_scale);
	setviewprop(VF_ORIGIN, tdq_origin + tdq_offset);
	renderscene();

	// misc
	makevectors(tdq_angles);
	SetListener(tdq_origin, v_forward, v_right, v_up);

	// render halo & halo crosshair
	if (tdq_halo_active)
	{
		drawpic(tdq_halo_pos, tdq_halo_pic, tdq_halo_size * tdq_halo_scale, tdq_halo_color, tdq_halo_alpha, 0);
		drawrotpic(tdq_screen_center, tdq_halo_crosshair_size * -0.5 * tdq_halo_scale, tdq_halo_crosshair_size * 0.5 * tdq_halo_scale, tdq_halo_crosshair_pic, [1, 1, 1], 1, -tdq_angles[1] + 90);
	}

	// add entities over halo
	setviewprop(VF_DRAWENGINESBAR, 1);
	setviewprop(VF_DRAWCROSSHAIR, 0);
	setviewprop(VF_DRAWWORLD, 0);
	addentities(MASK_ENGINE);
	renderscene();

	// render crosshair
	drawpic(tdq_crosshair_pos - (tdq_crosshair_size / 2), tdq_crosshair_pic, tdq_crosshair_size, [1, 1, 1], 1, 0);
}

//=============================================================================
//
// Function:
// - void TDQ_Input_Main()
//
// Description:
// - Called every single frame, for handling inputs.
//
void TDQ_Input_Main()
{
	// Variables
	vector dir;

	input_angles = -(vectoangles(tdq_crosshair_pos - (tdq_screen_size * 0.5)));
	tdq_angles = input_angles;

	makevectors([0, 90, 0]);
	dir = [input_movevalues * v_forward, input_movevalues * v_right, input_movevalues * v_up];

	makevectors(tdq_angles);
	input_movevalues = dir[0] * v_forward + dir[1] * v_right + dir[2] * v_up;

	setviewprop(VF_CL_VIEWANGLES, tdq_angles);
}

//=============================================================================
//
// Function:
// - float TDQ_Input_Event(float evtype, float scanx, float chary, float devid)
//
// Description:
// - Called every time the engine detects an input event.
//
// Parameters:
// - evtype: Will be equal to one of the IE_* constants.
// - scanx: Varies based on evtype.
// - chary: Varies based on evtype.
// - devid: Usually the ID of keyboard/mouse/gamepad that issued the event.
//
float TDQ_Input_Event(float evtype, float scanx, float chary, float devid)
{
	// Switch based on event type
	switch (evtype)
	{
		case IE_MOUSEDELTA:
			tdq_crosshair_pos[0] += scanx;
			tdq_crosshair_pos[1] += chary;
			tdq_crosshair_pos = TDQ_Clamp_Vector(tdq_crosshair_pos, [0, 0], tdq_screen_size - tdq_crosshair_size);
			return TRUE;

		case IE_MOUSEABS:
			tdq_crosshair_pos = TDQ_Clamp_Vector([scanx, chary], [0, 0], tdq_screen_size - tdq_crosshair_size);
			return TRUE;

		// Default case
		default:
			return FALSE;
	}
}

//=============================================================================
//
// Function:
// - float TDQ_ConsoleCommand(string cmd)
//
// Description:
// - Called for every CSQC console command registered with registercommand().
//
// Parameters:
// - cmd: A string containing the raw command entered by the user.
//
float TDQ_ConsoleCommand(string cmd)
{
	// Tokenize cmd into component parts
	tokenize(cmd);

	// Determine command issued
	switch(argv(0))
	{
		// TDQ toggle
		case "tdq_toggle":
			TDQ_QuickToggle();
			print("\btdq_active:\b ", tdq_active ? "TRUE" : "FALSE", "\n");
			print("\bdefault:\b ", TDQ_DEFAULT_STATE ? "TRUE" : "FALSE", "\n");
			return TRUE;

		// TDQ enable
		case "tdq_enable":
			TDQ_QuickStartup();
			print("\btdq_active:\b ", tdq_active ? "TRUE" : "FALSE", "\n");
			print("\bdefault:\b ", TDQ_DEFAULT_STATE ? "TRUE" : "FALSE", "\n");
			return TRUE;

		// TDQ disable
		case "tdq_disable":
			TDQ_QuickShutdown();
			print("\btdq_active:\b ", tdq_active ? "TRUE" : "FALSE", "\n");
			print("\bdefault:\b ", TDQ_DEFAULT_STATE ? "TRUE" : "FALSE", "\n");
			return TRUE;

		// TDQ set scale
		case "tdq_scale":
			if (stof(argv(1)) > 0) tdq_scale = stof(argv(1));
			print("\btdq_scale:\b ", ftos(tdq_scale), "\n");
			print("\bdefault:\b ", ftos(TDQ_DEFAULT_SCALE), "\n");
			return TRUE;

		// TDQ set offset
		case "tdq_offset":
			if (argv(1) != "") tdq_offset = stov(argv(1));
			print("\btdq_offset:\b ", vtos(tdq_offset), "\n");
			print("\bdefault:\b ", vtos(TDQ_DEFAULT_OFFSET), "\n");
			return TRUE;

		// TDQ set clear color
		case "tdq_clear":
			if (argv(1) != "") tdq_clear = stov(argv(1));
			print("\btdq_clear:\b ", vtos(tdq_clear), "\n");
			print("\bdefault:\b ", vtos(TDQ_DEFAULT_CLEAR), "\n");
			return TRUE;

		// TDQ reset all values
		case "tdq_reset":
			TDQ_Reset();
			return TRUE;

		// TDQ set verbosity
		case "tdq_verbose":
			if (argv(1) != "") tdq_verbose = stof(argv(1));
			print("\btdq_verbose:\b ", tdq_verbose ? "TRUE" : "FALSE", "\n");
			print("\bdefault:\b ", TDQ_DEFAULT_VERBOSE ? "TRUE" : "FALSE", "\n");
			return TRUE;

		// TDQ set crosshair size
		case "tdq_crosshair_size":
			if (argv(1) != "") tdq_crosshair_size = stov(argv(1));
			print("\btdq_crosshair_size:\b ", vtos(tdq_crosshair_size), "\n");
			print("\bdefault:\b ", vtos(drawgetimagesize(TDQ_DEFAULT_CROSSHAIR_PIC)), "\n");
			return TRUE;

		// TDQ set halo scale
		case "tdq_halo_scale":
			if (stof(argv(1)) > 0) tdq_halo_scale = stof(argv(1));
			print("\btdq_halo_scale:\b ", ftos(tdq_halo_scale), "\n");
			print("\bdefault:\b ", ftos(TDQ_DEFAULT_HALO_SCALE), "\n");
			return TRUE;

		// TDQ set halo alpha
		case "tdq_halo_alpha":
			if (argv(1) != "") tdq_halo_alpha = stof(argv(1));
			print("\btdq_halo_alpha:\b ", ftos(tdq_halo_alpha), "\n");
			print("\bdefault:\b ", ftos(TDQ_DEFAULT_HALO_ALPHA), "\n");
			return TRUE;

		// TDQ set halo pic
		case "tdq_halo_pic":
			if (argv(1) != "") { precache_pic(argv(1)); tdq_halo_pic = argv(1); }
			print("\btdq_halo_pic:\b ", tdq_halo_pic, "\n");
			print("\bdefault:\b ", TDQ_DEFAULT_HALO_PIC, "\n");
			return TRUE;

		// TDQ set halo color
		case "tdq_halo_color":
			if (argv(1) != "") tdq_halo_color = stov(argv(1));
			print("\btdq_halo_color:\b ", vtos(tdq_halo_color), "\n");
			print("\bdefault:\b ", vtos(TDQ_DEFAULT_HALO_COLOR), "\n");
			return TRUE;

		// TDQ set halo state
		case "tdq_halo_active":
			if (argv(1) != "") tdq_halo_active = stof(argv(1)) > 0 ? TRUE : FALSE;
			print("\btdq_halo_active:\b ", tdq_halo_active ? "TRUE" : "FALSE", "\n");
			print("\bdefault:\b ", TDQ_DEFAULT_HALO_STATE ? "TRUE" : "FALSE", "\n");
			return TRUE;

		// TDQ start automap mode
		case "+tdq":
			TDQ_QuickStartup();
			return TRUE;

		// TDQ end automap mode
		case "-tdq":
			TDQ_QuickShutdown();
			return TRUE;

		// Unknown command issued
		default:
			return FALSE;
	}
}
