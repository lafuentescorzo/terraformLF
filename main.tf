# Crear VPC
resource "aws_vpc" "mi_vpc" {
    cidr_block = "10.1.0.0/16"

    tags = {
        Name = "Mi-VPC"
    }
}

# Subredes públicas
resource "aws_subnet" "publica_subnet1" {
    vpc_id            = aws_vpc.mi_vpc.id
    cidr_block        = "10.1.1.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "Publica-1"
    }
}

resource "aws_subnet" "publica_subnet2" {
    vpc_id            = aws_vpc.mi_vpc.id
    cidr_block        = "10.1.2.0/24"
    availability_zone = "us-east-1b"

    tags = {
        Name = "Publica-2"
    }
}

# Subredes privadas
resource "aws_subnet" "privada_subnet1" {
    vpc_id            = aws_vpc.mi_vpc.id
    cidr_block        = "10.1.3.0/24"
    availability_zone = "us-east-1c"

    tags = {
        Name = "Privada-1"
    }
}

resource "aws_subnet" "privada_subnet2" {
    vpc_id            = aws_vpc.mi_vpc.id
    cidr_block        = "10.1.4.0/24"
    availability_zone = "us-east-1d"

    tags = {
        Name = "Privada-2"
    }
}

# Crear Internet Gateway
resource "aws_internet_gateway" "mi_gateway" {
    vpc_id = aws_vpc.mi_vpc.id

    tags = {
        Name = "Mi-Gateway"
    }
}

# Tabla de rutas para subredes públicas
resource "aws_route_table" "publica_routing_table" {
    vpc_id = aws_vpc.mi_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.mi_gateway.id
    }

    tags = {
        Name = "Tabla-de-Rutas-Publica"
    }
}

# Asociaciones de tabla de rutas para subredes públicas
resource "aws_route_table_association" "publica_subnet1_assoc" {
    subnet_id      = aws_subnet.publica_subnet1.id
    route_table_id = aws_route_table.publica_routing_table.id
}

resource "aws_route_table_association" "publica_subnet2_assoc" {
    subnet_id      = aws_subnet.publica_subnet2.id
    route_table_id = aws_route_table.publica_routing_table.id
}

# Tabla de rutas para subredes privadas (sin ruta a Internet)
resource "aws_route_table" "privada_routing_table" {
    vpc_id = aws_vpc.mi_vpc.id

    tags = {
        Name = "Tabla-de-Rutas-Privada"
    }
}

# Asociaciones de tabla de rutas para subredes privadas
resource "aws_route_table_association" "privada_subnet1_assoc" {
    subnet_id      = aws_subnet.privada_subnet1.id
    route_table_id = aws_route_table.privada_routing_table.id
}

resource "aws_route_table_association" "privada_subnet2_assoc" {
    subnet_id      = aws_subnet.privada_subnet2.id
    route_table_id = aws_route_table.privada_routing_table.id
}
