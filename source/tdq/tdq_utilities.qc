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
// File: /source/tdq/tdq_utilities.qc
//
// Authors: erysdren
//
// Modified: January 22 2023
//
// Description: TDQ utilities.
//
//=============================================================================

// TDQ header
#include "tdq.qh"

//=============================================================================
//
// Function:
// - vector TDQ_Clamp_Vector(vector in, vector min, vector max)
//
// Description:
// - Returns a vector clamped to the provided min and max values.
//
// Parameters:
// - in: The vector to be clamped.
// - min: The minimum area.
// - max: The maximum area.
//
vector TDQ_Clamp_Vector(vector in, vector min, vector max)
{
	in[0] = in[0] < min[0] ? min[0] : in[0];
	in[0] = in[0] > max[0] ? max[0] : in[0];

	in[1] = in[1] < min[1] ? min[1] : in[1];
	in[1] = in[1] > max[1] ? max[1] : in[1];

	in[2] = in[2] < min[2] ? min[2] : in[2];
	in[2] = in[2] > max[2] ? max[2] : in[2];

	return in;
}

//=============================================================================
//
// Function:
// - vector TDQ_Div_Vector(vector dividend, float divisor)
//
// Description:
// - Returns a vector divided by the provided divisor value.
//
// Parameters:
// - dividend: The vector to be divided.
// - divisor: The number to divide by.
//
vector TDQ_Div_Vector(vector dividend, float divisor)
{
	dividend[0] /= divisor;
	dividend[1] /= divisor;
	dividend[2] /= divisor;

	return dividend;
}
