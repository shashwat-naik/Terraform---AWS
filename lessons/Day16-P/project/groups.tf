# IAM Group
resource "aws_iam_group" "iam_grp" {
  for_each = toset([
    for user in local.users : lower(replace(user.department, " ", "-"))
  ])
  name = each.value
  path = "/groups/"
}

# IAM user assign to group
resource "aws_iam_group_membership" "team" {
  for_each = aws_iam_group.iam_grp

  name = "membership-${each.key}"

  users = [
    for index, user in local.users :
    aws_iam_user.iam_user[index].name
    if lower(replace(user.department, " ", "-")) == each.key
  ]

  group = each.value.name
}
