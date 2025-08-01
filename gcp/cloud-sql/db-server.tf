resource "google_sql_database_instance" "my-database" {
  name                = "db-server"
  database_version    = "MYSQL_8_0"
  region              = "us-central1"
  deletion_protection = false

  settings {
    tier = "db-f1-micro"
  }
}