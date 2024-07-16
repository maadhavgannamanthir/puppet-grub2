# class: grub2::update: See README for documentation
class grub2::update inherits grub2 {
  $config_file_subscribe = $grub2::manage_config_file ? {
    true  => [File[$grub2::config_file]],
    false => []
  }

  $password_file_subscribe = $grub2::password ? {
    true  => [File[$grub2::password_file]],
    false => []
  }

  $exec_subscribe = concat($config_file_subscribe, $password_file_subscribe)

  if $grub2::update_grub {
    exec { 'Update GRUB':
      command     => $grub2::update_binary,
      subscribe   => $exec_subscribe,
      refreshonly => true,
    }
  }
}
