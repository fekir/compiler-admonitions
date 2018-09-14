##################################################################
# Settings for the GCC compiler (should work with >=4.8)

# Collect compiler warnings
set(ADMONITIONS_WARNINGS
	# basic
	-Wall
	-Wextra
	-pedantic-errors
	-Wunreachable-code
	-Wunused
	-Wunknown-pragmas
	-Wpragmas

	# unused or unnecessary code
	-Wunused-but-set-parameter
	-Wunused-but-set-variable
	-Wunused-function
	-Wunused-label
	-Wunused-macros
	-Wunused-parameter
	-Wunused-result
	-Wunused-value
	-Wunused-variable
	-Wuseless-cast

	-Wignored-qualifiers
	-Wmissing-declarations   # should set function in anonymous namespace or declare it to avoid possible clashes
	-Wnarrowing
	-Wpacked
	-Wparentheses
	-Waggressive-loop-optimizations # generic UB
	-Wvarargs

	# deprecation
	-Wdeprecated
	-Wdeprecated-declarations

	# nullptr and casts warnings (might generate many warnings when interacting with old code or C code)
	-Wzero-as-null-pointer-constant # does not trigger warning with NULL, but with 0 yes
	-Wold-style-cast
	-Wuseless-cast
	-Wnonnull
	-Wcast-qual
	-Wcast-align
	-Werror=null-dereference
	-Wconversion-null
	-Wint-to-pointer-cast

	# multiple declaration, shadowing, eval undefined identifier
	-Wshadow
	-Wundef

	# class/struct and init
	-Wctor-dtor-privacy
	-Winherited-variadic-ctor
	-Wmissing-field-initializers
	-Wvirtual-move-assign

	# switch and branches
	-Wswitch
	-Wswitch-default
	-Wswitch-enum
	-Wempty-body
	-Wenum-compare

	# arithmetic/numeric warnings
	-Wconversion
	-Wfloat-equal
	-Wsign-compare
	-Wsign-promo
	-Wsign-conversion

	# logical operations
	-Wlogical-op

	# code structure
	-Wdisabled-optimization
	-Wmissing-include-dirs

	# formatting
	-Wformat=2
	-Wformat-nonliteral
	-Wformat-y2k

	# memory
	-Waddress
	-Wsizeof-pointer-memaccess
	-Wsizeof-array-argument
)

if(CMAKE_CXX_COMPILER_VERSION LESS_EQUAL 4)
	set(ADMONITIONS_WARNINGS ${ADMONITIONS_WARNINGS}
			# class/struct and init
			-Wno-missing-field-initializers # otherwise S s = {}; issues warning
	)
elseif(CMAKE_CXX_COMPILER_VERSION GREATER_EQUAL 5)
	set(ADMONITIONS_WARNINGS ${ADMONITIONS_WARNINGS}
		# basic
		-Wodr
		-Wsized-deallocation

		# formatting
		-Wformat-signedness

		# bool
		-Wlogical-not-parentheses
		-Wswitch-bool
		-Wtautological-compare
	)
	if(CMAKE_CXX_COMPILER_VERSION GREATER_EQUAL 6)
		set(ADMONITIONS_WARNINGS ${ADMONITIONS_WARNINGS}
			# basic
			-Wignored-attributes
			-Wmisleading-indentation
			-Wsubobject-linkage
			-Wunused-const-variable=2
			-Wduplicated-cond

			# arithmetic/numeric
			-Wshift-negative-value

			# memory
			-Wchkp
			-Wplacement-new=2
			-Wscalar-storage-order
			-Wnull-dereference
		)
		if(CMAKE_CXX_COMPILER_VERSION GREATER_EQUAL 7)
			set(ADMONITIONS_WARNINGS ${ADMONITIONS_WARNINGS}
				# basic
				-Wbuiltin-declaration-mismatch

				# portability
				-Wexpansion-to-defined

				# switch/branches
				-Wdangling-else
				-Wduplicated-branches
				-Wimplicit-fallthrough
				-Wswitch-unreachable

				# formatting
				-Wformat-overflow
				-Wformat-truncation

				# memory
				-Waligned-new=all
				-Wmemset-elt-size
				-Wpointer-compare

				# boolean
				-Wint-in-bool-context
			)
		endif()
	endif()
endif()

