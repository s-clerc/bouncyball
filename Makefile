compile : 
	coffee -o js/ -m -c src/*.coffee
build :
	echo "will build to built.js"
	r.js -o build.js
