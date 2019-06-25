##################################################################
# Settings for the Clang Compiler

set(ADMONITIONS_WARNINGS
	# basic
	-Weverything

	# FIXME: should not get disabled on c++98 projects
	-Wno-c++98-compat
	-Wno-c++98-compat-pedantic

	-Wno-system-headers # disable warnings from system headers

	# very verbose, and most of the time just info
	-Wno-padded
	-Wno-weak-vtables
)

set(ADMONITIONS_SUGGESTIONS
	-Wpadded
	-Wweak-vtables
)

set(ADMONITIONS_ERRORS
	# basic
	-Werror=return-type
	-pedantic-errors    # treat language extension as errors

	# formatting
	-Werror=format

	-Werror=extra-tokens
	-Werror=newline-eof
	-Werror=return-stack-address
)

## additional debug informations - FIXME: it is libc-specific and not compiler
set(ADMONITIONS_DEF_DEBUG_ITERATORS -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC)
#set(ADMONITIONS_DEF_DEBUG_ITERATORS -D_LIBCPP_DEBUG)


set(ADMONITIONS_COMPILE_LINK_OPT_SAN_UNDEFINED        -fsanitize=undefined)
set(ADMONITIONS_COMPILE_LINK_OPT_LINKER_SAN_ADD       -fsanitize=address)
set(ADMONITIONS_COMPILE_LINK_OPT_LINKER_SAN_UNDEFINED -fsanitize=undefined)
set(ADMONITIONS_COMPILE_LINK_OPT_LINKER_SAN_THREAD    -fsanitize=thread)
set(ADMONITIONS_COMPILE_LINK_OPT_LINKER_SAN_MEMORY    -fsanitize=memory)
set(ADMONITIONS_COMPILE_LINK_OPT_LINKER_SAN_DATAFLOW  -fsanitize=dataflow)
set(ADMONITIONS_COMPILE_LINK_OPT_LINKER_SAN_CFI       -fsanitize=cfi)
set(ADMONITIONS_COMPILE_LINK_OPT_LINKER_SAN_STACK     -fsanitize=safe-stack)


set(ADMONITIONS_COMPILE_OPT_RELEASE_FORTIFY -D_FORTIFY_SOURCE=2 -O2)
set(ADMONITIONS_COMPILE_OPT_DEBUG_FORTIFY   -D_FORTIFY_SOURCE=1)


#add_compile_options(-fstack-protector-all)
