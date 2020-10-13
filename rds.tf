

//Creating The Security Grp For RDS

//Creating The Security Group And Allowing The HTTP and SSH
resource "aws_security_group" "rds-sec-grp" {

  name        = "RDS-Securty-Grp"
  description = "Allow MySQL Ports"
 
  ingress {
    description = "Allowing Connection for SSH"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS-Server"
  }
}


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Creating the RDS instances template

resource "aws_db_instance" "rds" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "wp"
  password             = "wordpress123"
  parameter_group_name = "default.mysql5.7"
  publicly_accessible = true
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.rds-sec-grp.id]
  tags = {
  name = "RDS_Main"
   }
}