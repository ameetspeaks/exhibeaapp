import os
from PIL import Image

# Android mipmap sizes
ANDROID_SIZES = {
    'mipmap-mdpi': 48,
    'mipmap-hdpi': 72,
    'mipmap-xhdpi': 96,
    'mipmap-xxhdpi': 144,
    'mipmap-xxxhdpi': 192,
}

# iOS AppIcon sizes
IOS_SIZES = [
    (20, 20), (20, 20),  # 1x, 2x
    (29, 29), (29, 29),  # 1x, 2x
    (40, 40), (40, 40),  # 1x, 2x
    (60, 60), (60, 60),  # 1x, 2x
    (76, 76), (76, 76),  # 1x, 2x
    (83.5, 83.5),  # 2x
    (1024, 1024),  # App Store
]

def generate_android_icons():
    print("Generating Android icons...")
    original = Image.open('assets/images/logo.png')
    
    for directory, size in ANDROID_SIZES.items():
        # Create directory if it doesn't exist
        os.makedirs(f'android/app/src/main/res/{directory}', exist_ok=True)
        
        # Resize image
        resized = original.resize((size, size), Image.Resampling.LANCZOS)
        
        # Save to ic_launcher.png
        resized.save(f'android/app/src/main/res/{directory}/ic_launcher.png')
        print(f"Generated {directory}/ic_launcher.png ({size}x{size})")

def generate_ios_icons():
    print("\nGenerating iOS icons...")
    original = Image.open('assets/images/logo.png')
    
    # Create AppIcon.appiconset directory if it doesn't exist
    os.makedirs('ios/Runner/Assets.xcassets/AppIcon.appiconset', exist_ok=True)
    
    for i, (width, height) in enumerate(IOS_SIZES):
        # Resize image
        resized = original.resize((int(width), int(height)), Image.Resampling.LANCZOS)
        
        # Save with appropriate name
        if i == len(IOS_SIZES) - 1:  # App Store icon
            filename = 'AppStore.png'
        else:
            filename = f'Icon-App-{width}x{height}@{"2x" if i % 2 else "1x"}.png'
        
        resized.save(f'ios/Runner/Assets.xcassets/AppIcon.appiconset/{filename}')
        print(f"Generated {filename} ({width}x{height})")

def main():
    print("Starting icon generation...")
    generate_android_icons()
    generate_ios_icons()
    print("\nIcon generation complete!")

if __name__ == '__main__':
    main() 