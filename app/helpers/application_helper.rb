module ApplicationHelper
  
  def truncate(words, limit)
    if words.nil?
      return
    end
    string_arr = words.split(' ')
    string_arr.count > limit ? "#{string_arr[0..(limit-1)].join(' ')}..." : words
  end
  
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
  

  def link_to_add_nested_fields(name, parent_form_builder, association, opts={}, &block)
    opts[:link_attributes]||={}
    new_object = parent_form_builder.object.send(association).klass.new
    id = new_object.object_id
    fields = parent_form_builder.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", builder: builder)
    end
    link_params = {class: "add-fields #{opts[:class]}", data: {id: id, fields: fields.gsub("\n", "")}}.merge(opts[:link_attributes])
    if name.blank?
      link_to('#', link_params, &block)
    else
      link_to(name, link_params, &block)
    end
  end
  
  
end
