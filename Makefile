all: wth

wth: src/*.v
	v -o wth src/

clean:
	rm -f wth

run: all
	./wth

.PHONY: all clean run
