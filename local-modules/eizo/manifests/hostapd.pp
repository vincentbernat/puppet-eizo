class eizo::hostapd(
  $ssid,
  $interface,
  $channel,
  $driver         = "nl80211",
  $hw_mode        = "g",
  $wpa            = 2,
  $wpa_passphrase,
  $wpa_key_mgmt   = "WPA-PSK",
  $wpa_pairwise   = "TKIP",
  $rsn_pairwise   = "CCMP",
  $extra          = {}) {

  class { '::eizo::hostapd::install': } ->
  class { '::eizo::hostapd::config':  } ~>
  class { '::eizo::hostapd::service': } ->
  Class [ '::eizo::hostapd' ]

}
