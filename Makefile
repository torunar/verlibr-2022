build: clean
	DOCKER_SCAN_SUGGEST=false docker build -t pdf:latest -o bin .

clean:
	rm -rf bin/verlibr.pdf
