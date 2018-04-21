container = nodexprs

run :
	./harness-host.sh $(container)
build :
	./init-host.sh $(container)
