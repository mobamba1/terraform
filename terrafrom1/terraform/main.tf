# Provider

provider "aws" {
  region = "eu-west-1"
}

module "aws_vpc" {
  source   = "./VPC"
  VPC_Name = "ProjectVPC"
}

module "aws_security_group" {
  source = "./SecurityGroup"
  name   = "Project Security Group"
  vpc_id = module.aws_vpc.VPC_ID
}

module "aws_eks_cluster" {
  source                 = "./Cluster"
  public_subnet_id_1     = module.aws_vpc.Subnet_ID
  public_subnet_id_2     = module.aws_vpc.Subnet_ID1
  vpc_security_group_ids = module.aws_security_group.SecurityGroup_id

}

module "aws_eks_nodes" {
  source             = "./Nodes"
  public_subnet_id_1 = module.aws_vpc.Subnet_ID
  public_subnet_id_2 = module.aws_vpc.Subnet_ID1
  cluster_name       = module.aws_eks_cluster.cluster-name
}
