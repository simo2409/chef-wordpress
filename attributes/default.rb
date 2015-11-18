default["wordpress"] = {
  "latest_zip_url"    => "https://wordpress.org/latest.zip",
  "destination_path"  => "/var/www/html/miosito",
  "ownership" => {
    "user"  => "deployer",
    "group" => "deployer"
  },
  "database" => {
    "db_name"      => "",
    "db_user"      => "",
    "db_password"  => "",
    "db_host"      => "",
    "db_charset"   => "utf8",
    "db_collate"   => "",
    "table_prefix" => "wp_"
  },
  "wp_debug" => false
}
