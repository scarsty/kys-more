//-----------------------------------------------------------------------------
// 位操作
//-----------------------------------------------------------------------------

#ifndef FH_BIT
#define FH_BIT

// INCLUDES ///////////////////////////////////////////////////////////////////

#define WIN32_LEAN_AND_MEAN

#include <windows.h>
#include <stdio.h>
#include <assert.h>

// DEFINES ////////////////////////////////////////////////////////////////////
// MACROS /////////////////////////////////////////////////////////////////////

// 位操作宏
#define SET_BIT(word, bit_flag)		((word) = ((word) | (bit_flag)))		// 设置位标志
#define RESET_BIT(word, bit_flag)	((word) = ((word) & ~(bit_flag)))		// 清除位标志
#define CHECK_BIT(word, bit_flag)	((word) & (bit_flag))					// 检查位标志

// 如果几个bit位用"|"合并起来：
// 一起设置或清除的话，则完全符合语意，即同时设为1或0
// 一起检查的话，结果为真表示数据中至少有一位为1，为假表示都为0
//   如果想检查几个bit位是否同时为1，则要把结果和位用"|"合并起来的几个bit位比较，
//   相等则同时为1，不相等则不同时为1（可能有的为1有的为0）
// 一般情况下还是不要合并检查的好

// TYPES //////////////////////////////////////////////////////////////////////
// CLASS //////////////////////////////////////////////////////////////////////
// PROTOTYPES /////////////////////////////////////////////////////////////////
// EXTERNALS //////////////////////////////////////////////////////////////////
// GLOBALS ////////////////////////////////////////////////////////////////////
// FUNCTIONS //////////////////////////////////////////////////////////////////

#endif // FH_BIT