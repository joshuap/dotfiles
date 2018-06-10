module Main where

import           System.Taffybar
import           System.Taffybar.Hooks
import           System.Taffybar.Information.CPU
import           System.Taffybar.Information.Memory
import           System.Taffybar.SimpleConfig
import           System.Taffybar.Widget
import           System.Taffybar.Widget.Generic.PollingGraph
import           System.Taffybar.Widget.Workspaces
import           System.Taffybar.Widget.SNITray
import           System.Taffybar.DBus
import           Control.Monad.IO.Class
import qualified Graphics.UI.Gtk as Gtk

transparent = (0.0, 0.0, 0.0, 0.0)
yellow1 = (0.9453125, 0.63671875, 0.2109375, 1.0)
yellow2 = (0.9921875, 0.796875, 0.32421875, 1.0)
green1 = (0, 1, 0, 1)
green2 = (1, 0, 1, 0.5)
red = (1, 0, 0, 1)
taffyBlue = (0.129, 0.588, 0.953, 1)

memCallback = do
  mi <- parseMeminfo
  return [memoryUsedRatio mi]

cpuCallback = do
  (userLoad, systemLoad, totalLoad) <- cpuLoad
  return [totalLoad, systemLoad]

main = do
  let memCfg = defaultGraphConfig
               { graphDataColors = [red]
               , graphLabel = Just "mem"
               }
      cpuCfg = defaultGraphConfig
               { graphDataColors = [green1, green2]
               , graphLabel = Just "cpu"
               }
      netCfg = defaultGraphConfig
               { graphDataColors = [yellow1, yellow2]
               , graphLabel = Just "net"
               }
  let clock = textClockNew Nothing "<span fgcolor='#b8bb26'>%a %b %_d %H:%M</span>" 1
      workspaces = workspacesNew defaultWorkspacesConfig
      windows = windowsNew defaultWindowsConfig
      layout = layoutNew defaultLayoutConfig
      note = notifyAreaNew defaultNotificationConfig
      mpris = mpris2New
      mem = pollingGraphNew memCfg 1 memCallback
      cpu = pollingGraphNew cpuCfg 0.5 cpuCallback
      net = networkGraphNew netCfg Nothing
      -- tray = sniTrayNew
      tray = sniTrayNew >>= (\widget -> (liftIO $ Gtk.widgetShowAll widget) >> return widget)
  dyreTaffybar $ withBatteryRefresh $ withLogServer $ toTaffyConfig defaultSimpleTaffyConfig
                   { startWidgets = [ workspaces, layout, windows, note ]
                   , endWidgets = map (>>= buildPadBox) [ batteryIconNew, clock, tray, mem, cpu, net, mpris ]
                   -- , endWidgets = [ clock, mem, cpu, mpris ]
                   , barHeight = 45
                   }
