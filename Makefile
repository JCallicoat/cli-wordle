.PHONY: all clean

# Default target
all: wordle

# Step 1: Generate .txt files if they don't exist
word_list.txt valid_word_list.txt:
	@echo "Generating word list text files..."
	python3 generate_word_lists.py

# Step 2: Generate .h files if they don't exist (depends on .txt files)
word_list.h valid_word_list.h: word_list.txt valid_word_list.txt
	@echo "Generating C header files..."
	python3 generate_headers.py

# Step 3: Compile the program
wordle: wordle.c word_list.h valid_word_list.h
	gcc -o wordle wordle.c -Wall -Wextra
	@echo "Build complete: ./wordle"

# Clean target: removes generated files
clean:
	rm -f wordle
	rm -f word_list.txt valid_word_list.txt
	rm -f word_list.h valid_word_list.h
	@echo "Cleaned up generated files."
