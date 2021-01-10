resource "google_compute_backend_service" "backend_service" {
  name        = "${var.project}-backend-service"
  protocol    = "HTTP"
  timeout_sec = 10

  dynamic "backend" {
    for_each = var.regions
    content {
      group           = var.instance_group[backend.value].instance_group
      balancing_mode  = "UTILIZATION"
      capacity_scaler = 1.0
    }
  }
  
  health_checks = [google_compute_http_health_check.health_check.id]
}

resource "google_compute_http_health_check" "health_check" {
  name         = "${var.project}-health-check"
  request_path = "/"

  timeout_sec        = 1
  check_interval_sec = 1
}

resource "google_compute_url_map" "url_map" {
  name            = "${var.project}-load-balancer"
  default_service = google_compute_backend_service.backend_service.id
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "test-proxy"
  url_map = google_compute_url_map.url_map.id
}

resource "google_compute_global_forwarding_rule" "forwarding-rule" {
  name       = "global-rule"
  target     = google_compute_target_http_proxy.http_proxy.id
  port_range = "80"
}
