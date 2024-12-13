# Game Boy DVD Logo Animation

A Game Boy ROM that recreates the classic DVD logo bounce animation.

## Prerequisites

Before building this ROM, ensure you have the following tools installed:

- RGBDS (Rednex Game Boy Development System)
  - `rgbasm` - Game Boy assembler
  - `rgblink` - Game Boy linker
  - `rgbfix` - Game Boy ROM fixer
- mGBA - Game Boy emulator for testing

## Building the ROM

To compile the ROM, run the following commands in sequence:

```bash
# Assemble the source code
rgbasm -o dvd_logo.o dvd_logo.asm

# Link the object file
rgblink -o final_100.gb dvd_logo.o

# Fix the ROM header
rgbfix -v -p 0xFF final_100.gb
```

## Running the ROM

After building, you can run the ROM file `final_100.gb` using mGBA or any other Game Boy emulator.

## Development

This project is written in Game Boy Assembly language and demonstrates basic sprite movement and collision detection on the Game Boy hardware.

## License

[Add your chosen license here]

## Contributing

[Add contribution guidelines if you want to accept contributions]


![ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/ec66b5b2-998d-417d-bc50-a195fcdc2566)
