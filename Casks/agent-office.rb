cask "agent-office" do
  arch arm: "arm64", intel: "x64"

  version "0.2.1"
  sha256 arm:   "3e0a0cf9527c622c15cfc288c3af084128afd50514b63fe982b52959bb3c66cf",
         intel: "49087750866ddbbedb6a7922b45c7d96c857466a83e163f5d867e0ce9a00f3ad"

  url "https://github.com/isisever/agent-office/releases/download/v#{version}/AgentOffice-#{version}-#{arch}.dmg"
  name "Agent Office"
  desc "Pixel-art office for Claude Code agents, with a terminal per project"
  homepage "https://github.com/isisever/agent-office"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "Agent Office.app"

  zap trash: [
    "~/.claude/agent-office",
    "~/Library/Application Support/Agent Office",
    "~/Library/Preferences/io.github.isisever.agentoffice.plist",
    "~/Library/Saved Application State/io.github.isisever.agentoffice.savedState",
  ]

  caveats <<~EOS
    Agent Office runs the Claude Code CLI; install it first if needed:
      https://code.claude.com

    The app is not notarized by Apple yet. If macOS blocks the first launch, open
    System Settings → Privacy & Security and click "Open Anyway", or run:
      xattr -dr com.apple.quarantine "#{appdir}/Agent Office.app"
  EOS
end
