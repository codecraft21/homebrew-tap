class KeystoreTui < Formula
  desc "Read-only terminal UI for inspecting JKS, JCEKS, and PKCS12 keystores, certificates, and certificate requests"
  homepage "https://github.com/codecraft21/keystore-tui"
  version "1.0.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/codecraft21/keystore-tui/releases/download/v1.0.4/keystore-tui-aarch64-apple-darwin.tar.xz"
      sha256 "0d86c29c37be32cafedb60336a46db8075f721d1200fa8bd08e44b008b4c27c5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/codecraft21/keystore-tui/releases/download/v1.0.4/keystore-tui-x86_64-apple-darwin.tar.xz"
      sha256 "badd25f4146b4019c2d25a2b2f649e5722a391e58aac91db649122e087eba83b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/codecraft21/keystore-tui/releases/download/v1.0.4/keystore-tui-aarch64-unknown-linux-musl.tar.xz"
      sha256 "812877e509000a850ac3b2264d16cb62ac2e87ff36d99e450d0ad82851691324"
    end
    if Hardware::CPU.intel?
      url "https://github.com/codecraft21/keystore-tui/releases/download/v1.0.4/keystore-tui-x86_64-unknown-linux-musl.tar.xz"
      sha256 "e628cc0d2d469137e9bc22b60d37532d9b56191984f8bb2537f15262b198cfab"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "keystore-tui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "keystore-tui"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "keystore-tui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "keystore-tui"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
