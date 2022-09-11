import sys

fonts = {}

while line := sys.stdin.readline().strip():
    file, name = line.split(":", maxsplit=1)
    if 'texmf' in file:
        continue
    name += '-' + file.split("/")[-1]
    fonts.setdefault(name, [])
    fonts[name].append(file)

for name, font in fonts.items():
    if len(font) > 1:
        print(name)
        for f in font:
            print(f)
        print()
