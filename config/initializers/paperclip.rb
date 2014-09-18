Paperclip::Attachment.default_options.merge!(
  url:                  ':s3_domain_url',
  styles: { :normal => "100%",:small => "100 x100>",:medium => "200x200>", :thumb => "50x50>", spacer: "x50" },
  path:                 ':class/:attachment/:id/:style/:filename',
  storage:              :s3,
  s3_credentials:       Rails.configuration.aws,
  s3_permissions:       :private,
  s3_protocol:          'https'
)