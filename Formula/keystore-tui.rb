class KeystoreTui < Formula
  desc "Read-only terminal UI for inspecting JKS, JCEKS, and PKCS12 keystores, certificates, and certificate requests"
  homepage "https://github.com/codecraft21/keystore-tui"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/codecraft21/keystore-tui/releases/download/v1.0.0/keystore-tui-aarch64-apple-darwin.tar.xz"
      sha256 "0c0959d4714fa735b69e4ce329fe1181c99c02c1960815820d7d9238cd57b789"
    end
    if Hardware::CPU.intel?
      url "https://github.com/codecraft21/keystore-tui/releases/download/v1.0.0/keystore-tui-x86_64-apple-darwin.tar.xz"
      sha256 "ead389e40bbd3fbde539b755e8965ff48302c56c65ef7567f064c89e96d4f435"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/codecraft21/keystore-tui/releases/download/v1.0.0/keystore-tui-aarch64-unknown-linux-musl.tar.xz"
      sha256 "cf4c93edc1c6048c20d10468d2f4e43a6869a55a0268192cba75effa3325a829"
    end
    if Hardware::CPU.intel?
      url "https://github.com/codecraft21/keystore-tui/releases/download/v1.0.0/keystore-tui-x86_64-unknown-linux-musl.tar.xz"
      sha256 "9fe71140251fe77e3be86ea5d40739081ec3ecf7bf43a97727c688000ff7fbea"
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
