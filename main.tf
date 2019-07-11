resource "null_resource" "cluster" {
  provisioner "local-exec" {
    command = "curl -s https://ip-ranges.atlassian.com/ | jq .items[] | jq .cidr | grep -v : > test.txt"
  }
}

data "local_file" "foo" {
  filename = "test.txt"

  depends_on = ["null_resource.cluster"]
}

output content {
  value = "${data.local_file.foo.content}"
}
