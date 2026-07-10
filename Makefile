.PHONY: all clean

CC = gcc
C_FLAGS = -Wall -Wextra

all: wordle solver

word_list.txt valid_word_list.txt:
	@echo "Generating word list text files..."
	python3 generate_word_lists.py

word_list.h valid_word_list.h: word_list.txt valid_word_list.txt
	@echo "Generating C header files..."
	python3 generate_headers.py

wordle: wordle.c word_list.h valid_word_list.h
	$(CC) -o wordle wordle.c $(C_FLAGS)
	@echo "Build complete: ./wordle"

solver: solver.c word_list.h valid_word_list.h
	$(CC) -o solver solver.c $(C_FLAGS)
	@echo "Build complete: ./solver"

clean:
	rm -f wordle
	rm -f word_list.txt valid_word_list.txt
	rm -f word_list.h valid_word_list.h
	@echo "Cleaned up generated files."
