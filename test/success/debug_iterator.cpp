#include <list>

// cygwin seems to support debug iterators, but does not define __GLIBC__
#if defined(__GLIBC__) || defined(__CYGWIN__)
	#ifndef _GLIBCXX_DEBUG
		#error "_GLIBCXX_DEBUG not defined"
	#endif

	#ifndef _GLIBCXX_DEBUG_PEDANTIC
		#error "_GLIBCXX_DEBUG_PEDANTIC not defined"
	#endif
	static_assert(std::is_same<std::list<char>, __gnu_debug::list<char>>::value, "not using debug containers");
#elif defined (_MSC_VER)
	#ifndef _ITERATOR_DEBUG_LEVEL || _ITERATOR_DEBUG_LEVEL != 1 || _ITERATOR_DEBUG_LEVEL != 2
		#error "_ITERATOR_DEBUG_LEVEL not defined or not enabbled"
	#endif
#else
	#error "Expand test case for this compiler/environment"
#endif


int main(){}
