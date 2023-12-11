from PIL import Image

def convert_image_to_hex(image_path, output_path):
    # Load the image file
    img = Image.open(image_path)

    # Resize the image to 16x16 if it's not already that size
    if img.size != (16, 16):
        img = img.resize((16, 16), Image.ANTIALIAS)

    # Convert the image to an RGB array
    rgb_img = img.convert('RGB')

    # Function to convert 8-bit color depth to 4-bit color depth
    def to_4bit(value):
        return value // 16

    # Create an empty list to hold the 12-bit color values for the image
    hex_values = []

    # Loop over each pixel and convert to 12-bit color depth
    for y in range(16):
        for x in range(16):
            r, g, b = rgb_img.getpixel((x, y))
            r, g, b = to_4bit(r), to_4bit(g), to_4bit(b)
            # Combine the 4-bit R, G, and B values into a single 12-bit number
            color_12bit = (r << 8) | (g << 4) | b
            # Format the number as a hex string and append to our list
            hex_values.append(format(color_12bit, '03x'))

    # Save the list of color values to a hex file
    with open(output_path, 'w') as file:
        for hex_value in hex_values:
            file.write(f"{hex_value}\n")
            
convert_image_to_hex('/Users/aamaya3/Desktop/image_converter/crouch.png', '/Users/aamaya3/Desktop/image_converter/crouch.hex')
