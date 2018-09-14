##################################################################
## Settings for the MSVC compiler

##################################################################
# STD settings

# remove "wrong" (and annoying) warnings
# https://msdn.microsoft.com/en-us/library/ttcz0bys.aspx
#option(disable_microsoft_posix_name_deprecation "Disable posix name deprecation" OFF)
#if(disable_microsoft_posix_name_deprecation)
#else()
#	add_definitions(-D_NONSTDC_NO_WARNINGS)
#endif()

##################################################################
# compiler warnings, should be enabled on every project
set(ADMONITIONS_WARNINGS
	/Wall
	# info

	/wd4263 /wd4264 /wd4266 # virtual function does not override parent

	/wd4371                 # layout of class may have changed from a previous version
	/wd4373                 # older msvc did not override function in some cases (const/volatile parameter)
	/wd4435                 # obj layout changed
	/wd4514                 # unreferenced inline function has been removed
	/wd4571                 # catch(...) does not catch SEH

	/wd5026 /wd5027         # move constructor/operator= deleted
	/wd4514                 # unreferenced inline function has been removed
	/wd4625 /wd4626         # copy constructor deleted
	/wd4623                 # default constructor deleted
	/wd4710                 # function not inlined
	/wd4711                 # function will be inlined
	/wd4820                 # X bytes padding added
	/wd4868                 # compiler might not enforce left-to-right evaluation
	/wd4917                 # GUID
)

# would like to let always on, but windows header generate to many warnings
#option(disable_common_windows_h_warnings "Disable common warning that appears in windows.h" OFF)
#if(disable_common_windows_h_warnings)
#	message(" ===== Disable common warnings appearing in windows.h ===== ")
#	add_compile_options(/wd4668)                 # macro not defined, sobsittute with 0 -> to many internal warnings with __midl
#	add_compile_options(/wd4987)                 # using throw(...)
#	add_compile_options(/wd4191)                 # unsafe conversion
#	add_compile_options(/wd4365)                 # conversion signed/unsigned
#	add_compile_options(/wd4574)                 # if vs ifdef
#endif()

#option(disable_static_alaysis "Enable static analysis (can take a lot of time)" ON)
#if (NOT disable_static_alaysis)
#	message(" ===== Enable static analysis ===== ")
#	add_compile_options(/analyze)
#endif()

set(ADMONITIONS_ERRORS
	/we4129                 # unrecognized character
	/we4130                 # comparing address with string
	/we4114 /we4141         # same qualifier more than once
	/we4289 /we4837         # trigraph extension

	/we4293                 # overflow

	/we4566                 # character cannot be represented in the current locale
	/we4608                 # union
	/we4777 /we4477         # UB /printf...
	/we4800                 # conversion

	/we6262                 # stack overflow
	/we4700 /we4701 /we4703 # using probably uninitialized variable
	/we4715                 # not all paths return value
	/we4905 /we4906         # unsafe casts

	/we4239 /we4211 /we4238 # invalid conversion

	/sdl                    # add some warnings/error and runtime checks

	# disable extensions
	/Zc:forScope
	/Zc:rvalueCast
	/Zc:wchar_t
)

##################################################################
# language extensions
#add_compile_options(/Zc:forScope /Zc:rvalueCast /Zc:wchar_t) # disable microsoft extensions
#option(disable_all_lang_ext "Disable all language extensions (does not work with windows.h)" OFF)
#if(disable_all_lang_ext)
#	add_compile_options(/Za)
#endif()

##################################################################
# sanitizers (checks made at runtime)
#add_compile_options(/GS)                  # Buffer Security Check
#add_compile_options(/Gs)                  # Control Stack Checking Calls
#add_compile_options(/guard:cf)            # Enable Control Flow Guard (also passed to linker)

#option(enable_rtcc "Enable RTCc (may reject conformant code)" OFF)
#if(enable_rtcc)
	# Check conversion to smaller types, works only for Debug build
	# add_definitions seems to not support generator expression like add_compile_options
#	set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -D_ALLOW_RTCc_IN_STL")
#	add_compile_options("$<$<CONFIG:DEBUG>:/RTCc>")
#endif()

##################################################################
# optimization
#add_compile_options("$<$<CONFIG:RELEASE>:/Zc:inline>") # remove unused code and data
#add_compile_options("$<$<CONFIG:RELEASE>:/Qpar>")      # automatic parallelization of loops
#add_compile_options("$<$<CONFIG:RELEASE>:/Gw>")        # optimize Global Data
#add_compile_options("$<$<CONFIG:RELEASE>:/GL>")        # Whole Program Optimization
#set (CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE} /OPT:REF")
#set (CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO "${CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO} /OPT:REF")
#set (CMAKE_SHARED_LINKER_FLAGS_RELEASE "${CMAKE_SHARED_LINKER_FLAGS_RELEASE} /OPT:REF")
#set (CMAKE_SHARED_LINKER_FLAGS_RELWITHDEBINFO "${CMAKE_SHARED_LINKER_FLAGS_RELWITHDEBINFO} /OPT:REF")


##################################################################
# other settings
# changes unsecure functions with secure variants where possible, for example:
# char buf[10];strcpy(buf, "test"); -> char buf[10];strcopy_s(buf, 10, "test");
# as a side effect it can also remove some deprecation warning and we may avoid to define _NONSTDC_NO_WARNINGS
#add_definitions(/D_CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES=1)

