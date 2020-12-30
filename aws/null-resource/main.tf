resource "null_resource" "run_script" {
    triggers = {
        time = timestamp()
    }

    provisioner "local-exec" {
        command = "echo ${self.triggers.time}"
    }

    provisioner "local-exec" {
        command = "bash run.sh"
    }
}