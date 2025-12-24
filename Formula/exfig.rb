class Exfig < Formula
  desc "Export colors, typography, icons, and images from Figma to Xcode, Android, Flutter, and Web"
  homepage "https://github.com/alexey1312/ExFig"
  version "1.2.10"
  license "MIT"

  on_macos do
    url "https://github.com/alexey1312/ExFig/releases/download/v#{version}/exfig-macos.zip"
    sha256 "dfabce177f2635f93d0f5fa55b70d701d3d87039f4d7f39d5cd1ecafc0f4a157"

    depends_on macos: :monterey
  end

  on_linux do
    url "https://github.com/alexey1312/ExFig/releases/download/v#{version}/exfig-linux-x64.tar.gz"
    sha256 "a4e822fcc23948d685a9f5fb939a5953a7d339996a4333a94d013fd3494eb291"
  end

  def install
    # Binary and bundles must be co-located for Bundle.module to find templates
    libexec.install "ExFig" => "exfig"
    libexec.install Dir["exfig_*.bundle"]     # macOS resource bundles
    libexec.install Dir["exfig_*.resources"]  # Linux resource bundles

    # Symlink to bin for PATH access
    bin.install_symlink libexec/"exfig"
  end

  def caveats
    <<~EOS
      Set your Figma Personal Access Token:
        export FIGMA_PERSONAL_TOKEN=your_token_here

      Get your token from: https://www.figma.com/developers/api#access-tokens
    EOS
  end

  test do
    assert_match "exfig", shell_output("#{bin}/exfig --version")
  end
end
