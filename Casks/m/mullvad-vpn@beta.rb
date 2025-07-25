cask "mullvad-vpn@beta" do
  version "2025.7"
  sha256 "79aca2cb6406053a403d337e971919dacaa07575a5575ebf833426e90640f53a"

  url "https://cdn.mullvad.net/app/desktop/releases/#{version}/MullvadVPN-#{version}.pkg"
  name "Mullvad VPN"
  desc "VPN client"
  homepage "https://mullvad.net/"

  livecheck do
    url "https://api.mullvad.net/app/releases/macos.json"
    strategy :json do |json|
      json.dig("signed", "releases")&.map { |release| release["version"] }
    end
  end

  conflicts_with cask: "mullvad-vpn"
  depends_on macos: ">= :ventura"

  pkg "MullvadVPN-#{version}.pkg"

  uninstall launchctl: "net.mullvad.daemon",
            quit:      "net.mullvad.vpn",
            script:    {
              executable:   "/Applications/Mullvad VPN.app/Contents/Resources/mullvad-setup",
              args:         ["reset-firewall"],
              sudo:         true,
              must_succeed: false,
            },
            pkgutil:   "net.mullvad.vpn",
            delete:    [
              "/etc/mullvad-vpn",
              "/Library/Caches/mullvad-vpn",
              "/opt/homebrew/share/fish/vendor_completions.d/mullvad.fish",
              "/opt/homebrew/share/zsh/site-functions/_mullvad",
              "/usr/local/bin/mullvad",
              "/usr/local/bin/mullvad-problem-report",
              "/usr/local/share/fish/vendor_completions.d/mullvad.fish",
              "/usr/local/share/zsh/site-functions/_mullvad",
              "/var/log/mullvad-vpn",
            ]

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/net.mullvad.vpn.sfl*",
    "~/Library/Application Support/Mullvad VPN",
    "~/Library/Logs/Mullvad VPN",
    "~/Library/Preferences/net.mullvad.vpn.helper.plist",
    "~/Library/Preferences/net.mullvad.vpn.plist",
  ]
end
