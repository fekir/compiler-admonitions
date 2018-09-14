##################################################################
## Settings for the Windows headers

# This settings are not compiler specific, but very often they are set together

# https://docs.microsoft.com/windows/desktop/WinProg/using-the-windows-headers
set(ADMONITIONS_DEF_WIN32
	WIN32_LEAN_AND_MEAN     # removes rarely used header from windows.h (simply include those headers when needed)
	NOMINMAX                # removes min and max macro, use std::min and std::max
	STRICT                  # enable strict mode (adds more type safety, for example replacing some typedef with struct)

	# ATL settings
	_ATL_CSTRING_EXPLICIT_CONSTRUCTORS # make CString constructor explicit
	_ATL_ALL_WARNINGS                  # otherwise ATL may globally disable some warning
	_SECURE_ATL=1                      # remove deprecated functions

	# MFC settings
	VC_EXTRALEAN

	# Unicode settings
	_UNICODE
	UNICODE
)


# RC compiler may need numeric value, those can be found here
# https://doxygen.reactos.org/d9/d16/sdkddkver_8h_source.html
set(ADMONITIONS_DEF_WINVER_VISTA
	# Windows Server 2008, Windows Vista -> 0x0600
	NTDDI_VERSION=NTDDI_VISTASP1
	WINVER=_WIN32_WINNT_VISTA
	_WIN32_WINNT=_WIN32_WINNT_VISTA
)
set(ADMONITIONS_DEF_WINVER_7
	# Windows 7
	NTDDI_VERSION=NTDDI_WIN7
	WINVER=_WIN32_WINNT_WIN7
	_WIN32_WINNT=_WIN32_WINNT_WIN7
)
set(ADMONITIONS_DEF_WINVER_8
	# Windows 8
	NTDDI_VERSION=NTDDI_WIN8
	WINVER=_WIN32_WINNT_WIN8
	_WIN32_WINNT=_WIN32_WINNT_WIN8
)
set(ADMONITIONS_DEF_WINVER_8_1
	# Windows 8.1
	NTDDI_VERSION=NTDDI_WINBLUE
	WINVER=_WIN32_WINNT_WINBLUE
	_WIN32_WINNT=_WIN32_WINNT_WINBLUE
)
set(ADMONITIONS_DEF_WINVER_10
	# Windows 10
	NTDDI_VERSION=NTDDI_WIN10
	WINVER=_WIN32_WINNT_WIN10
	_WIN32_WINNT=_WIN32_WINNT_WIN10
)

# Copied from windows.h, they may differ from version to version
# Removes functions or defines. Unlike WIN32_LEAN_AND_MEAN removing support it's not like a missing header that you can add afterwards
# If some of those are needed, undefine them with /U
set(ADMONITIONS_DEF_WIN32_STRICT
	NOGDICAPMASKS           # CC_*, LC_*, PC_*, CP_*, TC_*, RC_*
	NOVIRTUALKEYCODES       # VK_*
	NOWINMESSAGES           # WM_*, EM_*, LB_*, CB_*
	NOWINSTYLES             # WS_*, CS_*, ES_*, LBS_*, SBS_*, CBS_*
	NOSYSMETRICS            # SM_*
	NOMENUS                 # MF_*
	NOICONS                 # IDI_*
	NOKEYSTATES             # MK_*
	NOSYSCOMMANDS           # SC_*
	NORASTEROPS             # Binary and Tertiary raster ops
	NOSHOWWINDOW            # SW_*
	OEMRESOURCE             # OEM Resource values
	NOATOM                  # Atom Manager routines
	NOCLIPBOARD             # Clipboard routines
	NOCOLOR                 # Screen colors
	NOCTLMGR                # Control and Dialog routines
	NODRAWTEXT              # DrawText() and DT_*
	NOGDI                   # All GDI defines and routines
	NOKERNEL                # All KERNEL defines and routines
	NOMB                    # MB_* and MessageBox()
	NOMEMMGR                # GMEM_*, LMEM_*, GHND, LHND, associated routines
	NOMETAFILE              # typedef METAFILEPICT
	NOOPENFILE              # OpenFile(), OemToAnsi, AnsiToOem, and OF_*
	NOSCROLL                # SB_* and scrolling routines
	NOSERVICE               # All Service Controller routines, SERVICE_ equates, etc.
	NOSOUND                 # Sound driver routines
	NOTEXTMETRIC            # typedef TEXTMETRIC and associated routines
	NOWH                    # SetWindowsHook and WH_*
	NOWINOFFSETS            # GWL_*, GCL_*, associated routines
	NOCOMM                  # COMM driver routines
	NOKANJI                 # Kanji support stuff
	NOHELP                  # Help engine interface
	NOPROFILER              # Profiler interface
	NODEFERWINDOWPOS        # DeferWindowPos routines
	NOMCX                   # Modem Configuration Extensions
	NOUSER                  # All USER defines and routines
	NONLS                   # All NLS defines and routines | Code Page Default Values (like CP_UTF8) and MBCS and Unicode Translation (like MB_ERR_INVALID_CHARS)
	NOMSG                   # typedef MSG and associated routines
)
