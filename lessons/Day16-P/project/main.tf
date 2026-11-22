locals {
  users = csvdecode(file("users.csv"))
}

# Output user names
output "user_names" {
  value = [for user in local.users : "${user.first_name} ${user.last_name}"]
}

# IAM user creation
resource "aws_iam_user" "iam_user" {

  #   for_each = { for user in local.users : user.first_name => user }
  #   name     = lower("${substr(each.value.first_name, 0, 1)}${each.value.last_name}")
  #   path     = "/users/"

  #   tags = {
  #     "DisplayName" = "${each.value.first_name} ${each.value.last_name}"
  #     "Department"  = each.value.department
  #     "JobTitle"    = each.value.job_title
  #   }

  count = length(local.users)

  name = lower(
    "${substr(local.users[count.index].first_name, 0, 1)}${local.users[count.index].last_name}-${count.index + 1}"
  )

  path = "/users/"

  tags = {
    DisplayName = "${local.users[count.index].first_name} ${local.users[count.index].last_name}"
    Department  = local.users[count.index].department
    JobTitle    = local.users[count.index].job_title
  }
}