# Collect compiler errors
set(ADMONITIONS_ERRORS
	# basic
	-Werror=return-type
	-Werror=pedantic
	-Werror=main
	# portability
	-Werror=multichar
	-Werror=address
	-Werror=sequence-point
	-Werror=cpp
	-Werror=strict-aliasing
	-Werror=strict-null-sentinel
	-Werror=trigraphs

	# nullptr and casts warnings (might generate many warnings when interacting with old code or C code)
	-Werror=null-dereference

	# extensions
	-Werror=pointer-arith # arithmetic on void*

	# multiple declaration, shadowing, eval undefined identifier
	-Werror=redundant-decls

	-Werror=free-nonheap-object
	-Werror=return-local-addr

	# macro
	-Werror=builtin-macro-redefined
	-Werror=endif-labels

	# class/struct and init
	-Werror=non-virtual-dtor
	-Werror=reorder
	-Werror=uninitialized
	-Werror=maybe-uninitialized
	-Werror=delete-non-virtual-dtor
	-Werror=init-self
	-Werror=invalid-offsetof

	# arithmetic/numeric
	-Werror=div-by-zero

	# formatting
	-Werror=format
	-Werror=format-security
	-Werror=format-extra-args
	-Wformat-contains-nul
	-Wformat-zero-length

	# exception safety
	-Werror=terminate

	# memory
	-Werror=vla
	-Werror=array-bounds
	-Werror=write-strings
	-Werror=overflow
)
if(CMAKE_CXX_COMPILER_VERSION GREATER_EQUAL 5)
	set(ADMONITIONS_ERRORS ${ADMONITIONS_ERRORS}
		# arithmetic/numeric
		-Werror=shift-count-negative
		-Werror=shift-count-overflow

		# memory
		-Werror=memset-transposed-args

		# bool
		-Werror=bool-compare
	)
	if(CMAKE_CXX_COMPILER_VERSION GREATER_EQUAL 6)
		set(ADMONITIONS_ERRORS ${ADMONITIONS_ERRORS}
			# arithmetic/numeric
			-Werror=shift-overflow
		)
		if(CMAKE_CXX_COMPILER_VERSION GREATER_EQUAL 7)
			set(ADMONITIONS_ERRORS ${ADMONITIONS_ERRORS}
				# boolean
				-Werror=bool-operation

				# memory
				-Werror=alloc-zero
				-Werror=alloca
				-Werror=stringop-overflow
			)
		endif()
	endif()
endif()

# Collect compiler suggestions
set(ADMONITIONS_SUGGESTIONS
	# formatting
	-Wsuggest-attribute=format
	# function signature
	-Wsuggest-attribute=const
	#-Wsuggest-attribute=pure
	-Wsuggest-attribute=noreturn
)
if(CMAKE_CXX_COMPILER_VERSION GREATER_EQUAL 5)
	set(ADMONITIONS_SUGGESTIONS ${ADMONITIONS_SUGGESTIONS}
		# inheritance
		-Wsuggest-final-methods
		-Wsuggest-final-types
		-Wsuggest-override
	)
endif()

# Collect compiler extensions
set(ADMONITIONS_EXTENSIONS
	-fno-nonansi-builtins
	-fstrict-enums
	-fvisibility-inlines-hidden
	# arithmetic/numeric
	-ftrapv
)


# Compiler options

## additional debug informations - FIXME: it is libc-specific and not compiler
set(ADMONITIONS_DEF_DEBUG_ITERATORS -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC)

set(ADMONITIONS_COMPILE_LINK_OPT_SAN_UNDEFINED        -fsanitize=undefined)
set(ADMONITIONS_COMPILE_LINK_OPT_LINKER_SAN_ADD       -fsanitize=address)
set(ADMONITIONS_COMPILE_LINK_OPT_LINKER_SAN_UNDEFINED -fsanitize=undefined)
set(ADMONITIONS_COMPILE_LINK_OPT_LINKER_SAN_THREAD    -fsanitize=thread)

set(ADMONITIONS_COMPILE_OPT_PROFILING -pg)
set(ADMONITIONS_COMPILE_OPT_COVERAGE --coverage)

set(ADMONITIONS_COMPILE_OPT_RELEASE_FORTIFY -D_FORTIFY_SOURCE=2 -O2)
set(ADMONITIONS_COMPILE_OPT_DEBUG_FORTIFY   -D_FORTIFY_SOURCE=1)


set(ADMONITIONS_COMPILE_OPT_STACK_PROTECTOR_ALL -fstack-protector-all)
if(CMAKE_CXX_COMPILER_VERSION GREATER_EQUAL 5)
	set(ADMONITIONS_COMPILE_OPT_STACK_PROTECTOR -fstack-protector-strong)
else()
	set(ADMONITIONS_COMPILE_OPT_STACK_PROTECTOR -fstack-protector)
endif()
set(ADMONITIONS_COMPILE_OPT_STACK_PROTECTOR ${ADMONITIONS_COMPILE_OPT_STACK_PROTECTOR} -fstack-check)


set(ADMONITIONS_COMPILE_OPT_PIE -pie -fpie -fpic -fPIC)
if( CMAKE_SYSTEM_NAME STREQUAL "Windows" )
	# enable ASLR
	set(ADMONITIONS_COMPILE_OPT_PIE ${ADMONITIONS_COMPILE_OPT_PIE} -Wl,dynamicbase)
	# enable DEP
	set(ADMONITIONS_COMPILE_OPT_PIE ${ADMONITIONS_COMPILE_OPT_PIE} -Wl,nxcompat)
endif()

set(ADMONITIONS_COMPILE_OPT_RELRO -Wl,-z,relro,-z)
set(ADMONITIONS_COMPILE_OPT_RELRO_FULL ${ADMONITIONS_COMPILE_OPT_RELRO},now)


# useful for testing portability
set(ADMONITIONS_COMPILE_OPT_CHAR_SIGNED     -fsigned-char)
set(ADMONITIONS_COMPILE_OPT_CHAR_UNSIGNED -funsigned-char)
