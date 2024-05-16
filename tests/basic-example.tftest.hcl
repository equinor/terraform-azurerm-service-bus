run "basic_example_plan" {
  command = plan

  module {
    source = "./examples/basic"
  }
}

run "basic_example_apply" {
  command = apply

  module {
    source = "./examples/basic"
  }
}
