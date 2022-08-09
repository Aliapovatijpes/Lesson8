resource "aws_vpc" "intern_vpc" {
  cidr_block       = "10.0.0.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "intern-vpc"
  }
}
resource "aws_subnet" "intern_subnet" {
  vpc_id                  = "${aws_vpc.intern_vpc.id}"
  cidr_block              = "10.0.0.0/28"
  map_public_ip_on_launch = "true" 
  availability_zone       = "eu-central-1a"
  tags = {
    Name = "intern_subnet"
  }
}
resource "aws_internet_gateway" "intern_gateway" {
    vpc_id = "${aws_vpc.intern_vpc.id}"
    tags = {
        Name = "intern_gateway"
    }
}
resource "aws_route_table" "intern_routetable" {
    vpc_id = "${aws_vpc.intern_vpc.id}"
    
    route {
            cidr_block = "0.0.0.0/0"        
        gateway_id = "${aws_internet_gateway.intern_gateway.id}" 
    }
    
    tags = {
        Name = "intern_routetable"
    }
}
resource "aws_route_table_association" "intern_rtassociation"{
    subnet_id = "${aws_subnet.intern_subnet.id}"
    route_table_id = "${aws_route_table.intern_routetable.id}"
   
}

resource "aws_security_group" "intern_securitygroup" {
    vpc_id = "${aws_vpc.intern_vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }    
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"        
        cidr_blocks = ["0.0.0.0/0"]
       
    }  
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
   
    }    
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
   
    }    
    tags = {
        Name = "intern_securitygroup"
    }
}