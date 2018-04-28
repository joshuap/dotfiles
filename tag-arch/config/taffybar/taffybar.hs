import System.Taffybar

import System.Taffybar.Systray
import System.Taffybar.TaffyPager
import System.Taffybar.Pager (colorize, wrap, escape)
import System.Taffybar.SimpleClock
import System.Taffybar.FreedesktopNotifications
import System.Taffybar.MPRIS
import System.Taffybar.MPRIS2
import System.Taffybar.NetMonitor
import System.Taffybar.Battery

import System.Taffybar.Widgets.PollingBar
import System.Taffybar.Widgets.PollingGraph

import System.Information.Memory
import System.Information.CPU

memCallback = do
  mi <- parseMeminfo
  return [memoryUsedRatio mi]

cpuCallback = do
  (userLoad, systemLoad, totalLoad) <- cpuLoad
  return [totalLoad, systemLoad]

main = do
  let memCfg = defaultGraphConfig { graphDataColors = [(1, 0, 0, 1)]
                                  , graphLabel = Just "mem"
                                  }
      cpuCfg = defaultGraphConfig { graphDataColors = [ (0, 1, 0, 1)
                                                      , (1, 0, 1, 0.5)
                                                      ]
                                  , graphLabel = Just "cpu"
                                  }
  let clock = textClockNew Nothing "<span fgcolor='#98c379'>%a %b %_d %H:%M</span>" 1
      pager = taffyPagerNew defaultPagerConfig { activeWorkspace = colorize "#e06c75" "" . escape
                                                 , urgentWorkspace = colorize "#be5046" "#e5c07b" . wrap "[" "]" . escape
                                                 , emptyWorkspace = escape
                                               }
      note = notifyAreaNew defaultNotificationConfig { notificationMaxTimeout = 5 }
      mpris = mpris2New
      mem = pollingGraphNew memCfg 1 memCallback
      cpu = pollingGraphNew cpuCfg 0.5 cpuCallback
      -- TODO: Monitor multiple interfaces (available on master)
      -- net = netMonitorMultiNew 1.5 [ "wlp4s0", "eth0" ]
      net = netMonitorNew 1.5 "wlp4s0"
      tray = systrayNew
      bat = batteryBarNew defaultBatteryConfig 30
  defaultTaffybar defaultTaffybarConfig { startWidgets = [ pager, note ]
                                        , endWidgets = [ tray, clock, bat, mem, cpu, net, mpris ]
                                        }
