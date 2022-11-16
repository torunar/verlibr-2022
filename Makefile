build: clean
	docker build -t pdf:latest -o bin .

clean:
	rm -rf bin/verlibr.pdf
