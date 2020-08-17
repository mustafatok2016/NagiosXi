resource "null_resource"  "commands" {
    depends_on = ["aws_instance.web"]
    triggers = {
        always_run = "${timestamp()}"
    }
    # Push files  to remote server
    # provisioner "file" {
    #     connection {
    #     host = "${aws_instance.web.public_ip}"
    #     type = "ssh"
    #     user = "centos"
    #     private_key = "${file("~/.ssh/id_rsa")}"
    #     }
    #     source      = "r1soft.repo"
    #     destination = "/tmp/r1soft.repo"
    # }
    # Execute linux commands on remote machine
    provisioner "remote-exec" {
        connection {
        host = "${aws_instance.web.public_ip}"
        type = "ssh"
        user = "centos"
        private_key = "${file("~/.ssh/id_rsa")}"
    }
    inline = [
        "sudo su -",
        "sudo yum install curl -y ",
        "sudo curl https://assets.nagios.com/downloads/nagiosxi/install.sh |sudo sh",
        
        
        
        ]
    }
}