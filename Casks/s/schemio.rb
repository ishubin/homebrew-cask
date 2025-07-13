cask "schemio" do
  arch arm: "arm64"
  version "0.26.6"
  sha256 "294847653f8a699169a9f7155b5be984e81ab63f199fd6349952cea3a07d9985"

  url "https://github.com/ishubin/schemio/releases/download/v#{version}/schemio-macos-arm64-#{version}.zip"
  name "Schemio"
  desc "Interactive diagramming and prototyping software"
  homepage "https://schem.io/"

  no_autobump! because: :requires_manual_review

  app "schemio.app"

end
