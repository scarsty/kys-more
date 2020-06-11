//-----------------------------------------------------------------------------
// ʱ����ز���
//-----------------------------------------------------------------------------

#ifndef FH_TIME
#define FH_TIME

// INCLUDES ///////////////////////////////////////////////////////////////////

#define WIN32_LEAN_AND_MEAN

#include <windows.h>
#include <stdio.h>
#include <assert.h>

// DEFINES ////////////////////////////////////////////////////////////////////
// MACROS /////////////////////////////////////////////////////////////////////
// TYPES //////////////////////////////////////////////////////////////////////
// CLASS //////////////////////////////////////////////////////////////////////
// PROTOTYPES /////////////////////////////////////////////////////////////////

inline void StartTimer(LONGLONG *pnCpuCount);
inline void StopTimer(LONGLONG *pnCpuCount);

// EXTERNALS //////////////////////////////////////////////////////////////////
// GLOBALS ////////////////////////////////////////////////////////////////////
// FUNCTIONS //////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------------------
// Name: StartTimer()
// Desc: ��ʼ��ʱ����ǰʱ�䴢���ڴ���ĵ�ַ��
//-----------------------------------------------------------------------------
inline void StartTimer(LONGLONG * const pnCpuCount)
	{
	LARGE_INTEGER Counter;
	QueryPerformanceCounter(&Counter);
	*pnCpuCount = Counter.QuadPart;
	}



//-----------------------------------------------------------------------------
// Name: StopTimer()
// Desc: ������ʱ���ӿ�ʼ��ʱ������ʱ�䴢���ڴ���ĵ�ַ��
//-----------------------------------------------------------------------------
inline void StopTimer(LONGLONG * const pnCpuCount)
	{
	LARGE_INTEGER Counter;
	QueryPerformanceCounter(&Counter);
	*pnCpuCount = Counter.QuadPart - *pnCpuCount;
	}


#endif // FH_TIME