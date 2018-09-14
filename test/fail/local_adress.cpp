namespace{
	int* foo(){
		int i = 42;
		return &i;
	}
}

int main() {
	auto p = foo();
	(void)p;
}
