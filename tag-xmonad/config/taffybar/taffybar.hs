module Main where

import           System.Taffybar
import           System.Taffybar.Information.CPU
import           System.Taffybar.Information.Memory
import           System.Taffybar.SimpleConfig
import           System.Taffybar.Widget
import           System.Taffybar.Widget.Generic.PollingGraph
import           System.Taffybar.Widget.Workspaces
import           System.Taffybar.Widget.SNITray

memCallback = do
  mi <- parseMeminfo
  return [memoryUsedRatio mi]

cpuCallback = do
  (userLoad, systemLoad, totalLoad) <- cpuLoad
  return [totalLoad, systemLoad]

main = do
  let memCfg = defaultGraphConfig
               { graphDataColors = [(1, 0, 0, 1)]
               , graphLabel = Just "mem"
               }
      cpuCfg = defaultGraphConfig
               { graphDataColors =
                   [ (0, 1, 0, 1)
                   , (1, 0, 1, 0.5)
                   ]
               , graphLabel = Just "cpu"
               }
  let clock = textClockNew Nothing "<span fgcolor='orange'>%a %b %_d %H:%M</span>" 1
      workspaces = workspacesNew defaultWorkspacesConfig
      windows = windowsNew defaultWindowsConfig
      layout = layoutNew defaultLayoutConfig
      note = notifyAreaNew defaultNotificationConfig
      mpris = mpris2New
      mem = pollingGraphNew memCfg 1 memCallback
      cpu = pollingGraphNew cpuCfg 0.5 cpuCallback
      tray = sniTrayNew
  simpleTaffybar defaultSimpleTaffyConfig
                   { startWidgets = [ workspaces, layout, windows, note ]
                   , endWidgets = [ tray, clock, mem, cpu, mpris ]
                   -- , endWidgets = [ clock, mem, cpu, mpris ]
                   , barHeight = 40
                   }
