##########################
# EFS for media storage. #
##########################

# Main EFS File System
resource "aws_efs_file_system" "media" {
  encrypted = true

  tags = {
    Name = "${local.prefix}-media"
  }
}

# Security Group for EFS (allows NFS from ECS)
resource "aws_security_group" "efs" {
  name   = "${local.prefix}-efs"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 2049
    to_port   = 2049
    protocol  = "tcp"

    security_groups = [
      aws_security_group.ecs_service.id
    ]
  }
}

# Mount target A
resource "aws_efs_mount_target" "media_a" {
  file_system_id  = aws_efs_file_system.media.id
  subnet_id       = aws_subnet.private_a.id
  security_groups = [aws_security_group.efs.id]
}

# Mount target B
resource "aws_efs_mount_target" "media_b" {
  file_system_id  = aws_efs_file_system.media.id
  subnet_id       = aws_subnet.private_b.id
  security_groups = [aws_security_group.efs.id]
}

# Access Point with correct directory + permissions
resource "aws_efs_access_point" "media" {
  file_system_id = aws_efs_file_system.media.id

  root_directory {
    path = "/media"   # ECS will see this as /vol/web/media

    creation_info {
      owner_uid   = 1000      # django-user uid (correct)
      owner_gid   = 1000      # django-user gid (correct)
      permissions = "755"
    }
  }
}
