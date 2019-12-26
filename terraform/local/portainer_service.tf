//resource "docker_volume" "portainer" {
//  name = "portainer"
//}

//resource "docker_service" "portainer" {
//  name = "portainer"
//  task_spec {
//    container_spec {
//      image    = var.portainer_image
//      hostname = "portainer"
////      command  = ["-H tcp://tasks.agent:9001 --tlsskipverify"]
//      mounts {
//        target = "/data"
//        source = docker_volume.portainer.name
//        type   = "volume"
//      }
//      mounts {
//        target = "/var/run/docker.sock"
//        source = "/var/run/docker.sock"
//        type   = "bind"
//      }
//      labels = {
//        "traefik.enable" = "true"
//        "traefik.http.routers.portainer.rule" = "Host(`localhost`)"
//        "traefik.http.routers.portainer.entrypoints" = "web"
//        "traefik.port" = 9000
////        "traefik.http.services.portainer.loadbalancer.server.port" = 80
//      }
//    }
//    restart_policy = {
//      condition = "on-failure"
//      "max_attempts" = "3"
//    }
//    placement {
//      constraints = [
//        "node.role==manager",
//      ]
//    }
//    resources {
//      limits {
//        nano_cpus    = 100000000 // 0.1 cpus
//        memory_bytes = 134217728 // 128 Mb
//      }
//      reservation {
//        nano_cpus    = 50000000 // 0.05 cpus
//        memory_bytes = 10485760 // 10 Mb
//      }
//    }
//    networks = [docker_network.public.id, docker_network.private.id]
//  }
//  mode {
//    replicated {
//      replicas = 1
//    }
//  }
//  endpoint_spec {
//    ports {
//      target_port    = 9000
//      published_port = 9000
//    }
//    ports {
//      target_port    = 8000
//      published_port = 8000
//    }
//  }
//}


//resource "docker_service" "portainer_agent" {
//  name = "portainer_agent"
//  task_spec {
//    container_spec {
//      image = "portainer/agent:1.5.1"
//      mounts {
//        target = "/var/lib/docker/volumes"
//        source = "/var/lib/docker/volumes"
//        type   = "bind"
//      }
//      mounts {
//        target = "/var/run/docker.sock"
//        source = "/var/run/docker.sock"
//        type   = "bind"
//      }
//      env = {
//        AGENT_CLUSTER_ADDR = "tasks.agent"
//      }
//    }
//    networks = [docker_network.private.id]
//    placement {
//      constraints = [
//        "node.platform.os == linux",
//      ]
//    }
//    resources {
//      limits {
//        nano_cpus    = 100000000 // 0.1 cpus
//        memory_bytes = 134217728 // 128 Mb
//      }
//      reservation {
//        nano_cpus    = 50000000 // 0.05 cpus
//        memory_bytes = 10485760 // 10 Mb
//      }
//    }
//    restart_policy = {
//      condition = "on-failure"
//    }
//  }
//  mode {
//    global = true
//  }
//}
