#!/usr/bin/env python3
"""
Generates C header files from word_list.txt and valid_word_list.txt
so the lists are embedded into the binary at compile time.
"""

import datetime


def generate_header(input_file: str, output_file: str, array_name: str):
    with open(input_file, "r") as f:
        words = [line.strip() for line in f if line.strip()]

    with open(output_file, "w") as f:
        f.write(
            f"// Auto-generated on {datetime.datetime.now().isoformat()}\n"
        )
        f.write(f"// Source: {input_file}\n\n")
        f.write(f"#ifndef {array_name.upper()}_H\n")
        f.write(f"#define {array_name.upper()}_H\n\n")

        f.write(f"static const char *{array_name}[] = {{\n")
        for word in words:
            f.write(f'    "{word}",\n')
        f.write("};\n\n")

        f.write(f"static const int {array_name}_len = {len(words)};\n\n")
        f.write(f"#endif // {array_name.upper()}_H\n")

    print(f"Generated {output_file} with {len(words)} words.")


if __name__ == "__main__":
    generate_header("word_list.txt", "word_list.h", "word_list")
    generate_header(
        "valid_word_list.txt", "valid_word_list.h", "valid_word_list"
    )
