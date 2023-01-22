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
// File: /source/tdq/tdq_bootstrap.qc
//
// Authors: erysdren
//
// Modified: January 22 2023
//
// Description: TDQ startup and shutdown functions.
//
//=============================================================================

// TDQ header
#include "tdq.qh"

//=============================================================================
//
// Function:
// - void TDQ_Startup()
//
// Description:
// - Called at CSQC startup. Handles the setup of the TDQ functions.
//
void TDQ_Startup()
{
	// Tell user we're doing something
	if (tdq_verbose) print("\bTDQ_Startup\b();\n");

	// Print version info
	print("\n", TDQ_INFO_NAME, "\n");
	print("[\bAuthor\b]: ", TDQ_INFO_AUTHOR, "\n");
	print("[\bVersion\b]: ", TDQ_INFO_VERSION, "\n");
	print("[\bDate\b]: ", TDQ_INFO_DATE, "\n\n");

	// Set the default values for globals
	TDQ_Reset();

	// Register console commands
	registercommand("tdq_toggle");
	registercommand("tdq_enable");
	registercommand("tdq_disable");
	registercommand("tdq_scale");
	registercommand("tdq_offset");
	registercommand("tdq_clear");
	registercommand("tdq_reset");
	registercommand("tdq_verbose");
	registercommand("tdq_halo_scale");
	registercommand("tdq_halo_pic");
	registercommand("tdq_halo_alpha");
	registercommand("tdq_halo_color");
	registercommand("tdq_halo_active");

	// Precache assets
	precache_pic(TDQ_DEFAULT_CROSSHAIR_PIC);
	precache_pic(TDQ_DEFAULT_HALO_PIC);
	precache_pic(TDQ_DEFAULT_HALO_CROSSHAIR_PIC);

	// Set console commands
	cvar_set("chase_active", "1");
	cvar_set("sv_aim", "-0.5");
	cvar_set("r_novis", "1");
}

//=============================================================================
//
// Function:
// - void TDQ_Shutdown()
//
// Description:
// - Called at CSQC shutdown. Handles the cleanup of the TDQ functions.
//
void TDQ_Shutdown()
{
	// Tell user we're doing something
	if (tdq_verbose) print("\bTDQ_Shutdown\b();\n");

	// Reset console commands
	cvar_set("chase_active", cvar_defstring("chase_active"));
	cvar_set("sv_aim", cvar_defstring("sv_aim"));
	cvar_set("r_novis", cvar_defstring("r_novis"));
}

//=============================================================================
//
// Function:
// - void TDQ_Reset()
//
// Description:
// - Reset all TDQ globals to defaults.
//
void TDQ_Reset()
{
	tdq_scale = TDQ_DEFAULT_SCALE;
	tdq_active = TDQ_DEFAULT_STATE;
	tdq_offset = TDQ_DEFAULT_OFFSET;
	tdq_clear = TDQ_DEFAULT_CLEAR;
	tdq_crosshair_pic = TDQ_DEFAULT_CROSSHAIR_PIC;
	tdq_crosshair_pos = TDQ_DEFAULT_CROSSHAIR_POS;
	tdq_crosshair_size = drawgetimagesize(TDQ_DEFAULT_CROSSHAIR_PIC);
	tdq_verbose = TDQ_DEFAULT_VERBOSE;

	tdq_halo_size = drawgetimagesize(TDQ_DEFAULT_HALO_PIC);
	tdq_halo_alpha = TDQ_DEFAULT_HALO_ALPHA;
	tdq_halo_pic = TDQ_DEFAULT_HALO_PIC;
	tdq_halo_scale = TDQ_DEFAULT_HALO_SCALE;
	tdq_halo_color = TDQ_DEFAULT_HALO_COLOR;
	tdq_halo_crosshair_pic = TDQ_DEFAULT_HALO_CROSSHAIR_PIC;
	tdq_halo_crosshair_size = drawgetimagesize(TDQ_DEFAULT_HALO_CROSSHAIR_PIC);
	tdq_halo_active = TDQ_DEFAULT_HALO_STATE;

	if (tdq_verbose)
	{
		print("\bTDQ_Reset\b();\n");
		print("\btdq_scale:\b ", ftos(tdq_scale), "\n");
		print("\btdq_active:\b ", tdq_active ? "TRUE" : "FALSE", "\n");
		print("\btdq_clear:\b ", vtos(tdq_clear), "\n");
		print("\btdq_offset:\b ", vtos(tdq_offset), "\n");
		print("\btdq_verbose:\b ", tdq_verbose ? "TRUE" : "FALSE", "\n");
		print("\btdq_crosshair_pic:\b ", tdq_crosshair_pic, "\n");
		print("\btdq_crosshair_pos:\b ", vtos(tdq_crosshair_pos), "\n");
		print("\btdq_crosshair_size:\b ", vtos(tdq_crosshair_size), "\n");
	}
}
