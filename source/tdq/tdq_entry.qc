//=============================================================================
//
// MIT License
//
// Copyright (c) 2022-2025 erysdren (it/its)
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
// File: /source/tdq/tdq_entry.qc
//
// Authors: erysdren
//
// Modified: January 22 2023
//
// Description: CSQC entrypoints for TDQ.
//
//=============================================================================

// TDQ header
#include "tdq.qh"

//=============================================================================
//
// Function:
// - void CSQC_Init(float apilevel, string enginename, float engineversion)
//
// Description:
// - Called at CSQC startup. Precache models and register commands here.
//
// Parameters:
// - apilevel: Descriptor for current API level.
// - enginename: Arbitrary descriptor for the name of the engine.
// - engineversion: Arbitrary descriptor for the current engine version.
//
void CSQC_Init(float apilevel, string enginename, float engineversion)
{
	// Call TDQ startup function
	TDQ_Startup();
}

//=============================================================================
//
// Function:
// - void CSQC_Shutdown()
//
// Description:
// - Called at CSQC shutdown.
//
void CSQC_Shutdown()
{
	// Call TDQ Shutdown function
	TDQ_Shutdown();
}

//=============================================================================
//
// Function:
// - void CSQC_RendererRestarted(string rendererdescription)
//
// Description:
// - Called when a vid_restart command is issued or is called internally.
//
// Parameters:
// - renderdescription: a string containing a renderer descriptor.
//
void CSQC_RendererRestarted(string rendererdescription)
{

}

//=============================================================================
//
// Function:
// - void CSQC_UpdateView(float vwidth, float vheight, float notmenu)
//
// Description:
// - Called every single frame, used for rendering the world.
//
// Parameters:
// - vwidth: A float containing the virtual screen width.
// - vheight: A float containing the virtual screen height.
// - notmenu: Will be true if the user is not in an engine menu.
//
void CSQC_UpdateView(float vwidth, float vheight, float notmenu)
{
	if (tdq_active)
	{
		// Render TDQ screen
		TDQ_Render_Main(vwidth, vheight, notmenu);
	}
	else
	{
		// Clear screen
		clearscene();

		// Set view properties to default
		setproperty(VF_DRAWENGINESBAR, TRUE);
		setproperty(VF_DRAWCROSSHAIR, TRUE);
		setproperty(VF_DRAWWORLD, TRUE);

		// Add entities
		addentities((intermission ? 0 : MASK_VIEWMODEL) | MASK_ENGINE);

		// Render scene
		renderscene();
	}
}

//=============================================================================
//
// Function:
// - float CSQC_ConsoleCommand(string cmd)
//
// Description:
// - Called for every CSQC console command registered with registercommand().
//
// Parameters:
// - cmd: A string containing the raw command entered by the user.
//
float CSQC_ConsoleCommand(string cmd)
{
	// This can't be controlled by a the tdq_active global,
	// because that global can be toggled here.
	return TDQ_ConsoleCommand(cmd);
}

//=============================================================================
//
// Function:
// - float CSQC_InputEvent(float evtype, float scanx, float chary, float devid)
//
// Description:
// - Called for any CSQC input event defined by the engine.
//
// Parameters:
// - evtype: Will be equal to one of the IE_* constants.
// - scanx: Varies based on evtype.
// - chary: Varies based on evtype.
// - devid: Usually the ID of keyboard/mouse/gamepad that issued the event.
//
float CSQC_InputEvent(float evtype, float scanx, float chary, float devid)
{
	if (tdq_active)
		return TDQ_Input_Event(evtype, scanx, chary, devid);
	else
		return FALSE;
}

//=============================================================================
//
// Function:
// - void CSQC_Input_Frame()
//
// Description:
// - Called just before clientcommandframe is updated in every frame.
//
void CSQC_Input_Frame()
{
	if (tdq_active)
		TDQ_Input_Main();
}

//=============================================================================
//
// Function:
// - void CSQC_Parse_Event()
//
// Description:
// - Called whenever the server module issues a multicast.
//
void CSQC_Parse_Event()
{

}

//=============================================================================
//
// Function:
// - void CSQC_WorldLoaded()
//
// Description:
// - Called when the world level has fully loaded.
//
void CSQC_WorldLoaded()
{

}
