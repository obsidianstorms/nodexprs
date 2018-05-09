container = nodexprs

run :
	./control/run-host.sh $(container)
build :
	./control/init-host.sh $(container)
update :
	./control/update-host.sh $(container)
tests :
	./control/test-host.sh $(container)
