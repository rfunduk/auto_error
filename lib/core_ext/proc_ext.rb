class Proc
  def bind(object)
    block = self
    object.class_eval do
      method_name = :__proc_rebound_method__
      method = nil
      Thread.exclusive do
        method_already_exists =
          object.respond_to?(method_name) &&
          instance_method(method_name).owner == self

        old_method = instance_method(method_name) if method_already_exists

        define_method(method_name, &block)
        method = instance_method(method_name)
        remove_method(method_name)

        define_method(method_name, old_method) if method_already_exists
      end
      method
    end.bind(object)
  end
end
