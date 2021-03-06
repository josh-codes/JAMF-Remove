# This tool removes all the JAMF bloat and spyware without removing self service.
clear
echo "This tool removes all the JAMF bloat and spyware without removing self service."
echo "Starting..."
# Clear blacklist
echo "Enter your password"
sudo rm /Library/Application\ Support/JAMF/.jmf_settings.json
sudo touch /Library/Application\ Support/JAMF/.jmf_settings.json
sudo chown $USER /Library/Application\ Support/JAMF/.jmf_settings.json
echo '{
  "networkStateChange" : false,
  "blacklist" : [

  ],
  "applicationUsage" : false,
  "beaconMonitoring" : false
}' > /Library/Application\ Support/JAMF/.jmf_settings.json
echo "Cleared blacklist ☑️"
# Remove Hooks
sudo rm -rf /Library/Application\ Support/JAMF/ManagementFrameworkScripts\
echo "Removed hooks ☑️"
echo "Stoping daemonds"
sudo launchctl unload /Library/LaunchAgents/com.jamf.management.agent.plist || echo "[ERROR] Daemond not running"
sudo launchctl unload /Library/LaunchAgents/com.jamfsoftware.jamf.agent.plist || echo "[ERROR] Daemond not running"
sudo launchctl unload /Library/LaunchDaemons/com.jamf.management.daemon.plist || echo "[ERROR] Daemond not running"
sudo launchctl unload /Library/LaunchDaemons/com.jamfsoftware.task.1.plist || echo "[ERROR] Daemond not running"
sudo launchctl unload /Library/LaunchDaemons/com.jamfsoftware.startupItem.plist || echo "[ERROR] Daemond not running"
echo "Stopped daemonds ☑️"
# Remove Launch Agents
sudo rm /Library/LaunchAgents/com.jamf.management.agent.plist || echo ""
sudo rm /Library/LaunchAgents/com.jamfsoftware.jamf.agent.plist || echo ""
echo "Removed launch agents ☑️"
# Remove Launch Daemons
sudo rm /Library/LaunchDaemons/com.jamf.management.daemon.plist || echo ""
sudo rm /Library/LaunchDaemons/com.jamfsoftware.task.1.plist || echo ""
sudo rm /Library/LaunchDaemons/com.jamfsoftware.startupItem.plist || echo ""
echo "Removed launch daemons ☑️"
# Reboot
echo "Rebooting in 3, press control+c to cancel"
sleep 3s
sudo shutdown -r now
