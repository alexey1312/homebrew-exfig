class Exfig < Formula
  desc "Export colors, typography, icons, and images from Figma to Xcode, Android, Flutter, and Web"
  homepage "https://github.com/alexey1312/ExFig"
  version "1.2.18"
  license "MIT"

  on_macos do
    url "https://github.com/alexey1312/ExFig/releases/download/v#{version}/exfig-macos.zip"
    sha256 "66d02b8213c50f3f3289b59d526bb744942dfa620e6525e8c5ef491edc20ee0a"

    depends_on macos: :monterey
  end

  on_linux do
    url "https://github.com/alexey1312/ExFig/releases/download/v#{version}/exfig-linux-x64.tar.gz"
    sha256 "38f3c23aaf751c822dfacb28e44c8473930e3c2f9c2b05a9613111dc64d4dd36"
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
